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
                 statusAndStateColor: SwitchStatusColorables) -> FullColorToken
}

struct SwitchGetToggleColorUseCase: SwitchGetToggleColorUseCaseable {

    // MARK: - Methods

    func execute(forIsOn isOn: Bool,
                 statusAndStateColor: SwitchStatusColorables) -> FullColorToken {
        return isOn ? statusAndStateColor.onFullColorToken : statusAndStateColor.offFullColorToken
    }
}
