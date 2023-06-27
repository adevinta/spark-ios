//
//  PurpleColorsTest.swift
//  SparkCoreTests
//
//  Created by alex.vecherov on 05.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SparkCore
@testable import Spark

final class PurpleColorsTests: XCTestCase {

    private lazy var tokens: [SparkCore.ColorToken] = self.getAllColorTokens()

    // MARK: - Tests
    func testUIColors() {
        self.tokens.forEach {
            XCTAssertNotEqual(
                $0.uiColor,
                .clear,
                "Wrong uiColor for token \($0)"
            )
        }
    }

    func testSwiftUIColors() {
        self.tokens.forEach {
            XCTAssertNotEqual(
                $0.color,
                .clear,
                "Wrong color for token \($0)"
            )
        }
    }

    // MARK: - Get Colors
    private func getAllColorTokens() -> [SparkCore.ColorToken] {
        let mirror = Mirror(reflecting: PurpleColors())
        return mirror.children.flatMap { (_, value: Any) in
            return self.getColorTokens(from: value)
        }
    }

    private func getColorTokens(from object: Any) -> [SparkCore.ColorToken] {
        let mirror = Mirror(reflecting: object)
        return mirror.children.compactMap { (_, value: Any) in
            return value as? SparkCore.ColorToken
        }
    }
}
