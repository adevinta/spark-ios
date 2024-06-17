//
//  TextEditorColorUseCaseTest.swift
//  SparkCore
//
//  Created by alican.aycil on 17.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class TextEditorColorsUseCaseTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()

    func test_Enabled() {
        let texteditorColors = TextEditorColorsUseCase().execute(theme: theme, intent: .neutral, isFocused: false, isEnabled: true, isReadonly: false)
        let expectedColors = TextEditorColors(
            text: theme.colors.base.onSurface,
            placeholder: theme.colors.base.onSurface.opacity(theme.dims.dim1),
            border: theme.colors.base.outline,
            background: theme.colors.base.surface
        )
        XCTAssertEqual(texteditorColors, expectedColors, "Wrong enabled state color")
    }

    func test_NotEnabled() {
        let texteditorColors = TextEditorColorsUseCase().execute(theme: theme, intent: .neutral, isFocused: false, isEnabled: false, isReadonly: false)
        let expectedColors = TextEditorColors(
            text: theme.colors.base.onSurface.opacity(theme.dims.dim3),
            placeholder: theme.colors.base.onSurface.opacity(theme.dims.dim1),
            border: theme.colors.base.onSurface.opacity(theme.dims.dim3),
            background: theme.colors.base.onSurface.opacity(theme.dims.dim5)
        )
        XCTAssertEqual(texteditorColors, expectedColors, "Wrong notEnabled state color")
    }

    func test_Focused() {
        let texteditorColors = TextEditorColorsUseCase().execute(theme: theme, intent: .neutral, isFocused: true, isEnabled: true, isReadonly: false)
        let expectedColors = TextEditorColors(
            text: theme.colors.base.onSurface,
            placeholder: theme.colors.base.onSurface.opacity(theme.dims.dim1),
            border: theme.colors.base.outlineHigh,
            background: theme.colors.base.surface
        )
        XCTAssertEqual(texteditorColors, expectedColors, "Wrong focused state color")
    }

    func test_Readonly() {
        let texteditorColors = TextEditorColorsUseCase().execute(theme: theme, intent: .neutral, isFocused: false, isEnabled: true, isReadonly: true)
        let expectedColors = TextEditorColors(
            text: theme.colors.base.onSurface.opacity(theme.dims.none),
            placeholder: theme.colors.base.onSurface.opacity(theme.dims.dim1),
            border: theme.colors.base.onSurface.opacity(theme.dims.dim3),
            background: theme.colors.base.onSurface.opacity(theme.dims.dim5)
        )
        XCTAssertEqual(texteditorColors, expectedColors, "Wrong readonly state color")
    }

    func test_Intents() {
        TextEditorIntent.allCases.forEach {
            let texteditorColors = TextEditorColorsUseCase().execute(theme: theme, intent: $0, isFocused: false, isEnabled: true, isReadonly: false)

            let borderColor: any ColorToken

            switch $0 {
            case .neutral:
                borderColor = theme.colors.base.outline
            case .alert:
                borderColor = theme.colors.feedback.alert
            case .error:
                borderColor = theme.colors.feedback.error
            case .success:
                borderColor = theme.colors.feedback.success
            }

            let expectedColors = TextEditorColors(
                text: theme.colors.base.onSurface,
                placeholder: theme.colors.base.onSurface.opacity(theme.dims.dim1),
                border: borderColor,
                background: theme.colors.base.surface
            )
            XCTAssertEqual(texteditorColors, expectedColors, "Wrong intent color")
        }
    }
}
