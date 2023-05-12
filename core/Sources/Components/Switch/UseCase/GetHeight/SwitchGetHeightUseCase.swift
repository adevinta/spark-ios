//
//  SwitchGetHeightUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetHeightUseCaseable {
    func execute(for size: SwitchSize) -> CGFloat
}

struct SwitchGetHeightUseCase: SwitchGetHeightUseCaseable {

    // MARK: - Methods

    func execute(for size: SwitchSize) -> CGFloat {
        switch size {
        case .small:
            return 24

        case .medium:
            return 32
        }
    }
}
