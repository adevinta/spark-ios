//
//  TextLinkTypographiesMock+ExtensionTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 14/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SparkThemingTesting

extension TextLinkTypographies {

    // MARK: - Methods

    static func mocked() -> Self {
        let normalTypographyFontTokenMock = TypographyFontTokenGeneratedMock.mocked(
            uiFont: .systemFont(ofSize: 12),
            font: .title
        )
        let highlightTypographyFontTokenMock = TypographyFontTokenGeneratedMock.mocked(
            uiFont: .boldSystemFont(ofSize: 12),
            font: .title2
        )

        return .init(
            normal: normalTypographyFontTokenMock,
            highlight: highlightTypographyFontTokenMock
        )
    }
}
