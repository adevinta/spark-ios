//
//  ButtonGetHeightUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonGetHeightUseCaseable {
    func execute(forSize size: ButtonSize) -> CGFloat
}

struct ButtonGetHeightUseCase: ButtonGetHeightUseCaseable {

    // MARK: - Methods

    func execute(forSize size: ButtonSize) -> CGFloat {
        switch size {
        case .small:
            return 32
        case .medium:
            return 44
        case .large:
            return 56
        }
    }
}
