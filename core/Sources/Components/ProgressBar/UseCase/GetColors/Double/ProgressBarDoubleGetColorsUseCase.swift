//
//  ProgressBarGetColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

struct ProgressBarDoubleGetColorsUseCase: ProgressBarMainGetColorsUseCaseable {

    // MARK: - Methods

    func execute(
        intent: ProgressBarDoubleIntent,
        colors: Colors,
        dims: Dims
    ) -> ProgressBarDoubleColors {
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
        case .main:
            indicatorBackgroundColorToken = colors.main.main
        case .success:
            indicatorBackgroundColorToken = colors.feedback.success
        }

        return .init(
            trackBackgroundColorToken: colors.base.onBackground.opacity(dims.dim4),
            indicatorBackgroundColorToken: indicatorBackgroundColorToken,
            bottomIndicatorBackgroundColorToken: indicatorBackgroundColorToken.opacity(dims.dim3)
        )
    }
}
