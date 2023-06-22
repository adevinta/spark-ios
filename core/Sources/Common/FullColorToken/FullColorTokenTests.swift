//
//  FullColorTokenTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import UIKit
@testable import SparkCore

final class FullColorTokenTests: XCTestCase {

    // MARK: - Tests

    func test_properties() throws {
        // GIVEN
        let colorTokenMock = ColorTokenGeneratedMock.random()
        let opacityMock = 0.8

        // WHEN
        let fullColorToken = FullColorTokenDefault(
            colorToken: colorTokenMock,
            opacity: opacityMock
        )

        // THEN
        XCTAssertEqual(fullColorToken.uiColor,
                      colorTokenMock.underlyingUiColor.withAlphaComponent(opacityMock),
                      "Wrong UIKit color")
        XCTAssertEqual(fullColorToken.color,
                       colorTokenMock.underlyingColor.opacity(opacityMock),
                      "Wrong SwiftUI color")
    }

    // MARK: - Equatable

    func test_equatable() {
        // GIVEN
        let colorToken1Mock = ColorTokenGeneratedMock.random()
        let colorToken2Mock = ColorTokenGeneratedMock.clear

        let opacity1Mock = 0.8
        let opacity2Mock = 0.5

        // WHEN
        let fullColorToken1 = FullColorTokenDefault(colorToken: colorToken1Mock, opacity: opacity1Mock)
        let fullColorToken2 = FullColorTokenDefault(colorToken: colorToken2Mock, opacity: opacity1Mock) // Color token is different
        let fullColorToken3 = FullColorTokenDefault(colorToken: colorToken1Mock, opacity: opacity2Mock) // Opacity is different
        let fullColorToken4 = FullColorTokenDefault(colorToken: colorToken2Mock, opacity: opacity2Mock) // All are different

        // THEN
        XCTAssertEqual(fullColorToken1,
                       .init(colorToken: colorToken1Mock, opacity: opacity1Mock),
                       "FullColorTokens should be equal")
        XCTAssertNotEqual(fullColorToken1,
                          fullColorToken2,
                          "FullColorToken1 should no be equal to fullColorToken2")
        XCTAssertNotEqual(fullColorToken1,
                          fullColorToken3,
                          "FullColorToken1 should no be equal to fullColorToken3")
        XCTAssertNotEqual(fullColorToken1,
                          fullColorToken4,
                          "FullColorToken1 should no be equal to fullColorToken4")
    }
}
