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

        typography.display1 = TypographyFontTokenGeneratedMock.mocked(.title)
        typography.display2 = TypographyFontTokenGeneratedMock.mocked(.title2)
        typography.display3 = TypographyFontTokenGeneratedMock.mocked(.title3)

        typography.headline1 = TypographyFontTokenGeneratedMock.mocked(.headline)
        typography.headline2 = TypographyFontTokenGeneratedMock.mocked(.headline)

        typography.subhead = TypographyFontTokenGeneratedMock.mocked(.subheadline)

        typography.body1 = TypographyFontTokenGeneratedMock.mocked(.body)
        typography.body1Highlight = TypographyFontTokenGeneratedMock.mocked(.body.bold())
        typography.body2 = TypographyFontTokenGeneratedMock.mocked(.body)
        typography.body2Highlight = TypographyFontTokenGeneratedMock.mocked(.body.bold())

        typography.caption = TypographyFontTokenGeneratedMock.mocked(.caption)
        typography.captionHighlight = TypographyFontTokenGeneratedMock.mocked(.caption.bold())

        typography.small = TypographyFontTokenGeneratedMock.mocked(.caption2)
        typography.smallHighlight = TypographyFontTokenGeneratedMock.mocked(.caption2.bold())
        typography.subhead = TypographyFontTokenGeneratedMock.mocked(.subheadline)

        typography.callout = TypographyFontTokenGeneratedMock.mocked(.callout)
        
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

    static func mocked(uiFont: UIFont, font: Font) -> TypographyFontTokenGeneratedMock {
        let fontToken = TypographyFontTokenGeneratedMock()
        fontToken.uiFont = uiFont
        fontToken.font = font
        return fontToken
    }
}
