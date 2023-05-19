//
//  ButtonVariantGhostUseCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonVariantGhostUseCase: ButtonVariantUseCaseable {

    // MARK: - Methods

    func colors(
        for intentColor: ButtonIntentColor,
        on colors: Colors,
        dims: Dims
    ) -> ButtonColorables {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        let dim5 = dims.dim5

        switch intentColor {
        case .primary:
            return ButtonColors(
                textColor: colors.primary.primary,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.primary.primary.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return ButtonColors(
                textColor: colors.secondary.secondary,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.secondary.secondary.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return ButtonColors(
                textColor: colors.feedback.neutral,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.neutral.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return ButtonColors(
                textColor: colors.feedback.alert,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.alert.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return ButtonColors(
                textColor: colors.feedback.success,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.success.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return ButtonColors(
                textColor: colors.feedback.error,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.error.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return ButtonColors(
                textColor: colors.base.surface,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.base.surface.dimmed(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
