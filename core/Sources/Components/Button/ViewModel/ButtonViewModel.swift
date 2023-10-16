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
    private(set) var intent: ButtonIntent
    private(set) var variant: ButtonVariant
    private(set) var size: ButtonSize
    private(set) var shape: ButtonShape
    private(set) var alignment: ButtonAlignment
    private(set) var iconImage: ImageEither?
    private(set) var isEnabled: Bool

    // MARK: - Published Properties

    @Published private(set) var state: ButtonState?

    @Published private(set) var currentColors: ButtonCurrentColors?

    @Published private(set) var sizes: ButtonSizes?
    @Published private(set) var border: ButtonBorder?
    @Published private(set) var spacings: ButtonSpacings?

    @Published private(set) var content: ButtonContent?
    @Published private(set) var textFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private var colors: ButtonColors?

    private var isIconOnly: Bool {
        return self.dependencies.getIsIconOnlyUseCase.execute(
            iconImage: self.iconImage,
            containsText: self.displayedTextViewModel.containsText
        )
    }

    private let displayedTextViewModel: DisplayedTextViewModel

    private var isPressed: Bool = false

    private let dependencies: any ButtonViewModelDependenciesProtocol

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: ButtonIntent,
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
        self.intent = intent
        self.variant = variant
        self.size = size
        self.shape = shape
        self.alignment = alignment
        self.iconImage = iconImage
        self.displayedTextViewModel = dependencies.makeDisplayedTextViewModel(
            text: text,
            attributedText: attributedText
        )
        self.isEnabled = isEnabled

        self.dependencies = dependencies

        self.loadRequired()
    }

    // MARK: - Load

    /// Load required published properties when the view is init
    private func loadRequired() {
        self.sizesDidUpdate()
    }

    /// Load all published values. Should be called when all published values are subscribed by the view
    func load() {
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

    func set(intent: ButtonIntent) {
        if self.intent != intent {
            self.intent = intent

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
        // Displayed text changed ?
        if self.displayedTextViewModel.textChanged(text) {
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
        // Displayed text changed ?
        if self.displayedTextViewModel.attributedTextChanged(attributedText) {
            self.contentDidUpdate()
            self.sizesDidUpdate()
            self.spacingsDidUpdate()
        }
    }

    func set(iconImage: ImageEither?) {
        if self.iconImage != iconImage {
            self.iconImage = iconImage
            
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
            isEnabled: self.isEnabled,
            dims: self.theme.dims
        )
    }

    private func colorsDidUpdate(
        reloadColorsFromUseCase: Bool = false
    ) {
        if reloadColorsFromUseCase {
            self.colors = self.dependencies.getColorsUseCase.execute(
                theme: self.theme,
                intent: self.intent,
                variant: self.variant
            )
        }

        guard let colors = self.colors else {
            return
        }

        self.currentColors = self.dependencies.getCurrentColorsUseCase.execute(
            colors: colors,
            isPressed: self.isPressed,
            displayedTextType: self.displayedTextViewModel.displayedTextType
        )
    }

    private func sizesDidUpdate() {
        self.sizes = self.dependencies.getSizesUseCase.execute(
            size: self.size,
            isOnlyIcon: self.isIconOnly
        )
    }

    private func borderDidUpdate() {
        self.border = self.dependencies.getBorderUseCase.execute(
            shape: self.shape,
            border: self.theme.border,
            variant: self.variant
        )
    }

    private func spacingsDidUpdate() {
        self.spacings = self.dependencies.getSpacingsUseCase.execute(
            spacing: self.theme.layout.spacing,
            isOnlyIcon: self.isIconOnly
        )
    }

    private func contentDidUpdate() {
        self.content = self.dependencies.getContentUseCase.execute(
            alignment: self.alignment,
            iconImage: self.iconImage,
            containsText: self.displayedTextViewModel.containsText
        )
    }

    private func textFontDidUpdate() {
        self.textFontToken = self.theme.typography.callout
    }
}
