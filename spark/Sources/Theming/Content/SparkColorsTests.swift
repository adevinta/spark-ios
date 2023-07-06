//
//  SparkColorsTests.swift
//  SparkTests
//
//  Created by louis.borlee on 19/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SparkCore
@testable import Spark

final class SparkColorsTests: XCTestCase {

    private lazy var tokens: [any ColorToken] = self.getAllColorTokens()

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
    private func getAllColorTokens() -> [any ColorToken] {
        let mirror = Mirror(reflecting: SparkColors())
        return mirror.children.flatMap { (_, value: Any) in
            return self.getColorTokens(from: value)
        }
    }

    private func getColorTokens(from object: Any) -> [any ColorToken] {
        let mirror = Mirror(reflecting: object)
        return mirror.children.compactMap { (_, value: Any) in
            return value as? any ColorToken
        }
    }
}
