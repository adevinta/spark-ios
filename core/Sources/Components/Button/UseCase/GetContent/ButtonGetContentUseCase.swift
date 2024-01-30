//
//  ButtonGetContentUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@available(*, deprecated, message: "Must be removed when ButtonViewModelDeprecated is deleted")
// sourcery: AutoMockable
protocol ButtonGetContentUseCaseable {
    func execute(alignment: ButtonAlignmentDeprecated,
                 iconImage: ImageEither?,
                 containsTitle: Bool) -> ButtonContent
}

struct ButtonGetContentUseCase: ButtonGetContentUseCaseable {

    // MARK: - Methods

    func execute(
        alignment: ButtonAlignmentDeprecated,
        iconImage: ImageEither?,
        containsTitle: Bool
    ) -> ButtonContent {
        let shouldShowIconImage = (iconImage != nil) ? true : false
        let isIconImageTrailing = (shouldShowIconImage && alignment == .trailingIcon) ? true : false
        let iconImage = shouldShowIconImage ? iconImage : nil

        return .init(
            shouldShowIconImage: shouldShowIconImage,
            isIconImageTrailing: isIconImageTrailing,
            iconImage: iconImage,
            shouldShowTitle: containsTitle
        )
    }
}
