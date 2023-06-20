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
    func execute(forAlignment alignment: SwitchAlignment,
                 spacing: LayoutSpacing) -> SwitchPositionable
}

struct SwitchGetPositionUseCase: SwitchGetPositionUseCaseable {

    // MARK: - Methods

    func execute(forAlignment alignment: SwitchAlignment,
                 spacing: LayoutSpacing) -> SwitchPositionable {
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

        return SwitchPosition(
            isToggleOnLeft: isToggleOnLeft,
            horizontalSpacing: horizontalSpacing
        )
    }
}
