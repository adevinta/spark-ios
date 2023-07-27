//
//  ButtonGetCurrentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetCurrentColorsUseCaseable {
    func execute(colors: ButtonColors,
                 isPressed: Bool,
                 displayedTextType: DisplayedTextType) -> ButtonCurrentColors
}

struct ButtonGetCurrentColorsUseCase: ButtonGetCurrentColorsUseCaseable {

    // MARK: - Methods

    func execute(
        colors: ButtonColors,
        isPressed: Bool,
        displayedTextType: DisplayedTextType
    ) -> ButtonCurrentColors {
        // Reload text foreground color only if the text is displayed and not the attributedText
        let isTextColor = (displayedTextType == .text)
        let textColor = isTextColor ? colors.foregroundColor : nil

        if isPressed {
            return .init(
                iconTintColor: colors.foregroundColor,
                textColor: textColor,
                backgroundColor: colors.pressedBackgroundColor,
                borderColor: colors.pressedBorderColor
            )
        } else {
            return .init(
                iconTintColor: colors.foregroundColor,
                textColor: textColor,
                backgroundColor: colors.backgroundColor,
                borderColor: colors.borderColor
            )
        }
    }
}
