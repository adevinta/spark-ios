////
////  ChipGetOutlinedVariantColorsUseCase.swift
////  Spark
////
////  Created by michael.zimmermann on 10.10.23.
////  Copyright © 2023 Adevinta. All rights reserved.
////
//
//import Foundation
//
//protocol ChipGetVariantColorsUseCasable {
//    func execute(theme: Theme, intent: ChipIntent, state: ChipState) -> ChipStateColors
//}
//
//final class ChipGetOutlinedVariantColorsUseCase:  ChipGetVariantColorsUseCasable {
//
//    private let chipGetIntentColorsUseCase: ChipGetIntentColorsUseCasable
//
//    init(chipGetIntentColorsUseCase: ChipGetIntentColorsUseCasable = ChipGetIntentColorsUseCase()) {
//        self.chipGetIntentColorsUseCase = chipGetIntentColorsUseCase
//    }
//
//    func execute(theme: Theme, intent: ChipIntent, state: ChipState) -> ChipStateColors {
//        var colors = self.chipGetIntentColorsUseCase.execute(theme: theme, intent: intent)
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
//}
