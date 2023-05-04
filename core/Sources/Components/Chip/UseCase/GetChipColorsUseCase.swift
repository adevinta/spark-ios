//
//  GetChipColorsUseCase.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 03.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//


import Foundation

protocol GetChipColorsUseCasable {
    func execute(theme: Theme, variant: ChipVariant, intent: ChipIntentColor) -> ChipColors
}

struct GetChipColorsUseCase: GetChipColorsUseCasable {

    let intentColorsUseCase: GetChipIntentColorsUseCasable

    init(intentColorsUseCase: GetChipIntentColorsUseCasable = GetChipIntentColorsUseCase()) {
        self.intentColorsUseCase = intentColorsUseCase
    }

    func execute(theme: Theme, variant: ChipVariant, intent: ChipIntentColor) -> ChipColors {

        let intentColors = intentColorsUseCase.execute(colors: theme.colors, intentColor: intent)

        switch variant {
        case .dashed, .outlined:
            return ChipColors(backgroundColor: intentColors.secondary,
                              borderColor: intentColors.primary,
                              foregroundColor: intentColors.primary)
        case .filled:
            return ChipColors(backgroundColor: intentColors.primary,
                              borderColor: intentColors.primary,
                              foregroundColor: intentColors.secondary)
        case .tinted:
            return ChipColors(backgroundColor: intentColors.tintedPrimary,
                              borderColor: intentColors.tintedPrimary,
                              foregroundColor: intentColors.tintedSecondary)
        }

    }
}
