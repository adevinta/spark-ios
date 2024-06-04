//
//  ProgressBarDoubleColorsTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SparkTheme
import XCTest

final class ProgressBarDoubleColorsTests: XCTestCase {

    // MARK: - Tests

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = ProgressBarDoubleColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.main,
            bottomIndicatorBackgroundColorToken: colors.feedback.alert
        )

        let colors2 = ProgressBarDoubleColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.main,
            bottomIndicatorBackgroundColorToken: colors.feedback.alert
        )

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = ProgressBarDoubleColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.main,
            bottomIndicatorBackgroundColorToken: colors.feedback.alert
        )

        let colors2 = ProgressBarDoubleColors(
            trackBackgroundColorToken: colors.base.onBackground,
            indicatorBackgroundColorToken: colors.main.onMain,
            bottomIndicatorBackgroundColorToken: colors.feedback.onAlert
        )

        XCTAssertNotEqual(colors1, colors2)
    }
}
