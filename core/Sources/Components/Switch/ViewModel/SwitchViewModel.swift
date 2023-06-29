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
    private(set) var variant: SwitchVariantable?
    private(set) var text: String?
    private(set) var attributedText: SwitchAttributedString?

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

    @Published private (set) var toggleDotImage: SwitchImage?

    @Published private (set) var textContent: SwitchTextContentable?
    @Published private (set) var textFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private var colors: SwitchColorables?

    private let getColorsUseCase: any SwitchGetColorsUseCaseable
    private let getImageUseCase: any SwitchGetImageUseCaseable
    private let getTextContentUseCase: any SwitchGetTextContentUseCaseable
    private let getToggleColorUseCase: any SwitchGetToggleColorUseCaseable
    private let getPositionUseCase: any SwitchGetPositionUseCaseable
    private let getToggleStateUseCase: any SwitchGetToggleStateUseCaseable

    // MARK: - Initialization

    init(
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        variant: SwitchVariantable?,
        text: String?,
        attributedText: SwitchAttributedString?,
        getColorsUseCase: any SwitchGetColorsUseCaseable = SwitchGetColorsUseCase(),
        getImageUseCase: any SwitchGetImageUseCaseable = SwitchGetImageUseCase(),
        getTextContentUseCase: any SwitchGetTextContentUseCaseable = SwitchGetTextContentUseCase(),
        getToggleColorUseCase: any SwitchGetToggleColorUseCaseable = SwitchGetToggleColorUseCase(),
        getPositionUseCase: any SwitchGetPositionUseCaseable = SwitchGetPositionUseCase(),
        getToggleStateUseCase: any SwitchGetToggleStateUseCaseable = SwitchGetToggleStateUseCase()
    ) {
        self.isOn = isOn

        self.theme = theme
        self.alignment = alignment
        self.intentColor = intentColor
        self.isEnabled = isEnabled
        self.variant = variant
        self.text = text
        self.attributedText = attributedText

        self.getColorsUseCase = getColorsUseCase
        self.getImageUseCase = getImageUseCase
        self.getTextContentUseCase = getTextContentUseCase
        self.getToggleColorUseCase = getToggleColorUseCase
        self.getPositionUseCase = getPositionUseCase
        self.getToggleStateUseCase = getToggleStateUseCase

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

    func set(variant: SwitchVariantable?) {
        self.variant = variant

        self.toggleDotImageDidUpdate()
    }

    func set(text: String?) {
        self.text = text
        self.attributedText = nil

        self.textContentDidUpdate()
    }

    func set(attributedText: SwitchAttributedString?) {
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
            self.colors = self.getColorsUseCase.execute(
                forIntentColor: self.intentColor,
                colors: self.theme.colors,
                dims: self.theme.dims
            )
        }

        guard let colors = self.colors else {
            return
        }

        self.toggleBackgroundColorToken = self.getToggleColorUseCase.execute(
            forIsOn: self.isOn,
            statusAndStateColor: colors.toggleBackgroundColors
        )
        self.toggleDotBackgroundColorToken = colors.toggleDotBackgroundColor
        self.toggleDotForegroundColorToken = self.getToggleColorUseCase.execute(
            forIsOn: self.isOn,
            statusAndStateColor: colors.toggleDotForegroundColors
        )
        self.textForegroundColorToken = colors.textForegroundColor
    }

    private func alignmentDidUpdate() {
        let position = self.getPositionUseCase.execute(
            forAlignment: self.alignment,
            spacing: self.theme.layout.spacing
        )

        self.isToggleOnLeft = position.isToggleOnLeft
        self.horizontalSpacing = position.horizontalSpacing
    }

    private func toggleStateDidUpdate() {
        let interactionState = self.getToggleStateUseCase.execute(
            forIsEnabled: self.isEnabled
        )

        self.isToggleInteractionEnabled = interactionState.interactionEnabled
        self.toggleOpacity = interactionState.opacity
    }

    private func toggleDotImageDidUpdate() {
        self.toggleDotImage = self.getImageUseCase.execute(
            forIsOn: self.isOn,
            variant: self.variant
        )
    }

    private func toggleSpacesVisibilityDidUpdate() {
        self.showToggleLeftSpace = self.isOn
    }

    private func textContentDidUpdate() {
        self.textContent = self.getTextContentUseCase.execute(
            text: self.text,
            attributedText: self.attributedText
        )
    }

    private func textFontDidUpdate() {
        self.textFontToken = self.theme.typography.body1
    }
}
