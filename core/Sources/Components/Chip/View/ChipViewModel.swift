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
    var theme: Theme {
        didSet {
            self.themeDidUpdate()
        }
    }

    var variant: ChipVariant {
        didSet {
            self.variantDidUpdate()
        }
    }

    var intentColor: ChipIntentColor {
        didSet {
            self.updateColors()
        }
    }

    private let useCase: GetChipColorsUseCasable

    // MARK: - Published Properties
    @Published var spacing: CGFloat
    @Published var padding: CGFloat
    @Published var borderRadius: CGFloat
    @Published var font: TypographyFontToken
    @Published var colors: ChipColors
    @Published var isBorderDashed: Bool

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
        self.isBorderDashed = variant == .dashed
        self.spacing = self.theme.layout.spacing.small
        self.padding = self.theme.layout.spacing.medium
        self.borderRadius = self.theme.border.radius.medium
        self.font = self.theme.typography.body2
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
        self.isBorderDashed = self.variant == .dashed
        self.updateColors()
    }
}
