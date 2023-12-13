//
//  TheUser.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

func theUser(isOn elementIn: @escaping (XCUIApplication) -> XCUIElement, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return { app in
        XCTAssertTrue(elementIn(app).exists, "The element does not exist", file: file, line: line)
    }
}

func theUser(sees elementIn: @escaping (XCUIApplication) -> XCUIElement, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return theUser(isOn: elementIn, file: file, line: line)
}

func theUser(
    sees elementIn: @escaping (XCUIApplication) -> XCUIElement,
    _ elementKeyPath: KeyPath<XCUIElement, Bool>,
    file: StaticString = #file,
    line: UInt = #line) -> UITestClosure {
    return { app in
        let element = elementIn(app)
        let value = element[keyPath: elementKeyPath]
        XCTAssertTrue(value, "The element is not \(elementKeyPath)", file: file, line: line)
    }
}

func theUser(taps element: @escaping (XCUIApplication) -> XCUIElement, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return { app in
        let element = element(app)
        XCTAssertTrue(element.exists, "The element does not exist", file: file, line: line)
        element.tap()
    }
}
