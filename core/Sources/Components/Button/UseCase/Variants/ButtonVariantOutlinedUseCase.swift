//
//  ButtonVariantOutlinedUseCase.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonVariantOutlinedUseCase: ButtonVariantUseCaseable {

    // MARK: - Methods

    func colors(
        for intentColor: ButtonIntentColor,
        on colors: Colors,
        dims: Dims
    ) -> ButtonColorables {
        let dim5 = dims.dim5

        switch intentColor {
        case .primary:
            return ButtonColors(
                textColor: colors.primary.primary,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.primary.primary.dimmed(dim5),
                borderColor: colors.primary.primary,
                pressedBorderColor: colors.primary.primary
            )
        case .secondary:
            return ButtonColors(
                textColor: colors.secondary.secondary,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.secondary.secondary.dimmed(dim5),
                borderColor: colors.secondary.secondary,
                pressedBorderColor: colors.secondary.secondary
            )
        case .neutral:
            return ButtonColors(
                textColor: colors.feedback.neutral,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.neutral.dimmed(dim5),
                borderColor: colors.feedback.neutral,
                pressedBorderColor: colors.feedback.neutral
            )
        case .alert:
            return ButtonColors(
                textColor: colors.feedback.alert,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.alert.dimmed(dim5),
                borderColor: colors.feedback.alert,
                pressedBorderColor: colors.feedback.alert
            )
        case .success:
            return ButtonColors(
                textColor: colors.feedback.success,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.success.dimmed(dim5),
                borderColor: colors.feedback.success,
                pressedBorderColor: colors.feedback.success
            )
        case .danger:
            return ButtonColors(
                textColor: colors.feedback.error,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.error.dimmed(dim5),
                borderColor: colors.feedback.error,
                pressedBorderColor: colors.feedback.error
            )
        case .surface:
            return ButtonColors(
                textColor: colors.base.surface,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.base.surface.dimmed(dim5),
                borderColor: colors.base.surface,
                pressedBorderColor: colors.base.surface
            )
        }
    }
}
