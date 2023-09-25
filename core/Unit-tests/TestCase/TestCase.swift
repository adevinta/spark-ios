//
//  TestCase.swift
//  SparkCoreTests
//
//  Created by louis.borlee on 22/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

open class TestCase: XCTestCase {

    // MARK: - Set up

    override open class func setUp() {
        super.setUp()

        SparkConfiguration.load()
    }
}
