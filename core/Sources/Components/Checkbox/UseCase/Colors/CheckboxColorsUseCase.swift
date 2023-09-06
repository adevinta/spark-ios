//
//  CheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol CheckboxColorsUseCaseable {
    func execute(from theme: Theme, state: SelectButtonState) -> CheckboxColorables
}

struct CheckboxColorsUseCase: CheckboxColorsUseCaseable {

    // MARK: - Properties

    private let stateColorsUseCase: CheckboxGetStateColorsUseCaseable

    // MARK: - Initialization

    init(stateColorsUseCase: CheckboxGetStateColorsUseCaseable = CheckboxGetStateColorsUseCase()) {
        self.stateColorsUseCase = stateColorsUseCase
    }

    // MARK: - Methods

    func execute(from theme: Theme, state: SelectButtonState) -> CheckboxColorables {
        let colors = self.stateColorsUseCase.execute(for: state, from: theme.colors)

        return CheckboxColors(
            textColor: colors.textColor,
            checkboxTintColor: colors.checkboxColor,
            checkboxIconColor: colors.checkboxIconColor,
            pressedBorderColor: colors.pressedBorderColor
        )
    }
}
