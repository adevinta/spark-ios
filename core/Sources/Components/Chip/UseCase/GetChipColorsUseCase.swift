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

// sourcery: AutoMockable
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
                return ChipColors(
                    default: .init(background: ColorTokenDefault.clear,
                                   border: intentColors.secondary,
                                   foreground: intentColors.secondary),
                    pressed: .init(background: intentColors.tintedSecondary,
                                   border: intentColors.tintedSecondary,
                                   foreground: intentColors.primary)
                )
            } else {
                return ChipColors(
                    default: .init(background: ColorTokenDefault.clear,
                                   border: intentColors.primary,
                                   foreground: intentColors.primary),
                    pressed: .init(background: intentColors.tintedPrimary,
                                   border: intentColors.tintedPrimary,
                                   foreground: intentColors.primary)
                )
            }
        case .filled:
            if intent == .surface {
                return ChipColors(
                    default: .init(background: intentColors.primary,
                                   border: intentColors.primary,
                                   foreground: intentColors.secondary),
                    pressed: .init(background: intentColors.tintedSecondary,
                                   border: intentColors.tintedSecondary,
                                   foreground: intentColors.primary)
                )
            } else {
                return ChipColors(
                    default: .init(background: intentColors.primary,
                                   border: intentColors.primary,
                                   foreground: intentColors.secondary),
                    pressed: .init(background: intentColors.tintedPrimary,
                                   border: intentColors.tintedPrimary,
                                   foreground: intentColors.primary)
                )
            }
        case .tinted:
            return ChipColors(
                default: .init(background: intentColors.tintedPrimary,
                               border: intentColors.tintedPrimary,
                               foreground: intentColors.tintedSecondary),
                pressed: .init(background: intentColors.tintedSecondary,
                               border: intentColors.tintedSecondary,
                               foreground: intentColors.tintedPrimary)
            )
        }
    }
}
