//
//  ButtonGetContentUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonGetContentUseCaseable {
    func execute(forAlignment alignment: ButtonAlignment,
                 iconImage: ImageEither?,
                 text: String?,
                 attributedText: AttributedStringEither?) -> ButtonContent
}

struct ButtonGetContentUseCase: ButtonGetContentUseCaseable {

    // MARK: - Methods

    func execute(
        forAlignment alignment: ButtonAlignment,
        iconImage: ImageEither?,
        text: String?,
        attributedText: AttributedStringEither?
    ) -> ButtonContent {
        let showIconImage = (iconImage != nil) ? true : false
        let isIconImageOnRight = (showIconImage && alignment == .trailingIcon) ? true : false
        let iconImage = showIconImage ? iconImage : nil

        let showText = (text != nil) || (attributedText != nil)

        return ButtonContentDefault(
            showIconImage: showIconImage,
            isIconImageOnRight: isIconImageOnRight,
            iconImage: iconImage,
            showText: showText
        )
    }
}
