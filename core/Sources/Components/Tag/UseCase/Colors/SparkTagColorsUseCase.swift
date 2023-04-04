//
//  SparkTagColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkTagColorsUseCaseable {
    func execute(from theming: SparkTagTheming) -> SparkTagColorables
}

struct SparkTagColorsUseCase: SparkTagColorsUseCaseable {

    // MARK: - Properties

    private let intentColorsUseCase: SparkTagIntentColorsUseCaseable

    // MARK: - Initialization

    init(intentColorsUseCase: SparkTagIntentColorsUseCaseable = SparkTagIntentColorsUseCase()) {
        self.intentColorsUseCase = intentColorsUseCase
    }

    // MARK: - Methods

    func execute(from theming: SparkTagTheming) -> SparkTagColorables {
        let intentColors = self.intentColorsUseCase.execute(for: theming.intentColor,
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
