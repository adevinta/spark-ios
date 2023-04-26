//
//  TagGetColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagGetColorsUseCaseable {
    func execute(from theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant) -> TagColorables
}

struct TagGetColorsUseCase: TagGetColorsUseCaseable {

    // MARK: - Properties

    private let getIntentColorsUseCase: TagGetIntentColorsUseCaseable

    // MARK: - Initialization

    init(getIntentColorsUseCase: TagGetIntentColorsUseCaseable = TagGetIntentColorsUseCase()) {
        self.getIntentColorsUseCase = getIntentColorsUseCase
    }

    // MARK: - Methods

    func execute(from theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant) -> TagColorables {
        let intentColors = self.getIntentColorsUseCase.execute(for: intentColor,
                                                               on: theme.colors)

        switch variant {
        case .filled:
            return TagColors(backgroundColor: intentColors.color,
                             borderColor: intentColors.color,
                             foregroundColor: intentColors.onColor)

        case .outlined:
            return TagColors(backgroundColor: intentColors.surfaceColor,
                             borderColor: intentColors.color,
                             foregroundColor: intentColors.color)

        case .tinted:
            return TagColors(backgroundColor: intentColors.containerColor,
                             borderColor: intentColors.containerColor,
                             foregroundColor: intentColors.onContainerColor)
        }
    }
}
