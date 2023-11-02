//
//  XCTestCase+Extensions.swift
//  SparkDemoUITests
//
//  Created by louis.borlee on 31/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

extension XCTestCase {
    func goToComponent(named name: String,
                       app: XCUIApplication) {
        app.tabBars.buttons["Components"].tap()
        app.cells["Uikit"].tap()
        app.cells[name].tap()
    }
}
