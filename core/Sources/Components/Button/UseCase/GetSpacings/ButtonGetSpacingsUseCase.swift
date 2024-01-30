//
//  ButtonGetSpacingsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol ButtonGetSpacingsUseCaseable {
    @available(*, deprecated, message: "Use the execute function without isOnlyIcon parameter instead. Must be removed when ButtonViewModelDeprecated is deleted")
    // sourcery: spacing = "Identical"
    func execute(spacing: LayoutSpacing,
                 isOnlyIcon: Bool) -> ButtonSpacings

    // sourcery: spacing = "Identical"
    func execute(spacing: LayoutSpacing) -> ButtonSpacings
}

struct ButtonGetSpacingsUseCase: ButtonGetSpacingsUseCaseable {

    // MARK: - Methods

    func execute(
        spacing: LayoutSpacing,
        isOnlyIcon: Bool
    ) -> ButtonSpacings {
        if isOnlyIcon {
            return .init(
                verticalSpacing: 0,
                horizontalSpacing: 0,
                horizontalPadding: 0
            )
        } else {
            return .init(
                verticalSpacing: spacing.medium,
                horizontalSpacing: spacing.large,
                horizontalPadding: spacing.medium
            )
        }
    }

    func execute(spacing: LayoutSpacing) -> ButtonSpacings {
        return .init(
            verticalSpacing: spacing.medium,
            horizontalSpacing: spacing.large,
            horizontalPadding: spacing.medium
        )
    }
}
