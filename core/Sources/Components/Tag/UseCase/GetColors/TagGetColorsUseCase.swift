//
//  TagGetColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagGetColorsUseCaseable {
    func execute(for theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant) -> TagColors
}

struct TagGetColorsUseCase: TagGetColorsUseCaseable {

    // MARK: - Properties

    private let getIntentColorsUseCase: any TagGetIntentColorsUseCaseable

    // MARK: - Initialization

    init(getIntentColorsUseCase: any TagGetIntentColorsUseCaseable = TagGetIntentColorsUseCase()) {
        self.getIntentColorsUseCase = getIntentColorsUseCase
    }

    // MARK: - Methods

    func execute(for theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant) -> TagColors {
        let intentColors = self.getIntentColorsUseCase.execute(
            for: intentColor,
            colors: theme.colors
        )

        switch variant {
        case .filled:
            return .init(
                backgroundColor: intentColors.color,
                borderColor: intentColors.color,
                foregroundColor: intentColors.onColor
            )

        case .outlined:
            return .init(
                backgroundColor: intentColors.surfaceColor,
                borderColor: intentColors.color,
                foregroundColor: intentColors.color
            )

        case .tinted:
            return .init(
                backgroundColor: intentColors.containerColor,
                borderColor: intentColors.containerColor,
                foregroundColor: intentColors.onContainerColor
            )
        }
    }
}
