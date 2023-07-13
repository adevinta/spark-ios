//
//  ButtonGetCurrentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetCurrentColorsUseCaseable {
    func execute(for colors: ButtonColors, isPressed: Bool) -> ButtonCurrentColors
}

struct ButtonGetCurrentColorsUseCase: ButtonGetCurrentColorsUseCaseable {

    // MARK: - Methods

    func execute(
        for colors: ButtonColors,
        isPressed: Bool
    ) -> ButtonCurrentColors {
        if isPressed {
            return .init(
                foregroundColor: colors.foregroundColor,
                backgroundColor: colors.pressedBackgroundColor,
                borderColor: colors.pressedBorderColor
            )
        } else {
            return .init(
                foregroundColor: colors.foregroundColor,
                backgroundColor: colors.backgroundColor,
                borderColor: colors.borderColor
            )
        }
    }
}
