//
//  CheckboxGetStateColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol CheckboxStateColorsUseCaseable {
    func execute(from colors: Colors,
                 dims: Dims,
                 intent: CheckboxIntent
    ) -> CheckboxStateColors
}

struct CheckboxStateColorsUseCase: CheckboxStateColorsUseCaseable {

    // MARK: - Properties
    private let checkboxColorsUseCase: CheckboxColorsUseCaseable

    // MARK: - Initializer

    /// Initializer
    ///
    /// Parameters:
    /// - intentColorsUsedCase: A use case to calcualte the intent colors.
    init(checkboxColorsUseCaseable: CheckboxColorsUseCaseable = CheckboxColorsUseCase()) {
        self.checkboxColorsUseCase = checkboxColorsUseCaseable
    }

    // MARK: - Functions

    /// The funcion execute calculates the chip colors based on the parameters.
    ///
    /// Parameters:
    /// - theme: The current theme to be used
    /// - variant: The variant of the chip, whether it's filled, outlined, etc.
    /// - intent: The intent color of the chip, e.g. main, support

    func execute(from colors: Colors, dims: Dims, intent: CheckboxIntent) -> CheckboxStateColors {
        let checkboxColor: CheckboxColors = self.checkboxColorsUseCase.execute(from: colors, intent: intent) 

        return CheckboxStateColors(
            enable: checkboxColor,
            disable: .init(
                textColor: checkboxColor.textColor.opacity(dims.dim3),
                borderColor: checkboxColor.borderColor.opacity(dims.dim3),
                tintColor: checkboxColor.tintColor.opacity(dims.dim3),
                iconColor: checkboxColor.iconColor.opacity(dims.dim3),
                pressedBorderColor: checkboxColor.pressedBorderColor
            ),
            pressed: .init(
                textColor: checkboxColor.textColor,
                borderColor: checkboxColor.borderColor,
                tintColor: checkboxColor.tintColor,
                iconColor: checkboxColor.iconColor,
                pressedBorderColor: colors.basic.basicContainer
            )
        )
    }
}
