//
//  ProgressBarColorsTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SparkTheme
import XCTest

final class ProgressBarColorsTests: XCTestCase {

    // MARK: - Tests

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = ProgressBarColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.main
        )

        let colors2 = ProgressBarColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.main
        )

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = ProgressBarColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.main
        )

        let colors2 = ProgressBarColors(
            trackBackgroundColorToken: colors.base.background,
            indicatorBackgroundColorToken: colors.main.onMain
        )

        XCTAssertNotEqual(colors1, colors2)
    }
}
