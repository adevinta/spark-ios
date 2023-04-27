//
//  CheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol CheckboxColorsUseCaseable {
    func execute(from theming: Theme, state: SelectButtonState) -> CheckboxColorables
}

struct CheckboxColorsUseCase: CheckboxColorsUseCaseable {

    // MARK: - Properties

    private let stateColorsUseCase: CheckboxStateColorsUseCaseable

    // MARK: - Initialization

    init(stateColorsUseCase: CheckboxStateColorsUseCaseable = CheckboxStateColorsUseCase()) {
        self.stateColorsUseCase = stateColorsUseCase
    }

    // MARK: - Methods

    func execute(from theming: Theme, state: SelectButtonState) -> CheckboxColorables {
        let colors = self.stateColorsUseCase.execute(for: state, on: theming.colors)

        return CheckboxColors(
            textColor: colors.textColor,
            checkboxTintColor: colors.checkboxColor,
            checkboxIconColor: colors.checkboxIconColor,
            pressedBorderColor: colors.pressedBorderColor
        )
    }
}
