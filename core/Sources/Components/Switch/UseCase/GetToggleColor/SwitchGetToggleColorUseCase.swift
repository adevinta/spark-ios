//
//  SwitchGetToggleColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetToggleColorUseCaseable {
    func execute(forIsOn isOn: Bool,
                 statusAndStateColor: SwitchStatusColorables) -> any ColorToken
}

struct SwitchGetToggleColorUseCase: SwitchGetToggleColorUseCaseable {

    // MARK: - Methods

    func execute(forIsOn isOn: Bool,
                 statusAndStateColor: SwitchStatusColorables) -> any ColorToken {
        return isOn ? statusAndStateColor.onColorToken : statusAndStateColor.offColorToken
    }
}
