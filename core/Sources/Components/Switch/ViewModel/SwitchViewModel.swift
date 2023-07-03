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

    var isOn: Bool

    private(set) var theme: Theme
    private(set) var alignment: SwitchAlignment
    private(set) var intentColor: SwitchIntentColor
    private(set) var isEnabled: Bool
    private(set) var images: SwitchImagesEither?
    private(set) var text: String?
    private(set) var attributedText: SwitchAttributedStringEither?

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

    @Published private (set) var toggleDotImage: SwitchImageEither?

    @Published private (set) var textContent: SwitchTextContent?
    @Published private (set) var textFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private var colors: SwitchColors?

    private let dependencies: any SwitchViewModelDependenciesProtocol

    // MARK: - Initialization

    init(
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        images: SwitchImagesEither?,
        text: String?,
        attributedText: SwitchAttributedStringEither?,
        dependencies: any SwitchViewModelDependenciesProtocol = SwitchViewModelDependencies()
    ) {
        self.isOn = isOn

        self.theme = theme
        self.alignment = alignment
        self.intentColor = intentColor
        self.isEnabled = isEnabled
        self.images = images
        self.text = text
        self.attributedText = attributedText

        self.dependencies = dependencies

        self.updateAll()
    }

    // MARK: - Action

    func toggle() {
        // Update content only if user interaction is enabled
        if self.isToggleInteractionEnabled ?? false {
            self.isOn.toggle()

            // Manual action: update isOnChanged value
            self.isOnChanged = self.isOn

            self.reloadToggle()
        }
    }

    func reloadToggle() {
        self.colorsDidUpdate()
        self.toggleStateDidUpdate()
        self.toggleDotImageDidUpdate()
        self.toggleSpacesVisibilityDidUpdate()
    }

    // MARK: - Setter

    func set(theme: Theme) {
        self.theme = theme

        self.updateAll()
    }

    func set(alignment: SwitchAlignment) {
        self.alignment = alignment

        self.alignmentDidUpdate()
    }

    func set(intentColor: SwitchIntentColor) {
        self.intentColor = intentColor

        self.colorsDidUpdate(reloadColorsFromUseCase: true)
    }

    func set(isEnabled: Bool) {
        self.isEnabled = isEnabled

        self.colorsDidUpdate()
        self.toggleStateDidUpdate()
    }

    func set(images: SwitchImagesEither?) {
        self.images = images

        self.toggleDotImageDidUpdate()
    }

    func set(text: String?) {
        self.text = text
        self.attributedText = nil

        self.textContentDidUpdate()
    }

    func set(attributedText: SwitchAttributedStringEither?) {
        self.attributedText = attributedText
        self.text = nil

        self.textContentDidUpdate()
    }

    // MARK: - Update

    private func updateAll() {
        self.colorsDidUpdate(reloadColorsFromUseCase: true)
        self.alignmentDidUpdate()
        self.toggleStateDidUpdate()
        self.toggleDotImageDidUpdate()
        self.toggleSpacesVisibilityDidUpdate()
        self.textContentDidUpdate()
        self.textFontDidUpdate()
    }

    private func colorsDidUpdate(reloadColorsFromUseCase: Bool = false) {
        if reloadColorsFromUseCase {
            self.colors = self.dependencies.getColorsUseCase.execute(
                forIntentColor: self.intentColor,
                colors: self.theme.colors,
                dims: self.theme.dims
            )
        }

        guard let colors = self.colors else {
            return
        }

        self.toggleBackgroundColorToken = self.dependencies.getToggleColorUseCase.execute(
            forIsOn: self.isOn,
            statusAndStateColor: colors.toggleBackgroundColors
        )
        self.toggleDotBackgroundColorToken = colors.toggleDotBackgroundColor
        self.toggleDotForegroundColorToken = self.dependencies.getToggleColorUseCase.execute(
            forIsOn: self.isOn,
            statusAndStateColor: colors.toggleDotForegroundColors
        )
        self.textForegroundColorToken = colors.textForegroundColor
    }

    private func alignmentDidUpdate() {
        let position = self.dependencies.getPositionUseCase.execute(
            forAlignment: self.alignment,
            spacing: self.theme.layout.spacing
        )

        self.isToggleOnLeft = position.isToggleOnLeft
        self.horizontalSpacing = position.horizontalSpacing
    }

    private func toggleStateDidUpdate() {
        let interactionState = self.dependencies.getToggleStateUseCase.execute(
            forIsEnabled: self.isEnabled,
            dims: self.theme.dims
        )

        self.isToggleInteractionEnabled = interactionState.interactionEnabled
        self.toggleOpacity = interactionState.opacity
    }

    private func toggleDotImageDidUpdate() {
        if let images = self.images {
            self.toggleDotImage = self.dependencies.getImageUseCase.execute(
                forIsOn: self.isOn,
                images: images
            )
        } else {
            self.toggleDotImage = nil
        }
    }

    private func toggleSpacesVisibilityDidUpdate() {
        self.showToggleLeftSpace = self.isOn
    }

    private func textContentDidUpdate() {
        self.textContent = self.dependencies.makeTextContent(
            text: self.text,
            attributedText: self.attributedText
        )
    }

    private func textFontDidUpdate() {
        self.textFontToken = self.theme.typography.body1
    }
}
