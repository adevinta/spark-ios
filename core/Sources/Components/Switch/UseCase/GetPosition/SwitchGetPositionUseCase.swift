//
//  SwitchGetPositionUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetPositionUseCaseable {
    func execute(alignment: SwitchAlignment,
                 spacing: LayoutSpacing) -> SwitchPosition
}

struct SwitchGetPositionUseCase: SwitchGetPositionUseCaseable {

    // MARK: - Methods

    func execute(
        alignment: SwitchAlignment,
        spacing: LayoutSpacing
    ) -> SwitchPosition {
        let horizontalSpacing: CGFloat
        let isToggleOnLeft: Bool
        switch alignment {
        case .left:
            horizontalSpacing = spacing.medium
            isToggleOnLeft = true
            
        case .right:
            horizontalSpacing = spacing.xxxLarge
            isToggleOnLeft = false
        }

        return .init(
            isToggleOnLeft: isToggleOnLeft,
            horizontalSpacing: horizontalSpacing
        )
    }
}
