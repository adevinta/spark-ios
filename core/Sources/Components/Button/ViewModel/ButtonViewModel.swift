//
//  ButtonViewModel.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 09.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

final class ButtonViewModel: ObservableObject {

    // MARK: - Properties

    private(set) var theme: Theme
    private(set) var intentColor: ButtonIntentColor
    private(set) var variant: ButtonVariant
    private(set) var size: ButtonSize
    private(set) var shape: ButtonShape
    private(set) var alignment: ButtonAlignment
    private(set) var iconImage: ImageEither?
    private(set) var isEnabled: Bool

    // MARK: - Published Properties

    @Published private (set) var state: ButtonState?

    @Published private (set) var currentColors: ButtonCurrentColors?

    @Published private (set) var sizes: ButtonSizes?
    @Published private (set) var border: ButtonBorder?
    @Published private (set) var spacings: ButtonSpacings?

    @Published private (set) var content: ButtonContent?
    @Published private (set) var textFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private var colors: ButtonColors?

    private var isIconOnly: Bool = false // Reset on init with setIsOnlyIcon func
    private var text: String?
    private var attributedText: AttributedStringEither?

    private var isPressed: Bool = false

    private let dependencies: any ButtonViewModelDependenciesProtocol

    // MARK: - Initialization

    init(
        theme: Theme,
        intentColor: ButtonIntentColor,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        iconImage: ImageEither?,
        text: String? ,
        attributedText: AttributedStringEither?,
        isEnabled: Bool,
        dependencies: any ButtonViewModelDependenciesProtocol = ButtonViewModelDependencies()
    ) {
        self.theme = theme
        self.intentColor = intentColor
        self.variant = variant
        self.size = size
        self.shape = shape
        self.alignment = alignment
        self.iconImage = iconImage
        self.text = text
        self.attributedText = attributedText
        self.isEnabled = isEnabled

        self.dependencies = dependencies
    }

    // MARK: - Load

    func load() {
        self.setIsOnlyIcon()

        // Update all values when view is ready to receive published values
        self.updateAll()
    }

    // MARK: - Actions

    func pressedAction() {
        // Not already pressed ?
        if !self.isPressed {
            self.isPressed.toggle()

            self.colorsDidUpdate()
        }
    }

    func unpressedAction() {
        // Not already unpressed ?
        if self.isPressed {
            self.isPressed.toggle()

            self.colorsDidUpdate()
        }
    }

    // MARK: - Setter

    func set(theme: Theme) {
        self.theme = theme

        self.updateAll(themeChanged: true)
    }

    func set(intentColor: ButtonIntentColor) {
        if self.intentColor != intentColor {
            self.intentColor = intentColor

            self.colorsDidUpdate(reloadColorsFromUseCase: true)
        }
    }

    func set(variant: ButtonVariant) {
        if self.variant != variant {
            self.variant = variant

            self.colorsDidUpdate(reloadColorsFromUseCase: true)
            self.borderDidUpdate()
        }
    }

    func set(size: ButtonSize) {
        if self.size != size {
            self.size = size

            self.sizesDidUpdate()
        }
    }

    func set(shape: ButtonShape) {
        if self.shape != shape {
            self.shape = shape

            self.borderDidUpdate()
        }
    }

    func set(alignment: ButtonAlignment) {
        if self.alignment != alignment {
            self.alignment = alignment

            self.contentDidUpdate()
        }
    }

    func set(text: String?) {
        if self.text != text {
            self.text = text

            // Should be called before *DidUpdate* methods
            self.setIsOnlyIcon()

            self.contentDidUpdate()
            self.sizesDidUpdate()
            self.spacingsDidUpdate()

            // Reload label properties (font and color) if consumer set a new text
            if text != nil {
                self.textFontDidUpdate()
                self.colorsDidUpdate()
            }
        }
    }

    func set(attributedText: AttributedStringEither?) {
        if self.attributedText != attributedText {
            self.attributedText = attributedText

            // Should be called before *DidUpdate* methods
            self.setIsOnlyIcon()

            self.contentDidUpdate()
            self.sizesDidUpdate()
            self.spacingsDidUpdate()
        }
    }

    func set(iconImage: ImageEither?) {
        if self.iconImage != iconImage {
            self.iconImage = iconImage
            
            // Should be called before *DidUpdate* methods
            self.setIsOnlyIcon()
            
            self.contentDidUpdate()
            self.sizesDidUpdate()
            self.spacingsDidUpdate()
        }
    }

    func set(isEnabled: Bool) {
        if self.isEnabled != isEnabled {
            self.isEnabled = isEnabled

            self.stateDidUpdate()
        }
    }

    // MARK: - Private Setter

    private func setIsOnlyIcon() {
        self.isIconOnly = self.dependencies.getIsIconOnlyUseCase.execute(
            forIconImage: self.iconImage,
            text: self.text,
            attributedText: self.attributedText
        )
    }

    // MARK: - Private Update

    private func updateAll(themeChanged: Bool = false) {
        self.stateDidUpdate()
        self.colorsDidUpdate(reloadColorsFromUseCase: true)
        self.sizesDidUpdate()
        self.borderDidUpdate()
        self.spacingsDidUpdate()
        if !themeChanged {
            self.contentDidUpdate() // Not related to theme
        }
        self.textFontDidUpdate()
    }

    private func stateDidUpdate() {
        self.state = self.dependencies.getStateUseCase.execute(
            forIsEnabled: self.isEnabled,
            dims: self.theme.dims
        )
    }

    private func colorsDidUpdate(
        reloadColorsFromUseCase: Bool = false
    ) {
        if reloadColorsFromUseCase {
            self.colors = self.dependencies.getColorsUseCase.execute(
                forTheme: self.theme,
                intentColor: self.intentColor,
                variant: self.variant
            )
        }

        guard let colors = self.colors else {
            return
        }

        self.currentColors = self.dependencies.getCurrentColorsUseCase.execute(
            forColors: colors,
            isPressed: self.isPressed
        )
    }

    private func sizesDidUpdate() {
        self.sizes = self.dependencies.getSizesUseCase.execute(
            forSize: self.size,
            isOnlyIcon: self.isIconOnly
        )
    }

    private func borderDidUpdate() {
        self.border = self.dependencies.getBorderUseCase.execute(
            forShape: self.shape,
            border: self.theme.border,
            variant: self.variant
        )
    }

    private func spacingsDidUpdate() {
        self.spacings = self.dependencies.getSpacingsUseCase.execute(
            forSpacing: self.theme.layout.spacing,
            isOnlyIcon: self.isIconOnly
        )
    }

    private func contentDidUpdate() {
        self.content = self.dependencies.getContentUseCase.execute(
            forAlignment: self.alignment,
            iconImage: self.iconImage,
            text: self.text,
            attributedText: self.attributedText
        )
    }

    private func textFontDidUpdate() {
        self.textFontToken = self.theme.typography.callout
    }
}
