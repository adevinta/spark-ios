//
//  TagGetColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// TODO: rename paremeters

// sourcery: AutoMockable
protocol TagGetColorsUseCaseable {
    func execute(forTheme theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant) -> TagColorables
}

struct TagGetColorsUseCase: TagGetColorsUseCaseable {

    // MARK: - Properties

    private let getIntentColorsUseCase: any TagGetIntentColorsUseCaseable

    // MARK: - Initialization

    init(getIntentColorsUseCase: any TagGetIntentColorsUseCaseable = TagGetIntentColorsUseCase()) {
        self.getIntentColorsUseCase = getIntentColorsUseCase
    }

    // MARK: - Methods

    func execute(forTheme theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant) -> TagColorables {
        let intentColors = self.getIntentColorsUseCase.execute(
            forIntentColor: intentColor,
            colors: theme.colors
        )

        switch variant {
        case .filled:
            return TagColors(
                backgroundColor: intentColors.color,
                borderColor: intentColors.color,
                foregroundColor: intentColors.onColor
            )

        case .outlined:
            return TagColors(
                backgroundColor: intentColors.surfaceColor,
                borderColor: intentColors.color,
                foregroundColor: intentColors.color
            )

        case .tinted:
            return TagColors(
                backgroundColor: intentColors.containerColor,
                borderColor: intentColors.containerColor,
                foregroundColor: intentColors.onContainerColor
            )
        }
    }
}
