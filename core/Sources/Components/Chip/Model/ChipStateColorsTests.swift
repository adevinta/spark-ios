//
//  ChipStateColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore
import SparkTheme

final class ChipStateColorsTests: XCTestCase {

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = ChipStateColors(
            background: colors.base.background,
            border: colors.base.onBackgroundVariant,
            foreground: colors.feedback.alert)

        let colors2 = ChipStateColors(
            background: colors.base.background,
            border: colors.base.onBackgroundVariant,
            foreground: colors.feedback.alert)

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = ChipStateColors(
            background: colors.base.background,
            border: colors.base.onBackgroundVariant,
            foreground: colors.feedback.alert)

        let colors2 = ChipStateColors(
            background: colors.base.backgroundVariant,
            border: colors.base.onBackgroundVariant,
            foreground: colors.feedback.alert)

        XCTAssertNotEqual(colors1, colors2)
    }

}
