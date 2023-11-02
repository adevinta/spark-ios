//
//  TagUITests.swift
//  SparkDemoUITests
//
//  Created by louis.borlee on 02/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

final class TagUITests: XCTestCase {

    private let app: XCUIApplication = XCUIApplication()

    func test_identifiers() {
        self.app.launch()
        self.goToComponent(named: "Tag",
                           app: self.app)

        let tag = self.app.otherElements["spark-tag"].firstMatch
        XCTAssertEqual(tag.label, "This is a Tag")
    }
}
