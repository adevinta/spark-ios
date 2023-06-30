//
//  ButtonGetStateUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonGetStateUseCaseable {
    func execute(forIsEnabled isEnabled: Bool,
                 dims: Dims) -> ButtonState
}

struct ButtonGetStateUseCase: ButtonGetStateUseCaseable {

    // MARK: - Methods

    func execute(
        forIsEnabled isEnabled: Bool,
        dims: Dims
    ) -> ButtonState {
        let opacity = isEnabled ? dims.none : dims.dim3

        return ButtonStateDefault(
            isInteractionEnabled: isEnabled,
            opacity: opacity
        )
    }
}
