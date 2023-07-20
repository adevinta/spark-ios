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
                 text: String?,
                 attributedText: AttributedStringEither?) -> ButtonContent
}

struct ButtonGetContentUseCase: ButtonGetContentUseCaseable {

    // MARK: - Methods

    func execute(
        alignment: ButtonAlignment,
        iconImage: ImageEither?,
        text: String?,
        attributedText: AttributedStringEither?
    ) -> ButtonContent {
        let shouldShowIconImage = (iconImage != nil) ? true : false
        let isIconImageTrailing = (shouldShowIconImage && alignment == .trailingIcon) ? true : false
        let iconImage = shouldShowIconImage ? iconImage : nil

        let shouldShowText = (text != nil) || (attributedText != nil)

        return .init(
            shouldShowIconImage: shouldShowIconImage,
            isIconImageTrailing: isIconImageTrailing,
            iconImage: iconImage,
            shouldShowText: shouldShowText
        )
    }
}
