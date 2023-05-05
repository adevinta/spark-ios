//
//  GetChipColorsUseCase.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 03.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
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
            if intent == .surface {
                return ChipColors(background: ColorTokenDefault.clear,
                                  border: intentColors.secondary,
                                  foreground: intentColors.secondary,
                                  backgroundPressed: intentColors.primary.opacity(theme.dims.dim5))
            } else {
                return ChipColors(background: ColorTokenDefault.clear,
                                  border: intentColors.primary,
                                  foreground: intentColors.primary,
                                  backgroundPressed: intentColors.tintedPrimary)
            }
        case .filled:
            if intent == .surface {
                return ChipColors(background: intentColors.primary,
                                  border: intentColors.primary,
                                  foreground: intentColors.secondary,
                                  backgroundPressed: intentColors.primary.opacity(theme.dims.dim5))
            } else {
                return ChipColors(background: intentColors.primary,
                                  border: intentColors.primary,
                                  foreground: intentColors.secondary,
                                  backgroundPressed: intentColors.tintedSecondary)
            }
        case .tinted:
            return ChipColors(background: intentColors.tintedPrimary,
                              border: intentColors.tintedPrimary,
                              foreground: intentColors.tintedSecondary,
                              backgroundPressed: intentColors.primary.opacity(theme.dims.dim5))
        }
    }
}
