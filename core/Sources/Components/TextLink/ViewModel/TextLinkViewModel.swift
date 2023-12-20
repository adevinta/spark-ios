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

    // MARK: - Properties

    private(set) var theme: any Theme
    private(set) var text: String
    private(set) var textColorToken: any ColorToken
    private(set) var textHighlightRange: NSRange?
    private(set) var typography: TextLinkTypography
    private(set) var variant: TextLinkVariant
    private(set) var alignment: TextLinkAlignment

    // MARK: - Published Properties

    @Published private(set) var attributedText: AttributedStringEither?
    @Published private(set) var spacing: CGFloat?
    @Published private(set) var imageSize: TextLinkImageSize?
    @Published private(set) var imageTintColor: (any ColorToken)?
    @Published private(set) var isTrailingImage: Bool?

    // MARK: - Private Properties

    private let frameworkType: FrameworkType

    private var isHighlighted: Bool = false

    private var typographies: TextLinkTypographies?

    // MARK: - UseCases

    let getTypographiesUseCase: TextLinkGetTypographiesUseCaseable
    let getAttributedStringUseCase: TextLinkGetAttributedStringUseCaseable
    let getImageSizeUseCase: TextLinkGetImageSizeUseCaseable

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        theme: any Theme,
        text: String,
        textColorToken: any ColorToken,
        textHighlightRange: NSRange?,
        typography: TextLinkTypography,
        variant: TextLinkVariant,
        alignment: TextLinkAlignment,
        getTypographiesUseCase: TextLinkGetTypographiesUseCaseable = TextLinkGetTypographiesUseCase(),
        getAttributedStringUseCase: TextLinkGetAttributedStringUseCaseable = TextLinkGetAttributedStringUseCase(),
        getImageSizeUseCase: TextLinkGetImageSizeUseCaseable = TextLinkGetImageSizeUseCase()
    ) {
        self.frameworkType = frameworkType

        self.theme = theme
        self.text = text
        self.textColorToken = textColorToken
        self.textHighlightRange = textHighlightRange
        self.typography = typography
        self.variant = variant
        self.alignment = alignment

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

    // MARK: - Setter

    func set(theme: Theme) {
        self.theme = theme

        self.updateContentAndImageSize()
    }

    func set(text: String) {
        if self.text != text {
            self.text = text

            self.contentDidUpdate()
        }
    }

    func set(textColorToken: any ColorToken) {
        self.textColorToken = textColorToken

        self.contentDidUpdate()
    }

    func set(textHighlightRange: NSRange?) {
        if self.textHighlightRange != textHighlightRange {
            self.textHighlightRange = textHighlightRange

            self.contentDidUpdate()
        }
    }

    func set(isHighlighted: Bool) {
        if self.isHighlighted != isHighlighted {
            self.isHighlighted = isHighlighted

            self.contentDidUpdate()
        }
    }

    func set(variant: TextLinkVariant) {
        if self.variant != variant {
            self.variant = variant

            self.contentDidUpdate()
        }
    }

    func set(typography: TextLinkTypography) {
        if self.typography != typography {
            self.typography = typography

            self.contentDidUpdate()
        }
    }

    func set(alignment: TextLinkAlignment) {
        if self.alignment != alignment {
            self.alignment = alignment

            self.aligmentDidUpdate()
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
        self.spacing = self.theme.layout.spacing.medium

        self.imageTintColor = self.textColorToken

        self.attributedText = self.getAttributedStringUseCase.execute(
            frameworkType: self.frameworkType,
            text: self.text, 
            textColorToken: self.textColorToken,
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
