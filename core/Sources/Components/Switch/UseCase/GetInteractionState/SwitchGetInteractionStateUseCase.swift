//
//  SwitchGetInteractionStateUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetInteractionStateUseCaseable {
    func execute(for state: SwitchState,
                 isOn: Bool,
                 on dims: Dims) -> SwitchInteractionStateable
}

struct SwitchGetInteractionStateUseCase: SwitchGetInteractionStateUseCaseable {

    // MARK: - Methods

    func execute(for state: SwitchState,
                 isOn: Bool,
                 on dims: Dims) -> SwitchInteractionStateable {
        var interactionEnabled: Bool
        var opacity: CGFloat

        switch state {
        case .enabled:
            interactionEnabled = true
            opacity = isOn ? 1 : dims.dim4

        case .disabled:
            interactionEnabled = false
            opacity = isOn ? dims.dim3 : 1
        }

        return SwitchInteractionState(
            interactionEnabled: interactionEnabled,
            opacity: opacity
        )
    }
}
