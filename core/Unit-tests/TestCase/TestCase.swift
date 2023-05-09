//
//  TestCase.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 05/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import UIKit

@testable import Spark

open class TestCase: XCTestCase {

    // MARK: - Set up

    override open class func setUp() {
        super.setUp()

        SparkConfiguration.load()
        TestCaseTracker.shared.subscribe()
    }
}
