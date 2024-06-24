//
//  TagContentColorsTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 24.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

import XCTest
import XCTest

@testable import SparkCore

final class TagContentColorsTests: XCTestCase {

    func testEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = TagContentColors(
            color: colors.main.main,
            onColor: colors.main.onMain,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground)

        let colors2 = TagContentColors(
            color: colors.main.main,
            onColor: colors.main.onMain,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground)

        XCTAssertEqual(colors1, colors2)
    }

    func testNotEqual() {
        let colors = SparkTheme.shared.colors

        let colors1 = TagContentColors(
            color: colors.main.main,
            onColor: colors.main.onMain,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground)

        let colors2 = TagContentColors(
            color: colors.support.support,
            onColor: colors.support.onSupport,
            containerColor: colors.base.background,
            onContainerColor: colors.base.onBackground)

        XCTAssertNotEqual(colors1, colors2)
    }
}

