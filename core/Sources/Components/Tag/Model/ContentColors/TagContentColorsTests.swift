//
//  TagContentColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

import XCTest
@testable import Spark
@testable import SparkCore
import XCTest

final class TagContentColorsTests: XCTestCase {

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = TagContentColors(
            color: colors.main.main,
            onColor: colors.main.onMain,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground,
            surfaceColor: colors.base.surface)

        let colors2 = TagContentColors(
            color: colors.main.main,
            onColor: colors.main.onMain,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground,
            surfaceColor: colors.base.surface)

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = TagContentColors(
            color: colors.main.main,
            onColor: colors.main.onMain,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground,
            surfaceColor: colors.base.surface)

        let colors2 = TagContentColors(
            color: colors.support.support,
            onColor: colors.support.onSupport,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground,
            surfaceColor: colors.base.surface)

        XCTAssertNotEqual(colors1, colors2)
    }
}

