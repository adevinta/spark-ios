//
//  SwitchViewModelDependencies.swift
//  SparkCore
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchViewModelDependenciesProtocol {
    var getColorsUseCase: SwitchGetColorsUseCaseable { get }
    var getImageUseCase: SwitchGetImageUseCaseable { get }
    var getToggleColorUseCase: SwitchGetToggleColorUseCaseable { get }
    var getPositionUseCase: SwitchGetPositionUseCaseable { get }
    var getToggleStateUseCase: SwitchGetToggleStateUseCaseable { get }
}

struct SwitchViewModelDependencies: SwitchViewModelDependenciesProtocol {

    // MARK: - Properties

    let getColorsUseCase: SwitchGetColorsUseCaseable
    let getImageUseCase: SwitchGetImageUseCaseable
    let getToggleColorUseCase: SwitchGetToggleColorUseCaseable
    let getPositionUseCase: SwitchGetPositionUseCaseable
    let getToggleStateUseCase: SwitchGetToggleStateUseCaseable

    // MARK: - Initialization

    init(
        getColorsUseCase: SwitchGetColorsUseCaseable = SwitchGetColorsUseCase(),
        getImageUseCase: SwitchGetImageUseCaseable = SwitchGetImageUseCase(),
        getToggleColorUseCase: SwitchGetToggleColorUseCaseable = SwitchGetToggleColorUseCase(),
        getPositionUseCase: SwitchGetPositionUseCaseable = SwitchGetPositionUseCase(),
        getToggleStateUseCase: SwitchGetToggleStateUseCaseable = SwitchGetToggleStateUseCase()
    ) {
        self.getColorsUseCase = getColorsUseCase
        self.getImageUseCase = getImageUseCase
        self.getToggleColorUseCase = getToggleColorUseCase
        self.getPositionUseCase = getPositionUseCase
        self.getToggleStateUseCase = getToggleStateUseCase
    }
}
