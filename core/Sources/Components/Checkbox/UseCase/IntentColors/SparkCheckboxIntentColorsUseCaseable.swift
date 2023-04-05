//
//  SparkTagIntentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkCheckboxIntentColorsUseCaseable {
    func execute(for intentColor: SparkCheckboxIntentColor,
                 on colors: Colors) -> SparkCheckboxIntentColorables
}

struct SparkCheckboxIntentColorsUseCase: SparkCheckboxIntentColorsUseCaseable {

    // MARK: - Methods

    func execute(for intentColor: SparkCheckboxIntentColor,
                 on colors: Colors) -> SparkCheckboxIntentColorables {
        let surfaceColor = colors.base.surface
        let textColor = colors.base.onSurface

        switch intentColor {
        case .neutral:
            return SparkCheckboxIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor,
                                             textColor: textColor)
        }
    }
}
