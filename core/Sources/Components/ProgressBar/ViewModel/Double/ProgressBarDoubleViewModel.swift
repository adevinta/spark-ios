//
//  ProgressBarDoubleViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@_spi(SI_SPI) import SparkCommon
import SparkTheming

final class ProgressBarDoubleViewModel: ProgressBarMainViewModel<ProgressBarDoubleGetColorsUseCase> {

    // MARK: - Initialization

    convenience init(
        for frameworkType: FrameworkType,
        theme: Theme,
        intent: ProgressBarDoubleIntent,
        shape: ProgressBarShape
    ) {
        self.init(
            for: frameworkType,
            theme: theme,
            intent: intent,
            shape: shape,
            getColorsUseCase: ProgressBarDoubleGetColorsUseCase()
        )
    }
}

// MARK: - Extension

extension ProgressBarDoubleViewModel: ProgressBarValueViewModel {
}
