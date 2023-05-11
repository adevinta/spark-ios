//
//  ChipViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

class ChipViewModel: ObservableObject {

    // MARK: - Properties Injected
    private (set) var theme: Theme
    private (set) var variant: ChipVariant
    private (set) var intentColor: ChipIntentColor
    private let useCase: GetChipColorsUseCasable

    // MARK: - Published Properties
    @Published var spacing: CGFloat
    @Published var padding: CGFloat
    @Published var borderRadius: CGFloat
    @Published var font: TypographyFontToken
    @Published var colors: ChipColors

    // MARK: - Computed variables
    var isBorderDashed: Bool {
        return self.variant.isDashedBorder
    }
    var isBordered: Bool {
        return self.variant.isBordered
    }

    // MARK: - Initializers
    convenience init(theme: Theme, variant: ChipVariant, intentColor: ChipIntentColor) {
        self.init(theme: theme, variant: variant, intentColor: intentColor, useCase: GetChipColorsUseCase())
    }

    init(theme: Theme, variant: ChipVariant, intentColor: ChipIntentColor, useCase: GetChipColorsUseCasable) {
        self.theme = theme
        self.variant = variant
        self.intentColor = intentColor
        self.useCase = useCase
        self.colors = useCase.execute(theme: theme, variant: variant, intent: intentColor)
        self.spacing = self.theme.layout.spacing.small
        self.padding = self.theme.layout.spacing.medium
        self.borderRadius = self.theme.border.radius.medium
        self.font = self.theme.typography.body2
    }

    func set(theme: Theme) {
        self.theme = theme
        self.themeDidUpdate()
    }

    func set(variant: ChipVariant) {
        if self.variant != variant {
            self.variant = variant
            self.variantDidUpdate()
        }
    }

    func set(intentColor: ChipIntentColor) {
        if self.intentColor != intentColor {
            self.intentColor = intentColor
            self.intentColorsDidUpdate()
        }
    }

    // MARK: - Private functions
    private func updateColors() {
        self.colors = self.useCase.execute(theme: self.theme, variant: self.variant, intent: self.intentColor)
    }

    private func themeDidUpdate() {
        self.updateColors()

        self.spacing = self.theme.layout.spacing.small
        self.padding = self.theme.layout.spacing.medium
        self.borderRadius = self.theme.border.radius.medium
        self.font = self.theme.typography.body2
    }

    private func variantDidUpdate() {
        self.updateColors()
    }

    private func intentColorsDidUpdate() {
        self.updateColors()
    }
}

private extension ChipVariant {
    var isBordered: Bool {
        return self == .dashed || self == .outlined
    }

    var isDashedBorder: Bool {
        return self == .dashed
    }
}
