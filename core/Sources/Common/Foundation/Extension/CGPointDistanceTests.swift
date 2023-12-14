//
//  CGPointDistanceTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class CGPointDistanceTests: XCTestCase {

    func test_distance_same() throws {
        let point1 = CGPoint(x: 10, y: 10)
        let point2 = CGPoint(x: 10, y: -100)

        let distance1 = point1.distance(to: point2)
        let distance2 = point2.distance(to: point1)

        XCTAssertEqual(distance1, 110.0, "Expected distance does not match")
        XCTAssertEqual(distance1, distance2, "Expected both distances to be the same")
    }
}
