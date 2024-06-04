//
//  SwitchGetPositionUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

// sourcery: AutoMockable
protocol SwitchGetPositionUseCaseable {
    func execute(alignment: SwitchAlignment,
                 spacing: LayoutSpacing,
                 containsText: Bool) -> SwitchPosition
}

struct SwitchGetPositionUseCase: SwitchGetPositionUseCaseable {

    // MARK: - Methods

    func execute(
        alignment: SwitchAlignment,
        spacing: LayoutSpacing,
        containsText: Bool
    ) -> SwitchPosition {
        var horizontalSpacing: CGFloat
        let isToggleOnLeft: Bool
        switch alignment {
        case .left:
            horizontalSpacing = spacing.medium
            isToggleOnLeft = true
            
        case .right:
            horizontalSpacing = spacing.xxxLarge
            isToggleOnLeft = false
        }

        // No text ? No space !
        if !containsText {
            horizontalSpacing = 0
        }

        return .init(
            isToggleOnLeft: isToggleOnLeft,
            horizontalSpacing: horizontalSpacing
        )
    }
}
