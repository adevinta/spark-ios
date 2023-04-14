//
//  TestCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

open class TestCase: XCTestCase {
    override open class func setUp() {
        super.setUp()

        TestCaseTracker.shared.subscribe()
    }
}
