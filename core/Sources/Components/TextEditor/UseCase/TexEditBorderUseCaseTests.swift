//
//  TexEditBorderUseCase.swift
//  SparkCoreUnitTests
//
//  Created by alican.aycil on 18.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class TextEditorBorderUseCaseTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()

    func test_Enabled() {
        TextEditorIntent.allCases.forEach { intent in

            let texteditorBorders = TextEditorBordersUseCase().execute(theme: theme, intent: intent, isFocused: false)

            let expectedBorders = TextEditorBorders (
                radius: theme.border.radius.large,
                width: theme.border.width.small
            )
            XCTAssertEqual(texteditorBorders, expectedBorders, "Wrong border width")
        }
    }


    func test_Focused() {
        TextEditorIntent.allCases.forEach {
            let texteditorBorders = TextEditorBordersUseCase().execute(theme: theme, intent: $0, isFocused: true)

            let expectedBorders = TextEditorBorders (
                radius: theme.border.radius.large,
                width:  theme.border.width.medium
            )
            XCTAssertEqual(texteditorBorders, expectedBorders, "Wrong border width")
        }
    }
}
