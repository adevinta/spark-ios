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
        switch alignment {
        case .left:
            horizontalSpacing = spacing.medium
            
        case .right:
            horizontalSpacing = spacing.xxxLarge
        }

        return SwitchPosition(
            isToggleOnLeft: alignment == .left,
            horizontalSpacing: horizontalSpacing
        )
    }
}
