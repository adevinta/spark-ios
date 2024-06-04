//
//  ProgressBarGetColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct ProgressBarGetColorsUseCase: ProgressBarMainGetColorsUseCaseable {

    // MARK: - Methods

    func execute(
        intent: ProgressBarIntent,
        colors: Colors,
        dims: Dims
    ) -> ProgressBarColors {
        let indicatorBackgroundColorToken: any ColorToken
        switch intent {
        case .accent:
            indicatorBackgroundColorToken = colors.accent.accent
        case .alert:
            indicatorBackgroundColorToken = colors.feedback.alert
        case .basic:
            indicatorBackgroundColorToken = colors.basic.basic
        case .danger:
            indicatorBackgroundColorToken = colors.feedback.error
        case .info:
            indicatorBackgroundColorToken = colors.feedback.info
        case .main:
            indicatorBackgroundColorToken = colors.main.main
        case .neutral:
            indicatorBackgroundColorToken = colors.feedback.neutral
        case .success:
            indicatorBackgroundColorToken = colors.feedback.success
        case .support:
            indicatorBackgroundColorToken = colors.support.support
        }

        return .init(
            trackBackgroundColorToken: colors.base.onBackground.opacity(dims.dim4),
            indicatorBackgroundColorToken: indicatorBackgroundColorToken
        )
    }
}
