//
//  SliderGetColorsUseCase.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol SliderGetColorsUseCasable {
    func execute(theme: Theme,
                 intent: SliderIntent) -> SliderColors
}

final class SliderGetColorsUseCase: SliderGetColorsUseCasable {
    func execute(theme: Theme,
                 intent: SliderIntent) -> SliderColors {
        let colors = theme.colors
        let dims = theme.dims

        let sliderColors: SliderColors
        let trackColor = colors.base.onBackground.opacity(dims.dim4)
        switch intent {
        case .basic:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.basic.basic,
                handle: colors.basic.basic,
                handleActiveIndicator: colors.basic.basicContainer
            )
        case .success:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.feedback.success,
                handle: colors.feedback.success,
                handleActiveIndicator: colors.feedback.successContainer
            )
        case .error:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.feedback.error,
                handle: colors.feedback.error,
                handleActiveIndicator: colors.feedback.errorContainer
            )
        case .alert:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.feedback.alert,
                handle: colors.feedback.alert,
                handleActiveIndicator: colors.feedback.alertContainer
            )
        case .accent:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.accent.accent,
                handle: colors.accent.accent,
                handleActiveIndicator: colors.accent.accentContainer
            )
        case .main:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.main.main,
                handle: colors.main.main,
                handleActiveIndicator: colors.main.mainContainer
            )
        case .neutral:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.feedback.neutral,
                handle: colors.feedback.neutral,
                handleActiveIndicator: colors.feedback.neutralContainer
            )
        case .support:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.support.support,
                handle: colors.support.support,
                handleActiveIndicator: colors.support.supportContainer
            )
        case .info:
            sliderColors = .init(
                track: trackColor,
                indicator: colors.feedback.info,
                handle: colors.feedback.info,
                handleActiveIndicator: colors.feedback.infoContainer
            )
        }
        return sliderColors
    }
}
