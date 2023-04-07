//
//  SparkTagGetColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SparkTagGetColorsUseCaseable {
    func execute(from theming: SparkTagTheming) -> SparkTagColorables
}

struct SparkTagGetColorsUseCase: SparkTagGetColorsUseCaseable {

    // MARK: - Properties

    private let getIntentColorsUseCase: SparkTagGetIntentColorsUseCaseable

    // MARK: - Initialization

    init(getIntentColorsUseCase: SparkTagGetIntentColorsUseCaseable = SparkTagGetIntentColorsUseCase()) {
        self.getIntentColorsUseCase = getIntentColorsUseCase
    }

    // MARK: - Methods

    func execute(from theming: SparkTagTheming) -> SparkTagColorables {
        let intentColors = self.getIntentColorsUseCase.execute(for: theming.intentColor,
                                                               on: theming.theme.colors)

        switch theming.variant {
        case .filled:
            return SparkTagColors(backgroundColor: intentColors.color,
                                  borderColor: nil,
                                  foregroundColor: intentColors.onColor)

        case .outlined:
            return SparkTagColors(backgroundColor: intentColors.surfaceColor,
                                  borderColor: intentColors.color,
                                  foregroundColor: intentColors.color)

        case .tinted:
            return SparkTagColors(backgroundColor: intentColors.containerColor,
                                  borderColor: nil,
                                  foregroundColor: intentColors.onContainerColor)
        }
    }
}
