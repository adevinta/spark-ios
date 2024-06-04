//
//  SwitchColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import SparkTheme

final class SwitchColorsTests: XCTestCase {

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.main.main,
                offColorToken: colors.support.support),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.main.onMain)

        let colors2 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.main.main,
                offColorToken: colors.support.support),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.main.onMain)

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.main.main,
                offColorToken: colors.support.support),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.main.onMain)

        let colors2 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.error,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.main.main,
                offColorToken: colors.support.support),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.main.onMain)

        XCTAssertNotEqual(colors1, colors2)
    }

}
