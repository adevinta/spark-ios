//
//  ButtonGetVariantOutlinedUseCase.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonGetVariantOutlinedUseCase: ButtonGetVariantUseCaseable {

    // MARK: - Methods

    func colors(
        forIntentColor intentColor: ButtonIntentColor,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let dim5 = dims.dim5

        let backgroundColor = colors.base.surface

        switch intentColor {
        case .primary:
            return ButtonColorsDefault(
                foregroundColor: colors.primary.primary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.primary.primary,
                    opacity: dim5
                ),
                borderColor: colors.primary.primary,
                pressedBorderColor: colors.primary.primary
            )
        case .secondary:
            return ButtonColorsDefault(
                foregroundColor: colors.secondary.secondary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.secondary.secondary,
                    opacity: dim5
                ),
                borderColor: colors.secondary.secondary,
                pressedBorderColor: colors.secondary.secondary
            )
        case .neutral:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.neutral,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.feedback.neutral,
                    opacity: dim5
                ),
                borderColor: colors.feedback.neutral,
                pressedBorderColor: colors.feedback.neutral
            )
        case .alert:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.alert,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.feedback.alert,
                    opacity: dim5
                ),
                borderColor: colors.feedback.alert,
                pressedBorderColor: colors.feedback.alert
            )
        case .success:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.success,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.feedback.success,
                    opacity: dim5
                ),
                borderColor: colors.feedback.success,
                pressedBorderColor: colors.feedback.success
            )
        case .danger:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.error,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.feedback.error,
                    opacity: dim5
                ),
                borderColor: colors.feedback.error,
                pressedBorderColor: colors.feedback.error
            )
        case .surface:
            return ButtonColorsDefault(
                foregroundColor: colors.base.surface,
                backgroundColor: colors.base.surfaceInverse,
                pressedBackgroundColor: FullColorTokenDefault(
                    colorToken: colors.base.surface,
                    opacity: dim5
                ),
                borderColor: colors.base.surface,
                pressedBorderColor: colors.base.surface
            )
        }
    }
}
