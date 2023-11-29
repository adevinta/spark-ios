//
//  ButtonGetCurrentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetCurrentColorsUseCaseable {
    @available(*, deprecated, message: "Use the execute function without the displayedTitleType parameter instead. Must be removed when ButtonViewModelDeprecated is deleted")
    func execute(colors: ButtonColors,
                 isPressed: Bool,
                 displayedTitleType: DisplayedTextType) -> ButtonCurrentColors
}

struct ButtonGetCurrentColorsUseCase: ButtonGetCurrentColorsUseCaseable {

    // MARK: - Methods

    func execute(
        colors: ButtonColors,
        isPressed: Bool,
        displayedTitleType: DisplayedTextType
    ) -> ButtonCurrentColors {
        // Reload title foreground color only if the title is displayed and not the attributedTitle
        let isTitleColor = (displayedTitleType == .text)
        let titleColor = isTitleColor ? colors.foregroundColor : nil

        if isPressed {
            return .init(
                iconTintColor: colors.foregroundColor,
                titleColor: titleColor,
                backgroundColor: colors.pressedBackgroundColor,
                borderColor: colors.pressedBorderColor
            )
        } else {
            return .init(
                iconTintColor: colors.foregroundColor,
                titleColor: titleColor,
                backgroundColor: colors.backgroundColor,
                borderColor: colors.borderColor
            )
        }
    }
}
