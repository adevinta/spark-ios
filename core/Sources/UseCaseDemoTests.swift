//
//  UseCaseDemoTests.swift
//  SparkCoreTests
//
//  Created by louis.borlee on 22/02/2023.
//

import XCTest
@testable import SparkCore

final class UseCaseDemoTests: XCTestCase {

    func testUseCaseDemo() {
        let demo = UseCaseDemo()
        XCTAssertEqual(demo.id, 42)
    }

}
