//
//  StarFillModeUnitTests.swift
//  SparkCoreUnitTests
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class StarFillModeUnitTests: XCTestCase {

    func test_full_with_half_rating() {
        XCTAssertEqual(StarFillMode.full.rating(of: 0.5), 1.0)
    }

    func test_full_with_less_than_half_rating() {
        XCTAssertEqual(StarFillMode.full.rating(of: 0.49), 0.0)
    }

    func test_half_with_half_rating() {
        XCTAssertEqual(StarFillMode.half.rating(of: 0.6), 0.5)
    }

    func test_half_with_big_rating() {
        XCTAssertEqual(StarFillMode.half.rating(of: 0.75), 1.0)
    }

    func test_half_with_small_rating() {
        XCTAssertEqual(StarFillMode.half.rating(of: 0.2), 0.0)
    }

    func test_exact_rating() {
        XCTAssertEqual(StarFillMode.exact.rating(of: 0.211), 0.211)
    }

    func test_fraction_rating_round_down() {
        XCTAssertEqual(StarFillMode.fraction(10).rating(of: 0.1111), 0.1)
    }

    func test_fraction_rating_round_up() {
        XCTAssertEqual(StarFillMode.fraction(10).rating(of: 0.15), 0.2)
    }
}
