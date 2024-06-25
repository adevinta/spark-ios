//
//  SwitchStatusColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

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
                onColorToken: colors.main.main,
                offColorToken: colors.support.support)

        XCTAssertNotEqual(colors1, colors2)
    }
}
