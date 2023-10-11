//
//  ProgressIndeterminateBarAnimationTypeTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 29/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ProgressIndeterminateBarAnimationTypeTests: XCTestCase {

    // MARK: - Tests
    
    func test_next() throws {
        // GIVEN
        let items: [(
            givenType: ProgressIndeterminateBarAnimationType,
            expectedNextType: ProgressIndeterminateBarAnimationType
        )] = [
            (
                givenType: .easeIn,
                expectedNextType: .easeOut
            ),
            (
                givenType: .easeOut,
                expectedNextType: .reset
            ),
            (
                givenType: .reset,
                expectedNextType: .easeIn
            )
        ]

        for item in items {
            // WHEN
            var type = item.givenType
            type.next()

            // THEN
            XCTAssertEqual(
                type,
                item.expectedNextType,
                "Wrong next type when type is \(item.givenType)"
            )
        }
    }
}
