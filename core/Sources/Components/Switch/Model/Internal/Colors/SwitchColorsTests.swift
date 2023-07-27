//
//  SwitchColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import XCTest

final class SwitchColorsTests: XCTestCase {

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.primary.primary,
                offColorToken: colors.secondary.secondary),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.primary.onPrimary)

        let colors2 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.primary.primary,
                offColorToken: colors.secondary.secondary),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.primary.onPrimary)

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.info,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.primary.primary,
                offColorToken: colors.secondary.secondary),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.primary.onPrimary)

        let colors2 = SwitchColors(
            toggleBackgroundColors: SwitchStatusColors(
                onColorToken: colors.feedback.error,
                offColorToken: colors.feedback.alert),
            toggleDotForegroundColors: SwitchStatusColors(
                onColorToken: colors.primary.primary,
                offColorToken: colors.secondary.secondary),
            toggleDotBackgroundColor: colors.base.background,
            textForegroundColor: colors.primary.onPrimary)

        XCTAssertNotEqual(colors1, colors2)
    }

}
