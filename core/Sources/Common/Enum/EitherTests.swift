//
//  EitherTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 19.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore
import XCTest

final class EitherTests: TestCase {

    func test_left_value() {
        let sut: Either<Int, String> = .left(1)
        XCTAssertEqual(sut.leftValue, 1)
    }

    func test_right_value() {
        let sut: Either<Int, String> = .right("A")
        XCTAssertEqual(sut.rightValue, "A")
    }
}
