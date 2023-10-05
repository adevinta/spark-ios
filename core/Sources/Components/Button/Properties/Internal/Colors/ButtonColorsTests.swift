//
//  ButtonColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ButtonColorsTests: XCTestCase {

    // MARK: - Tests

    func test_buttonColors_equal() {
        let colors = SparkTheme.shared.colors
        let given1 = ButtonColors(
            foregroundColor: colors.main.main,
            backgroundColor: colors.base.background,
            pressedBackgroundColor: colors.base.backgroundVariant,
            borderColor: colors.base.background,
            pressedBorderColor: colors.states.mainPressed)
        let given2 = ButtonColors(
            foregroundColor: colors.main.main,
            backgroundColor: colors.base.background,
            pressedBackgroundColor: colors.base.backgroundVariant,
            borderColor: colors.base.background,
            pressedBorderColor: colors.states.mainPressed)

        XCTAssertEqual(given1, given2)
    }

    func test_buttonColors_not_equal() {
        let colors = SparkTheme.shared.colors
        let given1 = ButtonColors(
            foregroundColor: colors.main.main,
            backgroundColor: colors.base.background,
            pressedBackgroundColor: colors.base.backgroundVariant,
            borderColor: colors.base.background,
            pressedBorderColor: colors.states.mainPressed)
        let given2 = ButtonColors(
            foregroundColor: colors.main.main,
            backgroundColor: colors.base.background,
            pressedBackgroundColor: colors.base.backgroundVariant,
            borderColor: colors.base.background,
            pressedBorderColor: colors.states.alertPressed)

        XCTAssertNotEqual(given1, given2)
    }

}
