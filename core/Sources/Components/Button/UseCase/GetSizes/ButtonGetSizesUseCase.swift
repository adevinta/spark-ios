//
//  ButtonGetSizesUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ButtonGetSizesUseCaseable {
    func execute(for size: ButtonSize,
                 isOnlyIcon: Bool) -> ButtonSizes
}

struct ButtonGetSizesUseCase: ButtonGetSizesUseCaseable {

    // MARK: - Methods

    func execute(for size: ButtonSize,
                 isOnlyIcon: Bool) -> ButtonSizes {
        let height: CGFloat
        switch size {
        case .small:
            height = 32
        case .medium:
            height = 44
        case .large:
            height = 56
        }

        // The value is differente only when there is only an icon and the size is large
        let iconSize: CGFloat = (isOnlyIcon && size == .large) ? 24 : 16

        return .init(height: height, iconSize: iconSize)
    }
}
