//
//  TagGetContentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol TagGetContentColorsUseCaseable {
    func execute(intent: TagIntent,
                 colors: Colors) -> TagContentColors
}

struct TagGetContentColorsUseCase: TagGetContentColorsUseCaseable {

    // MARK: - Methods

    func execute(intent: TagIntent,
                 colors: Colors) -> TagContentColors {

        switch intent {
        case .alert:
            return .init(
                color: colors.feedback.alert,
                onColor: colors.feedback.onAlert,
                containerColor: colors.feedback.alertContainer,
                onContainerColor: colors.feedback.onAlertContainer
            )

        case .danger:
            return .init(
                color: colors.feedback.error,
                onColor: colors.feedback.onError,
                containerColor: colors.feedback.errorContainer,
                onContainerColor: colors.feedback.onErrorContainer
            )

        case .info:
            return .init(
                color: colors.feedback.info,
                onColor: colors.feedback.onInfo,
                containerColor: colors.feedback.infoContainer,
                onContainerColor: colors.feedback.onInfoContainer
            )

        case .neutral:
            return .init(
                color: colors.feedback.neutral,
                onColor: colors.feedback.onNeutral,
                containerColor: colors.feedback.neutralContainer,
                onContainerColor: colors.feedback.onNeutralContainer
            )

        case .main:
            return .init(
                color: colors.main.main,
                onColor: colors.main.onMain,
                containerColor: colors.main.mainContainer,
                onContainerColor: colors.main.onMainContainer
            )

        case .support:
            return .init(
                color: colors.support.support,
                onColor: colors.support.onSupport,
                containerColor: colors.support.supportContainer,
                onContainerColor: colors.support.onSupportContainer
            )

        case .success:
            return .init(
                color: colors.feedback.success,
                onColor: colors.feedback.onSuccess,
                containerColor: colors.feedback.successContainer,
                onContainerColor: colors.feedback.onSuccessContainer
            )

        case .accent:
            return .init(
                color: colors.accent.accent,
                onColor: colors.accent.onAccent,
                containerColor: colors.accent.accentContainer,
                onContainerColor: colors.accent.onAccentContainer
            )

        case .basic:
            return .init(
                color: colors.basic.basic,
                onColor: colors.basic.onBasic,
                containerColor: colors.basic.basicContainer,
                onContainerColor: colors.basic.onBasicContainer
            )
        }
    }
}
