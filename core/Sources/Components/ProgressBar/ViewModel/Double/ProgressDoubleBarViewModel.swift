//
//  ProgressDoubleBarViewModel.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

final class ProgressDoubleBarViewModel: ProgressBarMainViewModel<ProgressDoubleBarGetColorsUseCase> {

    // MARK: - Initialization

    convenience init(
        for frameworkType: FrameworkType,
        theme: Theme,
        intent: ProgressDoubleBarIntent,
        shape: ProgressBarShape
    ) {
        self.init(
            for: frameworkType,
            theme: theme,
            intent: intent,
            shape: shape,
            getColorsUseCase: ProgressDoubleBarGetColorsUseCase()
        )
    }
}

// MARK: - Extension

extension ProgressDoubleBarViewModel: ProgressBarValueViewModel {
}
