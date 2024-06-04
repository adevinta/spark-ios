//
//  SwitchGetToggleStateUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable
protocol SwitchGetToggleStateUseCaseable {
    func execute(isEnabled: Bool,
                 dims: Dims) -> SwitchToggleState
}

struct SwitchGetToggleStateUseCase: SwitchGetToggleStateUseCaseable {

    // MARK: - Methods

    func execute(
        isEnabled: Bool,
        dims: Dims
    ) -> SwitchToggleState {
        let opacity = isEnabled ? dims.none : dims.dim3

        return .init(
            interactionEnabled: isEnabled,
            opacity: opacity
        )
    }
}
