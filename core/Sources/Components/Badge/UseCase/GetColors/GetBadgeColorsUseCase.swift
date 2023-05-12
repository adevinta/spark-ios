//
//  GetBadgeColorsUseCase.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol BadgeGetColorsUseCaseable {
    func execute(from theme: Theme,
                 badgeType: BadgeIntentType) -> BadgeColorables
}

struct BadgeGetColorsUseCase: BadgeGetColorsUseCaseable {
    private let getIntentColorsUseCase: BadgeGetIntentColorsUseCaseable

    // MARK: - Initialization

    init(getIntentColorsUseCase: BadgeGetIntentColorsUseCaseable = BadgeGetIntentColorsUseCase()) {
        self.getIntentColorsUseCase = getIntentColorsUseCase
    }

    // MARK: - Getting colors

    func execute(from theme: Theme, badgeType: BadgeIntentType) -> BadgeColorables {
        getIntentColorsUseCase.execute(intentType: badgeType, on: theme.colors)
    }
}
