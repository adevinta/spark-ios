//
//  ButtonGetVariantGhostUseCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonGetVariantGhostUseCase: ButtonGetVariantUseCaseable {

    // MARK: - Methods

    func execute(
        intent: ButtonIntent,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        let dim5 = dims.dim5

        switch intent {
        case .main:
            return .init(
                foregroundColor: colors.main.main,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.main.main.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .support:
            return .init(
                foregroundColor: colors.support.support,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.support.support.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return .init(
                foregroundColor: colors.feedback.neutral,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.neutral.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return .init(
                foregroundColor: colors.feedback.alert,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.alert.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return .init(
                foregroundColor: colors.feedback.success,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.success.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return .init(
                foregroundColor: colors.feedback.error,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.feedback.error.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return .init(
                foregroundColor: colors.base.surface,
                backgroundColor: ColorTokenDefault.clear,
                pressedBackgroundColor: colors.base.surface.opacity(dim5),
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
