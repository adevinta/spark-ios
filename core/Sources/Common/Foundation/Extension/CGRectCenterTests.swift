//
//  CGRectCenterTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class CGRectCenterTests: XCTestCase {

    func testExample() throws {
        let rect = CGRect(x: 10, y: 10, width: 110, height: 30)

        XCTAssertEqual(rect.centerX, 65, "CenterX doesn't match expected value")
        XCTAssertEqual(rect.centerY, 25, "CenterY doesn't match expected value")

        XCTAssertEqual(rect.center, CGPoint(x: 65, y: 25), "Center point is not correct")
    }

}
