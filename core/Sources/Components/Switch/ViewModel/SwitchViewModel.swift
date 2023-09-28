//
//  SwitchViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

final class SwitchViewModel: ObservableObject {

    // MARK: - Properties

    private(set) var isOn: Bool

    private let frameworkType: FrameworkType
    private(set) var theme: Theme
    private(set) var alignment: SwitchAlignment
    private(set) var intent: SwitchIntent
    private(set) var isEnabled: Bool
    private(set) var images: SwitchImagesEither?

    // MARK: - Published Properties

    @Published var isOnChanged: Bool?

    @Published private (set) var isToggleInteractionEnabled: Bool?
    @Published private (set) var toggleOpacity: CGFloat?

    @Published private (set) var toggleBackgroundColorToken: (any ColorToken)?
    @Published private (set) var toggleDotBackgroundColorToken: (any ColorToken)?
    @Published private (set) var toggleDotForegroundColorToken: (any ColorToken)?
    @Published private (set) var textForegroundColorToken: (any ColorToken)?

    @Published private (set) var isToggleOnLeft: Bool?
    @Published private (set) var horizontalSpacing: CGFloat?

    @Published private (set) var showToggleLeftSpace: Bool?

    @Published private (set) var toggleDotImagesState: SwitchImagesState?

    @Published private (set) var displayedText: DisplayedText?
    @Published private (set) var textFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private var colors: SwitchColors?
    private let displayedTextViewModel: DisplayedTextViewModel

    private let dependencies: any SwitchViewModelDependenciesProtocol

    // MARK: - Initialization

    init(
        for frameworkType: FrameworkType,
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intent: SwitchIntent,
        isEnabled: Bool,
        images: SwitchImagesEither?,
        text: String?,
        attributedText: AttributedStringEither?,
        dependencies: any SwitchViewModelDependenciesProtocol = SwitchViewModelDependencies()
    ) {
        self.isOn = isOn
        self.frameworkType = frameworkType

        self.theme = theme
        self.alignment = alignment
        self.intent = intent
        self.isEnabled = isEnabled
        self.images = images
        self.displayedTextViewModel = dependencies.makeDisplayedTextViewModel(
            text: text,
            attributedText: attributedText
        )

        self.dependencies = dependencies

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

    // MARK: - Action

    func toggle() {
        // Update content only if user interaction is enabled
        if self.isToggleInteractionEnabled ?? false {
            self.isOn.toggle()

            // Manual action: update isOnChanged value
            self.isOnChanged = self.isOn

            self.colorsDidUpdate()
            self.toggleStateDidUpdate()
            self.toggleDotImageDidUpdate()
            self.toggleSpacesVisibilityDidUpdate()
        }
    }

    // MARK: - Setter

    func set(isOn: Bool) {
        if self.isOn != isOn {
            self.isOn = isOn

            self.colorsDidUpdate()
            self.toggleDotImageDidUpdate()
            self.toggleSpacesVisibilityDidUpdate()
        }
    }

    func set(theme: Theme) {
        self.theme = theme

        self.updateAll()
    }

    func set(alignment: SwitchAlignment) {
        if self.alignment != alignment {
            self.alignment = alignment

            self.alignmentDidUpdate()
        }
    }

    func set(intent: SwitchIntent) {
        if self.intent != intent {
            self.intent = intent

            self.colorsDidUpdate(reloadColorsFromUseCase: true)
        }
    }

    func set(isEnabled: Bool) {
        if self.isEnabled != isEnabled {
            self.isEnabled = isEnabled

            self.colorsDidUpdate()
            self.toggleStateDidUpdate()
        }
    }

    func set(images: SwitchImagesEither?) {
        if self.images != images {
            self.images = images

            self.toggleDotImageDidUpdate()
        }
    }

    func set(text: String?) {
        // Reload text properties (font and color) if consumer set a new text
        if self.displayedTextViewModel.textChanged(text) {
            self.displayTextDidUpdate()

            if text != nil {
                self.textFontDidUpdate()
                self.textForegroundColorTokenDidUpdate()
                self.alignmentDidUpdate()
            }
        }
    }

    func set(attributedText: AttributedStringEither?) {
        if self.displayedTextViewModel.attributedTextChanged(attributedText) {
            self.displayTextDidUpdate()
            self.alignmentDidUpdate()
        }
    }

    // MARK: - Private Update

    private func updateAll() {
        self.colorsDidUpdate(reloadColorsFromUseCase: true)
        self.alignmentDidUpdate()
        self.toggleStateDidUpdate()
        self.toggleDotImageDidUpdate()
        self.toggleSpacesVisibilityDidUpdate()
        self.displayTextDidUpdate()
        self.textFontDidUpdate()
    }

    private func colorsDidUpdate(reloadColorsFromUseCase: Bool = false) {
        if reloadColorsFromUseCase {
            self.colors = self.dependencies.getColorsUseCase.execute(
                intent: self.intent,
                colors: self.theme.colors,
                dims: self.theme.dims
            )
        }

        guard let colors = self.colors else {
            return
        }

        self.toggleBackgroundColorToken = self.dependencies.getToggleColorUseCase.execute(
            isOn: self.isOn,
            statusAndStateColor: colors.toggleBackgroundColors
        )
        self.toggleDotBackgroundColorToken = colors.toggleDotBackgroundColor
        self.toggleDotForegroundColorToken = self.dependencies.getToggleColorUseCase.execute(
            isOn: self.isOn,
            statusAndStateColor: colors.toggleDotForegroundColors
        )
        self.textForegroundColorTokenDidUpdate()
    }

    private func textForegroundColorTokenDidUpdate() {
        guard let colors = self.colors else {
            return
        }

        self.textForegroundColorToken = colors.textForegroundColor
    }

    private func alignmentDidUpdate() {
        let position = self.dependencies.getPositionUseCase.execute(
            alignment: self.alignment,
            spacing: self.theme.layout.spacing,
            containsText: self.displayedTextViewModel.containsText
        )

        self.isToggleOnLeft = position.isToggleOnLeft
        self.horizontalSpacing = position.horizontalSpacing
    }

    private func toggleStateDidUpdate() {
        let interactionState = self.dependencies.getToggleStateUseCase.execute(
            isEnabled: self.isEnabled,
            dims: self.theme.dims
        )

        self.isToggleInteractionEnabled = interactionState.interactionEnabled
        self.toggleOpacity = interactionState.opacity
    }

    private func toggleDotImageDidUpdate() {
        if let images = self.images {
            self.toggleDotImagesState = self.dependencies.getImagesStateUseCase.execute(
                isOn: self.isOn,
                images: images
            )
        } else {
            self.toggleDotImagesState = nil
        }
    }

    private func toggleSpacesVisibilityDidUpdate() {
        self.showToggleLeftSpace = self.isOn
    }

    private func displayTextDidUpdate() {
        self.displayedText = self.displayedTextViewModel.displayedText
    }

    private func textFontDidUpdate() {
        self.textFontToken = self.theme.typography.body1
    }
}
