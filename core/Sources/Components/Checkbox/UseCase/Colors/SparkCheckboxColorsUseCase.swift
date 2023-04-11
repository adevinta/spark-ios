//
//  SparkCheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkCheckboxColorsUseCaseable {
    func execute(from theming: SparkCheckboxTheming, state: SparkSelectButtonState) -> SparkCheckboxColorables
}

struct SparkCheckboxColorsUseCase: SparkCheckboxColorsUseCaseable {

    // MARK: - Properties

    private let intentColorsUseCase: SparkCheckboxIntentColorsUseCaseable

    // MARK: - Initialization

    init(intentColorsUseCase: SparkCheckboxIntentColorsUseCaseable = SparkCheckboxIntentColorsUseCase()) {
        self.intentColorsUseCase = intentColorsUseCase
    }

    // MARK: - Methods

    func execute(from theming: SparkCheckboxTheming, state: SparkSelectButtonState) -> SparkCheckboxColorables {
        let intentColors = self.intentColorsUseCase.execute(for: state,
                                                            on: theming.theme.colors)

        switch theming.variant {
        case .filled:
            return SparkCheckboxColors(textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.checkboxColor,
                                       checkboxIconColor: intentColors.checkboxIconColor,
                                       pressedBorderColor: intentColors.pressedBorderColor)

        case .outlined:
            return SparkCheckboxColors(textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.checkboxColor,
                                       checkboxIconColor: intentColors.checkboxIconColor,
                                       pressedBorderColor: intentColors.pressedBorderColor)

        case .tinted:
            return SparkCheckboxColors(textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.checkboxColor,
                                       checkboxIconColor: intentColors.checkboxIconColor,
                                       pressedBorderColor: intentColors.pressedBorderColor)
        }
    }
}
