//
//  UIViewClosestTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class UIViewClosestTests: XCTestCase {

    func test_closest() throws {
        let positions = [0, 100, 200, 300]
        let views = positions.map{ CGRect(x: $0, y: 10, width: 50, height: 50) }.map(UIView.init(frame:))

        for (index, position) in positions.enumerated() {
            let closestIndex = views.index(closestTo: CGPoint(x: position+50, y: 100))
            XCTAssertEqual(closestIndex, index, "Expected \(String(describing: closestIndex)) to be equal to \(index)")
        }
    }

}
