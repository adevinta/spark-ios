//
//  TagGetContentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagGetContentColorsUseCaseable {
    func execute(intent: TagIntent,
                 colors: Colors) -> TagContentColors
}

struct TagGetContentColorsUseCase: TagGetContentColorsUseCaseable {

    // MARK: - Methods

    func execute(intent: TagIntent,
                 colors: Colors) -> TagContentColors {
        let surfaceColor = colors.base.surface

        switch intent {
        case .alert:
            return .init(
                color: colors.feedback.alert,
                onColor: colors.feedback.onAlert,
                containerColor: colors.feedback.alertContainer,
                onContainerColor: colors.feedback.onAlertContainer,
                surfaceColor: surfaceColor
            )

        case .danger:
            return .init(
                color: colors.feedback.error,
                onColor: colors.feedback.onError,
                containerColor: colors.feedback.errorContainer,
                onContainerColor: colors.feedback.onErrorContainer,
                surfaceColor: surfaceColor
            )

        case .info:
            return .init(
                color: colors.feedback.info,
                onColor: colors.feedback.onInfo,
                containerColor: colors.feedback.infoContainer,
                onContainerColor: colors.feedback.onInfoContainer,
                surfaceColor: surfaceColor
            )

        case .neutral:
            return .init(
                color: colors.feedback.neutral,
                onColor: colors.feedback.onNeutral,
                containerColor: colors.feedback.neutralContainer,
                onContainerColor: colors.feedback.onNeutralContainer,
                surfaceColor: surfaceColor
            )

        case .primary:
            return .init(
                color: colors.main.main,
                onColor: colors.main.onMain,
                containerColor: colors.main.mainContainer,
                onContainerColor: colors.main.onMainContainer,
                surfaceColor: surfaceColor
            )

        case .secondary:
            return .init(
                color: colors.support.support,
                onColor: colors.support.onSupport,
                containerColor: colors.support.supportContainer,
                onContainerColor: colors.support.onSupportContainer,
                surfaceColor: surfaceColor
            )

        case .success:
            return .init(
                color: colors.feedback.success,
                onColor: colors.feedback.onSuccess,
                containerColor: colors.feedback.successContainer,
                onContainerColor: colors.feedback.onSuccessContainer,
                surfaceColor: surfaceColor
            )
        }
    }
}
