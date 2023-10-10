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

/// A use case to calculate the colors of a chip depending on the theme, variant and intent
// sourcery: AutoMockable
protocol GetChipColorsUseCasable {
    /// Function `execute` calculates the chip colors
    ///
    /// Parameters:
    ///   - theme: The spark theme.
    ///   - variant: The variant of the chip, if it is outlined, filled, etc.
    ///   - intent: The intent color, e.g. main, support.
    ///
    /// Returns:
    ///       ChipColors: all the colors used for the chip
    func execute(theme: Theme,
                 variant: ChipVariant,
                 intent: ChipIntent,
                 state: ChipState
    ) -> ChipStateColors
}

/// GetChipColorsUseCase: A use case to calculate the colors of a chip depending on the theme, variand and intent
struct GetChipColorsUseCase: GetChipColorsUseCasable {
    // MARK: - Properties
    private let intentColorsUseCase: GetChipIntentColorsUseCasable

    // MARK: - Initializer

    /// Initializer
    ///
    /// Parameters:
    /// - intentColorsUsedCase: A use case to calcualte the intent colors.
    init(intentColorsUseCase: GetChipIntentColorsUseCasable = GetChipIntentColorsUseCase()) {
        self.intentColorsUseCase = intentColorsUseCase
    }

    // MARK: - Functions

    /// The funcion execute calculates the chip colors based on the parameters.
    ///
    /// Parameters:
    /// - theme: The current theme to be used
    /// - variant: The variant of the chip, whether it's filled, outlined, etc.
    /// - intent: The intent color of the chip, e.g. main, support
    /// - state: The current state of the chip, e.g. selected, enabled, pressed
    func execute(theme: Theme,
                 variant: ChipVariant,
                 intent: ChipIntent,
                 state: ChipState) -> ChipStateColors {
        let intentColors = intentColorsUseCase.execute(colors: theme.colors, intent: intent)

        let chipColors: ChipColors
        switch variant {
        case .dashed, .outlined:
            if intent == .surface {
                chipColors = ChipColors(
                    default: .init(background: ColorTokenDefault.clear,
                                   border: intentColors.subordinate,
                                   foreground: intentColors.subordinate),
                    pressed: .init(background: intentColors.tintedSubordinate,
                                   border: intentColors.tintedSubordinate,
                                   foreground: intentColors.principal),
                    selected: .init(background: intentColors.subordinate,
                                    border: intentColors.subordinate,
                                    foreground: intentColors.principal)
                )
            } else {
                chipColors = ChipColors(
                    default: .init(background: ColorTokenDefault.clear,
                                   border: intentColors.principal,
                                   foreground: intentColors.principal),
                    pressed: .init(background: intentColors.principal.opacity(theme.dims.dim5),
                                   border: intentColors.principal,
                                   foreground: intentColors.principal),
                    selected: .init(background: intentColors.tintedPrincipal,
                                    border: intentColors.principal,
                                    foreground: intentColors.principal)
                )
            }
//        case .filled:
//            if intent == .surface {
//                chipColors = ChipColors(
//                    default: .init(background: intentColors.principal,
//                                   border: intentColors.principal,
//                                   foreground: intentColors.subordinate),
//                    pressed: .init(background: intentColors.tintedSubordinate,
//                                   border: intentColors.tintedSubordinate,
//                                   foreground: intentColors.principal)
//                )
//            } else {
//                chipColors = ChipColors(
//                    default: .init(background: intentColors.principal,
//                                   border: intentColors.principal,
//                                   foreground: intentColors.subordinate),
//                    pressed: .init(background: intentColors.tintedPrincipal,
//                                   border: intentColors.tintedPrincipal,
//                                   foreground: intentColors.principal)
//                )
//            }
        case .tinted:
            chipColors = ChipColors(
                default: .init(background: intentColors.tintedPrincipal,
                               border: intentColors.tintedPrincipal,
                               foreground: intentColors.tintedSubordinate),
                pressed: .init(background: intentColors.tintedSubordinate,
                               border: intentColors.tintedSubordinate,
                               foreground: intentColors.principal),
                selected: .init(background: intentColors.principal,
                                border: intentColors.principal,
                                foreground: intentColors.subordinate)
            )
        }

        if state.isPressed {
            return chipColors.pressed
        } else if state.isSelected {
            return chipColors.selected
        } else if state.isDisabled {
            return chipColors.default.withOpacity(theme.dims.dim3)
        } else {
            return chipColors.default
        }
    }
}

private extension ChipStateColors {
    func withOpacity(_ opacity: CGFloat) -> ChipStateColors {
        return .init(background: self.background, border: self.border, foreground: self.foreground, opacity: opacity)
    }
}
