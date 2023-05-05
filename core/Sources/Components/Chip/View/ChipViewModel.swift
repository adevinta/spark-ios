//
//  ChipViewModel.swift
//  SparkCore
//
//  Created by michael.zimmermann on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

class ChipViewModel: ObservableObject {
    var theme: Theme {
        didSet {
            print("Updating colors")
            self.updateColors()
        }
    }

    var variant: ChipVariant {
        didSet {
            self.isBorderDashed = variant == .dashed
            self.updateColors()
        }
    }

    var intentColor: ChipIntentColor {
        didSet {
            self.updateColors()
        }
    }

    private let useCase: GetChipColorsUseCasable

    var spacing: CGFloat {
        return self.theme.layout.spacing.small
    }

    var padding: CGFloat {
        return self.theme.layout.spacing.medium
    }

    var borderRadius: CGFloat {
        return self.theme.border.radius.medium
    }

    var font: TypographyFontToken {
        return self.theme.typography.body2
    }

    @Published var colors: ChipColors
    @Published var isBorderDashed: Bool

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
    }

    private func updateColors() {
        self.colors = self.useCase.execute(theme: self.theme, variant: self.variant, intent: self.intentColor)
    }

}
