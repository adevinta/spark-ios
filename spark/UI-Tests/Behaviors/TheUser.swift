//
//  TheUser.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

typealias UIElementClosure = (XCUIApplication) -> XCUIElement

func theUser(isOn elementIn: @escaping UIElementClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return theUser(sees: elementIn, \.exists, file: file, line: line)
}

func theUser(sees elementIn: @escaping UIElementClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return theUser(sees: elementIn, \.exists, file: file, line: line)
}

func theUser(
    sees elementIn: @escaping UIElementClosure,
    _ elementKeyPath: KeyPath<XCUIElement, Bool>,
    file: StaticString = #file,
    line: UInt = #line) -> UITestClosure {
    return { app in
        let element = elementIn(app)
        let value = element[keyPath: elementKeyPath]
        XCTAssertTrue(value, "❌ The element state \(elementKeyPath) is false", file: file, line: line)
    }
}

func theUser(taps element: @escaping UIElementClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return { app in
        let element = element(app)
        XCTAssertTrue(element.exists, "❌ The element does not exist", file: file, line: line)
        element.tap()
    }
}
