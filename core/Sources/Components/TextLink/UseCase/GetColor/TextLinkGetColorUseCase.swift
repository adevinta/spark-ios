//
//  TextLinkGetColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetColorUseCaseable {

    // sourcery: colors = "Identical", return = "Identical"
    func execute(intent: TextLinkIntent,
                 isHighlighted: Bool,
                 colors: Colors) -> any ColorToken
}

struct TextLinkGetColorUseCase: TextLinkGetColorUseCaseable {

    // MARK: - Methods

    func execute(
        intent: TextLinkIntent,
        isHighlighted: Bool,
        colors: Colors
    ) -> any ColorToken {
        switch intent {
        case .accent:
            return isHighlighted ? colors.states.accentPressed : colors.accent.accent
        case .alert:
            return isHighlighted ? colors.states.alertPressed: colors.feedback.alert
        case .basic:
            return isHighlighted ? colors.states.basicPressed: colors.basic.basic
        case .danger:
            return isHighlighted ? colors.states.errorPressed: colors.feedback.error
        case .info:
            return isHighlighted ? colors.states.infoPressed: colors.feedback.info
        case .main:
            return isHighlighted ? colors.states.mainPressed: colors.main.main
        case .neutral:
            return isHighlighted ? colors.states.neutralPressed: colors.feedback.neutral
        case .onSurface:
            return colors.base.onSurface
        case .success:
            return isHighlighted ? colors.states.successPressed: colors.feedback.success
        case .support:
            return isHighlighted ? colors.states.supportPressed: colors.support.support
        }
    }
}
