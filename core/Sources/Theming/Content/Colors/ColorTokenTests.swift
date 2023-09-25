//
//  ColorTokenTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

final class ColorTokenTests: XCTestCase {

    // MARK: - Tests

    func test_colorTokens_equal() {
        XCTAssertTrue(SparkTheme.shared.colors.base.surface.equals(SparkTheme.shared.colors.base.surface))
    }

    func test_colorTokens_not_equal() {
        XCTAssertFalse(SparkTheme.shared.colors.base.surface.equals(SparkTheme.shared.colors.base.onSurface))
    }
}
