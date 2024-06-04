//
//  TextLinkGetImageSizeUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 14/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol TextLinkGetImageSizeUseCaseable {
    func execute(typographies: TextLinkTypographies) -> TextLinkImageSize
}

struct TextLinkGetImageSizeUseCase: TextLinkGetImageSizeUseCaseable {

    // MARK: - Methods

    func execute(
        typographies: TextLinkTypographies
    ) -> TextLinkImageSize {
        let lineHeight = typographies.highlight.uiFont.lineHeight
        let pointSize = typographies.highlight.uiFont.pointSize

        return .init(
            size: pointSize,
            padding: (abs(lineHeight - pointSize)) / 2
        )
    }
}
