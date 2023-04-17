//
//  CheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol CheckboxColorsUseCaseable {
    func execute(from theming: CheckboxTheming, state: SelectButtonState) -> CheckboxColorables
}

struct CheckboxColorsUseCase: CheckboxColorsUseCaseable {

    // MARK: - Properties

    private let intentColorsUseCase: CheckboxStateColorsUseCaseable

    // MARK: - Initialization

    init(intentColorsUseCase: CheckboxStateColorsUseCaseable = CheckboxStateColorsUseCase()) {
        self.intentColorsUseCase = intentColorsUseCase
    }

    // MARK: - Methods

    func execute(from theming: CheckboxTheming, state: SelectButtonState) -> CheckboxColorables {
        let intentColors = self.intentColorsUseCase.execute(for: state,
                                                            on: theming.theme.colors)

        switch theming.variant {
        case .filled:
            return CheckboxColors(textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.checkboxColor,
                                       checkboxIconColor: intentColors.checkboxIconColor,
                                       pressedBorderColor: intentColors.pressedBorderColor)

        case .outlined:
            return CheckboxColors(textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.checkboxColor,
                                       checkboxIconColor: intentColors.checkboxIconColor,
                                       pressedBorderColor: intentColors.pressedBorderColor)

        case .tinted:
            return CheckboxColors(textColor: intentColors.textColor,
                                       checkboxTintColor: intentColors.checkboxColor,
                                       checkboxIconColor: intentColors.checkboxIconColor,
                                       pressedBorderColor: intentColors.pressedBorderColor)
        }
    }
}
