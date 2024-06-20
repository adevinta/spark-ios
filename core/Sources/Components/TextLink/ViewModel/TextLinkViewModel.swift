//
//  TextLinkViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 08/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation

// sourcery: AutoPublisherTest, AutoViewModelStub
// sourcery: imageTintColor = "Identical"
class TextLinkViewModel: ObservableObject {

    // MARK: - State Properties

    var theme: any Theme {
        didSet {
            self.updateContentAndImageSize()
        }
    }

    var text: String {
        didSet {
            guard self.text != oldValue else { return }
            self.contentDidUpdate()
        }
    }

    var textHighlightRange: NSRange? {
        didSet {
            guard self.textHighlightRange != oldValue else { return }
            self.contentDidUpdate()
        }
    }

    var intent: TextLinkIntent {
        didSet {
            guard self.intent != oldValue else { return }
            self.contentDidUpdate()
        }
    }

    var isHighlighted: Bool = false {
        didSet {
            guard self.isHighlighted != oldValue else { return }
            self.contentDidUpdate()
        }
    }

    var variant: TextLinkVariant {
        didSet {
            guard self.variant != oldValue else { return }
            self.contentDidUpdate()
        }
    }

    var typography: TextLinkTypography {
        didSet {
            guard self.typography != oldValue else { return }
            self.updateAll()
        }
    }

    var alignment: TextLinkAlignment {
        didSet {
            guard self.alignment != oldValue else { return }
            self.aligmentDidUpdate()
        }
    }

    // MARK: - Published Properties

    @Published private(set) var attributedText: AttributedStringEither?
    @Published private(set) var spacing: CGFloat = .zero
    @Published private(set) var imageSize: TextLinkImageSize?
    @Published private(set) var imageTintColor: any ColorToken = ColorTokenDefault.clear
    @Published private(set) var isTrailingImage: Bool = false

    // MARK: - Private Properties

    private let frameworkType: FrameworkType

    private var typographies: TextLinkTypographies?

    // MARK: - UseCases

    let getColorUseCase: TextLinkGetColorUseCaseable
    let getTypographiesUseCase: TextLinkGetTypographiesUseCaseable
    let getAttributedStringUseCase: TextLinkGetAttributedStringUseCaseable
    let getImageSizeUseCase: TextLinkGetImageSizeUseCaseable

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        theme: any Theme,
        text: String,
        textHighlightRange: NSRange?,
        intent: TextLinkIntent,
        typography: TextLinkTypography,
        variant: TextLinkVariant,
        alignment: TextLinkAlignment,
        getColorUseCase: TextLinkGetColorUseCaseable = TextLinkGetColorUseCase(),
        getTypographiesUseCase: TextLinkGetTypographiesUseCaseable = TextLinkGetTypographiesUseCase(),
        getAttributedStringUseCase: TextLinkGetAttributedStringUseCaseable = TextLinkGetAttributedStringUseCase(),
        getImageSizeUseCase: TextLinkGetImageSizeUseCaseable = TextLinkGetImageSizeUseCase()
    ) {
        self.frameworkType = frameworkType

        self.theme = theme
        self.text = text
        self.textHighlightRange = textHighlightRange
        self.intent = intent
        self.typography = typography
        self.variant = variant
        self.alignment = alignment

        self.getColorUseCase = getColorUseCase
        self.getTypographiesUseCase = getTypographiesUseCase
        self.getAttributedStringUseCase = getAttributedStringUseCase
        self.getImageSizeUseCase = getImageSizeUseCase

        // Load the values directly on init just for SwiftUI
        if frameworkType == .swiftUI {
            self.updateAll()
        }
    }

    // MARK: - Load

    func load() {
        // Update all values when UIKit view is ready to receive published values
        if self.frameworkType == .uiKit {
            self.updateAll()
        }
    }

    // MARK: - Internal Did Update

    func contentSizeCategoryDidUpdate() {
        /// The image size depend of the size of the font.
        /// So each time the content size category changed
        /// We must get the new value from the current dynanic font size
        self.imageSizeDidUpdate()
    }

    // MARK: - Private Did Update

    private func updateAll() {
        self.updateContentAndImageSize()
        self.aligmentDidUpdate()
    }

    private func updateContentAndImageSize() {
        self.contentDidUpdate(forceToReload: true)
        self.imageSizeDidUpdate()
    }

    private func contentDidUpdate(forceToReload: Bool = false) {
        let color = self.getColorUseCase.execute(
            intent: self.intent,
            isHighlighted: self.isHighlighted,
            colors: self.theme.colors
        )

        self.spacing = self.theme.layout.spacing.medium

        self.imageTintColor = color

        self.attributedText = self.getAttributedStringUseCase.execute(
            frameworkType: self.frameworkType,
            text: self.text,
            textColorToken: color,
            textHighlightRange: self.textHighlightRange,
            isHighlighted: self.isHighlighted,
            variant: self.variant,
            typographies: self.getTypographies(forceToReload: true)
        )
    }

    private func aligmentDidUpdate() {
        self.isTrailingImage = self.alignment.isTrailingImage
    }

    private func imageSizeDidUpdate() {
        self.imageSize = self.getImageSizeUseCase.execute(
            typographies: self.getTypographies()
        )
    }

    // MARK: - Private Getter

    private func getTypographies(forceToReload: Bool = false) -> TextLinkTypographies {
        if let typographies = self.typographies, !forceToReload {
            return typographies
        }

        let typographies = self.getTypographiesUseCase.execute(
            textLinkTypography: self.typography,
            typography: self.theme.typography
        )
        self.typographies = typographies

        return typographies
    }
}
