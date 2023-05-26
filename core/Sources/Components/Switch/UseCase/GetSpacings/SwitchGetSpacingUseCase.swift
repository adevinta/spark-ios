//
//  SwitchGetSpacingUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetSpacingUseCaseable {
    func execute(for alignment: SwitchAlignment,
                 on spacing: LayoutSpacing) -> SwitchSpacingable
}

struct SwitchGetSpacingUseCase: SwitchGetSpacingUseCaseable {

    // MARK: - Methods

    func execute(for alignment: SwitchAlignment,
                 on spacing: LayoutSpacing) -> SwitchSpacingable {
        var horizontal: CGFloat
        switch alignment {
        case .left:
            horizontal = spacing.medium
            
        case .right:
            horizontal = spacing.xxxLarge
        }

        return SwitchSpacing(
            horizontal: horizontal,
            vertical: spacing.xLarge
        )
    }
}
