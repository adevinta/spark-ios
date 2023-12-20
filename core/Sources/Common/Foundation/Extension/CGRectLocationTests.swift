//
//  CGRectLocationTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 08.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class CGRectLocationTests: XCTestCase {

    func test_last_element() throws {
        let sut = CGRect(x: 0, y: 0, width: 100, height: 20)

        XCTAssertEqual(sut.pointIndex(of: CGPoint(x: 0, y: 0), horizontalSlices: 5), 0, "Expected to be index 0")
        XCTAssertEqual(sut.pointIndex(of: CGPoint(x: 80, y: 0), horizontalSlices: 5), 3, "Expected to be index 3")
        XCTAssertEqual(sut.pointIndex(of: CGPoint(x: 81, y: 0), horizontalSlices: 5), 4, "Expected to be index 4")
        XCTAssertEqual(sut.pointIndex(of: CGPoint(x: 99, y: 0), horizontalSlices: 5), 4, "Expected to be index 4")

    }

    func test_edge_cases() throws {
        let sut = CGRect(x: 0, y: 0, width: 100, height: 20)

        XCTAssertNil(sut.pointIndex(of: CGPoint(x: 99, y: 0), horizontalSlices: 0), "Expected not to have an index")
        XCTAssertNil(sut.pointIndex(of: CGPoint(x: 101, y: 10), horizontalSlices: 5), "Expected point outside of frame to have no index")
    }
}
