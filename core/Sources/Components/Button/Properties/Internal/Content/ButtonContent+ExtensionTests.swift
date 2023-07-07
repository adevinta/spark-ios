//
//  ButtonContent.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ButtonContent {

    // MARK: - Properties

    static func mocked(
        shouldShowIconImage: Bool = true ,
        isIconImageOnRight: Bool = false,
        iconImage: ImageEither? = .left(IconographyTests.shared.arrow),
        shouldShowText: Bool = true
    ) -> Self {
        return .init(
            shouldShowIconImage: shouldShowIconImage,
            isIconImageOnRight: isIconImageOnRight,
            iconImage: iconImage,
            shouldShowText: shouldShowText
        )
    }
}
