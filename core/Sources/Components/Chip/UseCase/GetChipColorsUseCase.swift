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
    ///   - intent: The intent color, e.g. primary, secondary.
    ///
    /// Returns:
    ///       ChipColors: all the colors used for the chip
    func execute(theme: Theme, variant: ChipVariant, intent: ChipIntentColor) -> ChipColors
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
    /// - intent: The intent color of the chip, e.g. primary, secondary
    func execute(theme: Theme, variant: ChipVariant, intent: ChipIntentColor) -> ChipColors {
        let intentColors = intentColorsUseCase.execute(colors: theme.colors, intentColor: intent)

        switch variant {
        case .dashed, .outlined:
            if intent == .surface {
                return ChipColors(
                    default: .init(background: ColorTokenDefault.clear,
                                   border: intentColors.subordinate,
                                   foreground: intentColors.subordinate),
                    pressed: .init(background: intentColors.tintedSubordinate,
                                   border: intentColors.tintedSubordinate,
                                   foreground: intentColors.principal)
                )
            } else {
                return ChipColors(
                    default: .init(background: ColorTokenDefault.clear,
                                   border: intentColors.principal,
                                   foreground: intentColors.principal),
                    pressed: .init(background: intentColors.tintedPrincipal,
                                   border: intentColors.tintedPrincipal,
                                   foreground: intentColors.principal)
                )
            }
        case .filled:
            if intent == .surface {
                return ChipColors(
                    default: .init(background: intentColors.principal,
                                   border: intentColors.principal,
                                   foreground: intentColors.subordinate),
                    pressed: .init(background: intentColors.tintedSubordinate,
                                   border: intentColors.tintedSubordinate,
                                   foreground: intentColors.principal)
                )
            } else {
                return ChipColors(
                    default: .init(background: intentColors.principal,
                                   border: intentColors.principal,
                                   foreground: intentColors.subordinate),
                    pressed: .init(background: intentColors.tintedPrincipal,
                                   border: intentColors.tintedPrincipal,
                                   foreground: intentColors.principal)
                )
            }
        case .tinted:
            return ChipColors(
                default: .init(background: intentColors.tintedPrincipal,
                               border: intentColors.tintedPrincipal,
                               foreground: intentColors.tintedSubordinate),
                pressed: .init(background: intentColors.tintedSubordinate,
                               border: intentColors.tintedSubordinate,
                               foreground: intentColors.tintedPrincipal)
            )
        }
    }
}
