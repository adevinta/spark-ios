//
//  SwitchStatusColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import XCTest

final class SwitchStatusColorsTests: XCTestCase {

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert)

        let colors2 = SwitchStatusColors(
            onColorToken: colors.feedback.info,
            offColorToken: colors.feedback.alert)

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert)

        let colors2 = SwitchStatusColors(
                onColorToken: colors.primary.primary,
                offColorToken: colors.secondary.secondary)

        XCTAssertNotEqual(colors1, colors2)
    }
}
