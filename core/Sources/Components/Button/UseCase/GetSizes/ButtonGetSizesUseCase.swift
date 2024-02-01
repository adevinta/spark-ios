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

    // MARK: - Constants

    private enum Constants {
        enum Height {
            static var small: CGFloat = 32
            static var medium: CGFloat = 44
            static var large: CGFloat = 56
        }

        enum ImageSize {
            static var medium: CGFloat = 16
            static var large: CGFloat = 24
        }
    }

    // MARK: - Methods

    func execute(size: ButtonSize,
                 isOnlyIcon: Bool) -> ButtonSizes {
        let height: CGFloat
        switch size {
        case .small:
            height = Constants.Height.small
        case .medium:
            height = Constants.Height.medium
        case .large:
            height = Constants.Height.large
        }

        // The value is differente only when there is only an image and the size is large
        let imageSize: CGFloat = (isOnlyIcon && size == .large) ? Constants.ImageSize.large : Constants.ImageSize.medium

        return .init(height: height, imageSize: imageSize)
    }

    func execute(
        size: ButtonSize,
        type: ButtonType
    ) -> ButtonSizes {
        let height: CGFloat
        switch size {
        case .small:
            height = Constants.Height.small
        case .medium:
            height = Constants.Height.medium
        case .large:
            height = Constants.Height.large
        }

        // The value is differente only when there is only an image and the size is large
        let imageSize: CGFloat = (type == .iconButton && size == .large) ? Constants.ImageSize.large : Constants.ImageSize.medium

        return .init(height: height, imageSize: imageSize)
    }
}
