//
//  SwitchGetToggleStateUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetToggleStateUseCaseable {
    func execute(forIsEnabled isEnabled: Bool) -> SwitchToggleStateable
}

struct SwitchGetToggleStateUseCase: SwitchGetToggleStateUseCaseable {

    // MARK: - Methods

    func execute(forIsEnabled isEnabled: Bool) -> SwitchToggleStateable {
        let opacity = isEnabled ? 1 : 0.4

        return SwitchToggleState(
            interactionEnabled: isEnabled,
            opacity: opacity
        )
    }
}
