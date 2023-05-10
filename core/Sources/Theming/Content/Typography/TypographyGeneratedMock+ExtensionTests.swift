//
//  TypographyGeneratedMock+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension TypographyGeneratedMock {

    // MARK: - Methods

    static func mocked() -> TypographyGeneratedMock {
        let typography = TypographyGeneratedMock()

        let body1 = TypographyFontTokenGeneratedMock()
        body1.font = .body

        let caption = TypographyFontTokenGeneratedMock()
        caption.font = .caption

        let body2 = TypographyFontTokenGeneratedMock()
        body2.font = .body

        typography.body1 = body1
        typography.body2 = body2
        typography.caption = caption

        return typography
    }
}
