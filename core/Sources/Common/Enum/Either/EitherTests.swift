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

final class EitherTests: XCTestCase {

    func test_left_value() {
        let sut: Either<Int, String> = .left(1)
        XCTAssertEqual(sut.leftValue, 1)
    }

    func test_right_value() {
        let sut: Either<Int, String> = .right("A")
        XCTAssertEqual(sut.rightValue, "A")
    }

    func test_or_value() {
        let sut: Either<Int, String> = .of(1, or: "Hello")
        XCTAssertEqual(sut, .left(1))
    }

    func test_or_other_value() {
        let sut: Either<Int, String> = .of(nil, or: "Hello")
        XCTAssertEqual(sut, .right("Hello"))
    }
}
