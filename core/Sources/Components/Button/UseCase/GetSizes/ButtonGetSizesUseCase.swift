//
//  ButtonGetSizesUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol ButtonGetSizesUseCaseable {
    @available(*, deprecated, message: "Use the execute function with the type parameter instead. Must be removed when ButtonViewModelDeprecated is deleted")
    func execute(size: ButtonSize,
                 isOnlyIcon: Bool) -> ButtonSizes

    func execute(size: ButtonSize,
                 type: ButtonType) -> ButtonSizes
}

struct ButtonGetSizesUseCase: ButtonGetSizesUseCaseable {

    // MARK: - Methods

    func execute(size: ButtonSize,
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

        // The value is differente only when there is only an image and the size is large
        let imageSize: CGFloat = (isOnlyIcon && size == .large) ? 24 : 16

        return .init(height: height, imageSize: imageSize)
    }

    func execute(
        size: ButtonSize,
        type: ButtonType
    ) -> ButtonSizes {
        let height: CGFloat
        switch size {
        case .small:
            height = 32
        case .medium:
            height = 44
        case .large:
            height = 56
        }

        // The value is differente only when there is only an image and the size is large
        let imageSize: CGFloat = (type == .iconButton && size == .large) ? 24 : 16

        return .init(height: height, imageSize: imageSize)
    }
}
