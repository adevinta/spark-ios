//
//  Bundle_ExtensionsTests.swift
//  Spark
//
//  Created by louis.borlee on 13/02/2023.
//

import XCTest
@testable import Spark

final class Bundle_ExtensionsTests: XCTestCase {
    func test_Spark() {
        XCTAssertEqual(Bundle.spark,
                       Bundle(identifier: "com.adevinta.spark"))
    }
}
