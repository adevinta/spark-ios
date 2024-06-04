//
//  ButtonGetSpacingsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol ButtonGetSpacingsUseCaseable {
    // sourcery: spacing = "Identical"
    func execute(spacing: LayoutSpacing) -> ButtonSpacings
}

struct ButtonGetSpacingsUseCase: ButtonGetSpacingsUseCaseable {

    // MARK: - Methods

    func execute(spacing: LayoutSpacing) -> ButtonSpacings {
        return .init(
            horizontalSpacing: spacing.large,
            horizontalPadding: spacing.medium
        )
    }
}
