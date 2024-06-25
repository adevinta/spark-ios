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

        let backgroundColor = ColorTokenDefault.clear

        switch intent {
        case .accent:
            return .init(
                foregroundColor: colors.accent.accent,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.accent.accent.opacity(dim5),
                borderColor: colors.accent.accent,
                pressedBorderColor: colors.accent.accent
            )
        case .basic:
            return .init(
                foregroundColor: colors.basic.basic,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.basic.basic.opacity(dim5),
                borderColor: colors.basic.basic,
                pressedBorderColor: colors.basic.basic
            )
        case .main:
            return .init(
                foregroundColor: colors.main.main,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.main.main.opacity(dim5),
                borderColor: colors.main.main,
                pressedBorderColor: colors.main.main
            )
        case .support:
            return .init(
                foregroundColor: colors.support.support,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.support.support.opacity(dim5),
                borderColor: colors.support.support,
                pressedBorderColor: colors.support.support
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
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.base.surface.opacity(dim5),
                borderColor: colors.base.surface,
                pressedBorderColor: colors.base.surface
            )
        case .info:
            return .init(
                foregroundColor: colors.feedback.info,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.feedback.info.opacity(dim5),
                borderColor: colors.feedback.info,
                pressedBorderColor: colors.feedback.info
            )
        }
    }
}
