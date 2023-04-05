//
//  SparkCheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkCheckboxColorsUseCaseable {
    func execute(from theming: SparkCheckboxTheming) -> SparkCheckboxColorables
}

struct SparkCheckboxColorsUseCase: SparkCheckboxColorsUseCaseable {

    // MARK: - Properties

    private let intentColorsUseCase: SparkCheckboxIntentColorsUseCaseable

    // MARK: - Initialization

    init(intentColorsUseCase: SparkCheckboxIntentColorsUseCaseable = SparkCheckboxIntentColorsUseCase()) {
        self.intentColorsUseCase = intentColorsUseCase
    }

    // MARK: - Methods

    func execute(from theming: SparkCheckboxTheming) -> SparkCheckboxColorables {
        let intentColors = self.intentColorsUseCase.execute(for: theming.intentColor,
                                                            on: theming.theme.colors)

        switch theming.variant {
        case .filled:
            return SparkCheckboxColors(backgroundColor: intentColors.color,
                                       borderColor: nil,
                                       foregroundColor: intentColors.onColor,
                                       textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.onColor)

        case .outlined:
            return SparkCheckboxColors(backgroundColor: intentColors.surfaceColor,
                                       borderColor: intentColors.color,
                                       foregroundColor: intentColors.color,
                                       textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.onColor)

        case .tinted:
            return SparkCheckboxColors(backgroundColor: intentColors.containerColor,
                                       borderColor: nil,
                                       foregroundColor: intentColors.onContainerColor,
                                       textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.onColor)
        }
    }
}
