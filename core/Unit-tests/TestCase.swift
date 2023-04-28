//
//  TestCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import Spark

open class TestCase: XCTestCase {
    override open class func setUp() {
        super.setUp()

        SparkConfiguration.load()

        TestCaseTracker.shared.subscribe()
    }
}
