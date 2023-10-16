//
//  ButtonGetContentUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetContentUseCaseable {
    func execute(alignment: ButtonAlignment,
                 iconImage: ImageEither?,
                 containsText: Bool) -> ButtonContent
}

struct ButtonGetContentUseCase: ButtonGetContentUseCaseable {

    // MARK: - Methods

    func execute(
        alignment: ButtonAlignment,
        iconImage: ImageEither?,
        containsText: Bool
    ) -> ButtonContent {
        let shouldShowIconImage = (iconImage != nil) ? true : false
        let isIconImageTrailing = (shouldShowIconImage && alignment == .trailingIcon) ? true : false
        let iconImage = shouldShowIconImage ? iconImage : nil

        return .init(
            shouldShowIconImage: shouldShowIconImage,
            isIconImageTrailing: isIconImageTrailing,
            iconImage: iconImage,
            shouldShowText: containsText
        )
    }
}
