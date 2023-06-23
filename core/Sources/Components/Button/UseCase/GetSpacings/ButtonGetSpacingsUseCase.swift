//
//  ButtonGetSpacingsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonGetSpacingsUseCaseable {
    func execute(forSpacing spacing: LayoutSpacing) -> ButtonSpacingsProtocol
}

struct ButtonGetSpacingsUseCase: ButtonGetSpacingsUseCaseable {

    // MARK: - Methods

    func execute(
        forSpacing spacing: LayoutSpacing
    ) -> ButtonSpacingsProtocol {
        return ButtonSpacings(
            verticalSpacing: spacing.medium,
            horizontalSpacing: spacing.large,
            horizontalPadding: spacing.medium
        )
    }
}
