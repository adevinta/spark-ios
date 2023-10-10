////
////  ChipGetTintedVariantColorsUseCase.swift
////  SparkCore
////
////  Created by michael.zimmermann on 10.10.23.
////  Copyright © 2023 Adevinta. All rights reserved.
////
//
//import Foundation
//
//struct ChipGetTintedVariantColorsUseCase: ChipGetVariantColorsUseCasable {
//    private let chipGetIntentColorsUseCase: ChipGetIntentColorsUseCasable
//
//    init(chipGetIntentColorsUseCase: ChipGetIntentColorsUseCasable = ChipGetTintedIntentColorsUseCase()) {
//        self.chipGetIntentColorsUseCase = chipGetIntentColorsUseCase
//    }
//
//    func execute(theme: Theme, intent: ChipIntent, state: ChipState) -> ChipStateColors {
//        let colors = self.chipGetIntentColorsUseCase.execute(theme: theme, intent: intent)
//
//        if state.isPressed {
//            return .init(
//                background: colors.pressedBackground,
//                border: colors.border,
//                foreground: colors.border)
//        }
//
//        var stateColors = ChipStateColors(
//            background: colors.background,
//            border: colors.border,
//            foreground: colors.text)
//
//        if state.isSelected {
//            stateColors.background = colors.selectedBackground
//            stateColors.foreground = colors.selectedText
//        }
//
//        if state.isDisabled {
//            stateColors.opacity = theme.dims.dim3
//        }
//
//        return stateColors
//    }
//    
//}
