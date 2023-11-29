//
//  ButtonCurrentColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ButtonCurrentColorsTests: XCTestCase {

    // MARK: - Tests

    func test_buttonCurrentColors_equal() {
        let colors = SparkTheme.shared.colors

        let given1 = ButtonCurrentColors(
            imageTintColor: colors.base.onSurface,
            titleColor: colors.base.onSurfaceInverse,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.main.main)

        let given2 = ButtonCurrentColors(
            imageTintColor: colors.base.onSurface,
            titleColor: colors.base.onSurfaceInverse,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.main.main)

        XCTAssertEqual(given1, given2)
    }

    func test_buttonColorColors_not_equal() {
        let colors = SparkTheme.shared.colors

        let given1 = ButtonCurrentColors(
            imageTintColor: colors.base.surface,
            titleColor: colors.base.surfaceInverse,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.main.main)

        let given2 = ButtonCurrentColors(
            imageTintColor: colors.base.onSurface,
            titleColor: colors.base.onSurfaceInverse,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.main.onMain)

        XCTAssertNotEqual(given1, given2)
    }
}
