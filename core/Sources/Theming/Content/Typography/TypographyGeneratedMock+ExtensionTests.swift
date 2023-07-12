//
//  TypographyGeneratedMock+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

extension TypographyGeneratedMock {

    // MARK: - Methods

    static func mocked() -> TypographyGeneratedMock {
        let typography = TypographyGeneratedMock()

        typography.body1 = TypographyFontTokenGeneratedMock.mocked(.body)
        typography.body2 = TypographyFontTokenGeneratedMock.mocked(.body)
        typography.caption = TypographyFontTokenGeneratedMock.mocked(.caption)
        typography.captionHighlight = TypographyFontTokenGeneratedMock.mocked(.caption.bold())
        typography.smallHighlight = TypographyFontTokenGeneratedMock.mocked(.caption2.bold())
        typography.subhead = TypographyFontTokenGeneratedMock.mocked(.subheadline)

        return typography
    }
}

extension TypographyFontTokenGeneratedMock {
    // MARK: - Methods

    static func mocked(_ font: Font) -> TypographyFontTokenGeneratedMock {
        let fontToken = TypographyFontTokenGeneratedMock()
        fontToken.font = font
        return fontToken
    }
}
