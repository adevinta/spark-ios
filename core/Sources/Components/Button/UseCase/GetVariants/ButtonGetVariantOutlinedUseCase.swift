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

    func execute(
        intent: ButtonIntent,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let dim5 = dims.dim5

        let backgroundColor = colors.base.surface

        switch intent {
        case .primary:
            return .init(
                foregroundColor: colors.primary.primary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.primary.primary.opacity(dim5),
                borderColor: colors.primary.primary,
                pressedBorderColor: colors.primary.primary
            )
        case .secondary:
            return .init(
                foregroundColor: colors.secondary.secondary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.secondary.secondary.opacity(dim5),
                borderColor: colors.secondary.secondary,
                pressedBorderColor: colors.secondary.secondary
            )
        case .neutral:
            return .init(
                foregroundColor: colors.feedback.neutral,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.feedback.neutral.opacity(dim5),
                borderColor: colors.feedback.neutral,
                pressedBorderColor: colors.feedback.neutral
            )
        case .alert:
            return .init(
                foregroundColor: colors.feedback.alert,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.feedback.alert.opacity(dim5),
                borderColor: colors.feedback.alert,
                pressedBorderColor: colors.feedback.alert
            )
        case .success:
            return .init(
                foregroundColor: colors.feedback.success,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.feedback.success.opacity(dim5),
                borderColor: colors.feedback.success,
                pressedBorderColor: colors.feedback.success
            )
        case .danger:
            return .init(
                foregroundColor: colors.feedback.error,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.feedback.error.opacity(dim5),
                borderColor: colors.feedback.error,
                pressedBorderColor: colors.feedback.error
            )
        case .surface:
            return .init(
                foregroundColor: colors.base.surface,
                backgroundColor: colors.base.surfaceInverse,
                pressedBackgroundColor: colors.base.surface.opacity(dim5),
                borderColor: colors.base.surface,
                pressedBorderColor: colors.base.surface
            )
        }
    }
}
