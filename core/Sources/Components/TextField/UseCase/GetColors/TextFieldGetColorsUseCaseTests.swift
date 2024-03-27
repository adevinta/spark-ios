//
//  TextFieldGetColorsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class TextFieldGetColorsUseCaseTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()

    func test_isFocused_isEnabled_isUserInteractionEnabled() {
        let intentAndExpectedBorderColorArray: [(intent: TextFieldIntent, expectedBorderColor: any ColorToken)] = [
            (intent: .success, self.theme.colors.feedback.success),
            (intent: .error, self.theme.colors.feedback.error),
            (intent: .alert, self.theme.colors.feedback.alert),
            (intent: .neutral, self.theme.colors.base.outlineHigh),
        ]
        XCTAssertEqual(intentAndExpectedBorderColorArray.count, TextFieldIntent.allCases.count, "Wrong intentAndExpectedBorderColorArray count")

        intentAndExpectedBorderColorArray.forEach {
            self._test_isFocused_isEnabled_isUserInteractionEnabled(with: $0.intent, expectedBorderColor: $0.expectedBorderColor)
        }
    }

    private func _test_isFocused_isEnabled_isUserInteractionEnabled(
        with intent: TextFieldIntent,
        expectedBorderColor: any ColorToken
    ) {
        // GIVEN
        let isFocused = true
        let isEnabled = true
        let isUserInteractionEnabled = true
        let useCase = TextFieldGetColorsUseCase()

        // WHEN
        let colors = useCase.execute(
            theme: self.theme,
            intent: intent,
            isFocused: isFocused,
            isEnabled: isEnabled,
            isUserInteractionEnabled: isUserInteractionEnabled
        )

        // THEN
        XCTAssertTrue(colors.text.equals(self.theme.colors.base.onSurface), "Wrong text color for intent: \(intent)")
        XCTAssertTrue(colors.placeholder.equals(self.theme.colors.base.onSurface.opacity(self.theme.dims.dim1)), "Wrong placeholder color for intent: \(intent)")
        XCTAssertTrue(colors.border.equals(expectedBorderColor), "Wrong border color for intent: \(intent)")
        XCTAssertTrue(colors.statusIcon.equals(theme.colors.feedback.neutral), "Wrong statusIcon color for intent: \(intent)")
        XCTAssertTrue(colors.background.equals(self.theme.colors.base.surface), "Wrong background color for intent: \(intent)")
    }

    func test_isNotFocused_isEnabled_isUserInteractionEnabled() {
        let intentAndExpectedBorderColorArray: [(intent: TextFieldIntent, expectedBorderColor: any ColorToken)] = [
            (intent: .success, self.theme.colors.feedback.success),
            (intent: .error, self.theme.colors.feedback.error),
            (intent: .alert, self.theme.colors.feedback.alert),
            (intent: .neutral, self.theme.colors.base.outline),
        ]
        XCTAssertEqual(intentAndExpectedBorderColorArray.count, TextFieldIntent.allCases.count, "Wrong intentAndExpectedBorderColorArray count")

        intentAndExpectedBorderColorArray.forEach {
            self._test_isNotFocused_isEnabled_isUserInteractionEnabled(with: $0.intent, expectedBorderColor: $0.expectedBorderColor)
        }
    }

    private func _test_isNotFocused_isEnabled_isUserInteractionEnabled(
        with intent: TextFieldIntent,
        expectedBorderColor: any ColorToken
    ) {
        // GIVEN
        let isFocused = false
        let isEnabled = true
        let isUserInteractionEnabled = true
        let useCase = TextFieldGetColorsUseCase()

        // WHEN
        let colors = useCase.execute(
            theme: self.theme,
            intent: intent,
            isFocused: isFocused,
            isEnabled: isEnabled,
            isUserInteractionEnabled: isUserInteractionEnabled
        )

        // THEN
        XCTAssertTrue(colors.text.equals(self.theme.colors.base.onSurface), "Wrong text color for intent: \(intent)")
        XCTAssertTrue(colors.placeholder.equals(self.theme.colors.base.onSurface.opacity(self.theme.dims.dim1)), "Wrong placeholder color for intent: \(intent)")
        XCTAssertTrue(colors.border.equals(expectedBorderColor), "Wrong border color for intent: \(intent)")
        XCTAssertTrue(colors.statusIcon.equals(theme.colors.feedback.neutral), "Wrong statusIcon color for intent: \(intent)")
        XCTAssertTrue(colors.background.equals(self.theme.colors.base.surface), "Wrong background color for intent: \(intent)")
    }

    func test_isNotFocused_isEnabled_isUserInteractionNotEnabled() {
        let intentAndExpectedBorderColorArray: [(intent: TextFieldIntent, expectedBorderColor: any ColorToken)] = [
            (intent: .success, self.theme.colors.base.outline),
            (intent: .error, self.theme.colors.base.outline),
            (intent: .alert, self.theme.colors.base.outline),
            (intent: .neutral, self.theme.colors.base.outline),
        ]
        XCTAssertEqual(intentAndExpectedBorderColorArray.count, TextFieldIntent.allCases.count, "Wrong intentAndExpectedBorderColorArray count")

        intentAndExpectedBorderColorArray.forEach {
            self._test_isNotFocused_isEnabled_isUserInteractionNotEnabled(with: $0.intent, expectedBorderColor: $0.expectedBorderColor)
        }
    }

    private func _test_isNotFocused_isEnabled_isUserInteractionNotEnabled(
        with intent: TextFieldIntent,
        expectedBorderColor: any ColorToken
    ) {
        // GIVEN
        let isFocused = false
        let isEnabled = true
        let isUserInteractionEnabled = false
        let useCase = TextFieldGetColorsUseCase()

        // WHEN
        let colors = useCase.execute(
            theme: self.theme,
            intent: intent,
            isFocused: isFocused,
            isEnabled: isEnabled,
            isUserInteractionEnabled: isUserInteractionEnabled
        )

        // THEN
        XCTAssertTrue(colors.text.equals(self.theme.colors.base.onSurface), "Wrong text color for intent: \(intent)")
        XCTAssertTrue(colors.placeholder.equals(self.theme.colors.base.onSurface.opacity(self.theme.dims.dim1)), "Wrong placeholder color for intent: \(intent)")
        XCTAssertTrue(colors.border.equals(expectedBorderColor), "Wrong border color for intent: \(intent)")
        XCTAssertTrue(colors.statusIcon.equals(theme.colors.feedback.neutral), "Wrong statusIcon color for intent: \(intent)")
        XCTAssertTrue(colors.background.equals(self.theme.colors.base.onSurface.opacity(theme.dims.dim5)), "Wrong background color for intent: \(intent)")
    }

    func test_isFocused_isNotEnabled_isUserInteractionEnabled() {
        let intentAndExpectedBorderColorArray: [(intent: TextFieldIntent, expectedBorderColor: any ColorToken)] = [
            (intent: .success, self.theme.colors.base.outline),
            (intent: .error, self.theme.colors.base.outline),
            (intent: .alert, self.theme.colors.base.outline),
            (intent: .neutral, self.theme.colors.base.outline),
        ]
        XCTAssertEqual(intentAndExpectedBorderColorArray.count, TextFieldIntent.allCases.count, "Wrong intentAndExpectedBorderColorArray count")

        intentAndExpectedBorderColorArray.forEach {
            self._test_isFocused_isNotEnabled_isUserInteractionEnabled(with: $0.intent, expectedBorderColor: $0.expectedBorderColor)
        }
    }

    private func _test_isFocused_isNotEnabled_isUserInteractionEnabled(
        with intent: TextFieldIntent,
        expectedBorderColor: any ColorToken
    ) {
        // GIVEN
        let isFocused = true
        let isEnabled = false
        let isUserInteractionEnabled = true
        let useCase = TextFieldGetColorsUseCase()

        // WHEN
        let colors = useCase.execute(
            theme: self.theme,
            intent: intent,
            isFocused: isFocused,
            isEnabled: isEnabled,
            isUserInteractionEnabled: isUserInteractionEnabled
        )

        // THEN
        XCTAssertTrue(colors.text.equals(self.theme.colors.base.onSurface), "Wrong text color for intent: \(intent)")
        XCTAssertTrue(colors.placeholder.equals(self.theme.colors.base.onSurface.opacity(self.theme.dims.dim1)), "Wrong placeholder color for intent: \(intent)")
        XCTAssertTrue(colors.border.equals(expectedBorderColor), "Wrong border color for intent: \(intent)")
        XCTAssertTrue(colors.statusIcon.equals(theme.colors.feedback.neutral), "Wrong statusIcon color for intent: \(intent)")
        XCTAssertTrue(colors.background.equals(self.theme.colors.base.onSurface.opacity(theme.dims.dim5)), "Wrong background color for intent: \(intent)")
    }
}
