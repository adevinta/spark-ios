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
    private(set) var variant: SwitchVariant?

    // MARK: - Published Properties

    @Published var isOnChanged: Bool?

    @Published private (set) var isToggleInteractionEnabled: Bool?
    @Published private (set) var toggleOpacity: CGFloat?

    @Published private (set) var toggleBackgroundFullColorToken: FullColorToken?
    @Published private (set) var toggleDotBackgroundColorToken: ColorToken?
    @Published private (set) var toggleDotForegroundFullColorToken: FullColorToken?
    @Published private (set) var textForegroundColorToken: ColorToken?

    @Published private (set) var isToggleOnLeft: Bool?
    @Published private (set) var horizontalSpacing: CGFloat?

    @Published private (set) var showToggleLeftSpace: Bool?

    @Published private (set) var toggleDotImage: SwitchImageable?

    @Published private (set) var textFontToken: TypographyFontToken?

    // MARK: - Private Properties

    private var colors: SwitchColorables?

    private let getColorsUseCase: any SwitchGetColorsUseCaseable
    private let getImageUseCase: any SwitchGetImageUseCaseable
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
        variant: SwitchVariant?,
        getColorsUseCase: any SwitchGetColorsUseCaseable = SwitchGetColorsUseCase(),
        getImageUseCase: any SwitchGetImageUseCaseable = SwitchGetImageUseCase(),
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

        self.getColorsUseCase = getColorsUseCase
        self.getImageUseCase = getImageUseCase
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

    func set(variant: SwitchVariant?) {
        self.variant = variant

        self.toggleDotImageDidUpdate()
    }

    // MARK: - Update

    private func updateAll() {
        self.colorsDidUpdate(reloadColorsFromUseCase: true)
        self.alignmentDidUpdate()
        self.toggleStateDidUpdate()
        self.toggleDotImageDidUpdate()
        self.toggleSpacesVisibilityDidUpdate()
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

        self.toggleBackgroundFullColorToken = self.getToggleColorUseCase.execute(
            forIsOn: self.isOn,
            statusAndStateColor: colors.toggleBackgroundColors
        )
        self.toggleDotBackgroundColorToken = colors.toggleDotBackgroundColor
        self.toggleDotForegroundFullColorToken = self.getToggleColorUseCase.execute(
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
            forIsEnabled: self.isEnabled,
            dims: self.theme.dims
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

    private func textFontDidUpdate() {
        self.textFontToken = self.theme.typography.body1
    }
}
