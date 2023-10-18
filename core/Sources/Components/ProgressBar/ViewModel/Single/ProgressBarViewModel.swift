//
//  ProgressBarViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

final class ProgressBarViewModel: ProgressBarMainViewModel<ProgressBarGetColorsUseCase> {

    // MARK: - Initialization

    convenience init(
        for frameworkType: FrameworkType,
        theme: Theme,
        intent: ProgressBarIntent,
        shape: ProgressBarShape
    ) {
        self.init(
            for: frameworkType,
            theme: theme,
            intent: intent,
            shape: shape,
            getColorsUseCase: ProgressBarGetColorsUseCase()
        )
    }
}

// MARK: - Extension

extension ProgressBarViewModel: ProgressBarValueViewModel {
}
