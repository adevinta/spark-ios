//
//  ButtonCurrentColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import XCTest

final class ButtonCurrentColorsTests: XCTestCase {

    // MARK: - Tests

    func test_buttonCurrentColors_equal() {
        let colors = SparkTheme.shared.colors
        let given1 = ButtonCurrentColors(
            foregroundColor: colors.base.onSurface,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.primary.primary)

        let given2 = ButtonCurrentColors(
            foregroundColor: colors.base.onSurface,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.primary.primary)

        XCTAssertEqual(given1, given2)
    }

    func test_buttonColorColors_not_equal() {
        let colors = SparkTheme.shared.colors

        let given1 = ButtonCurrentColors(
            foregroundColor: colors.base.onSurface,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.primary.primary)

        let given2 = ButtonCurrentColors(
            foregroundColor: colors.base.onSurface,
            backgroundColor: colors.base.backgroundVariant,
            borderColor: colors.primary.onPrimary)

        XCTAssertNotEqual(given1, given2)
    }

}
