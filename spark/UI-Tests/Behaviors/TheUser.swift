//
//  TheUser.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

typealias UIApplicationClosure = (XCUIApplication) -> XCUIElement
typealias UIElementClosure = (XCUIElement) -> Void

func theUser(isOn elementIn: @escaping UIApplicationClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return theUser(sees: elementIn, \.exists, file: file, line: line)
}

func theUser(sees elementIn: @escaping UIApplicationClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return theUser(sees: elementIn, \.exists, file: file, line: line)
}

func theUser(sees element: @escaping UIApplicationClosure,
             _ value: CGFloat,
             file: StaticString = #file,
             line: UInt = #line) -> UITestClosure {

    return userAction(
        element: element,
        closure: {
            let givenValue = $0.value as? String ?? "NOT_FOUND"
            XCTAssertEqual("\(value)", givenValue, "❌ The element value \(givenValue) is not equal to \(value)", file: file, line: line)
        })
}

func theUser(
    sees element: @escaping UIApplicationClosure,
    _ elementKeyPath: KeyPath<XCUIElement, Bool>,
    file: StaticString = #file,
    line: UInt = #line) -> UITestClosure {
        return userAction(
            element: element,
            closure: {
                let value = $0[keyPath: elementKeyPath]
                XCTAssertTrue(value, "❌ The element state \(elementKeyPath) is false", file: file, line: line)
            },
            file: file,
            line: line
        )
}

func theUser(taps element: @escaping UIApplicationClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return userAction(
        element: element,
        closure: { $0.tap() },
        file: file,
        line: line
    )
}

func theUser(goes element: @escaping UIApplicationClosure, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
    return userAction(element: element, file: file, line: line)
}

func debug_description(app: XCUIApplication) {
    // swiftlint: disable no_debugging_method
    print(app.debugDescription)
}

private func userAction(
    element: @escaping UIApplicationClosure,
    closure: UIElementClosure? = nil,
    file: StaticString = #file,
    line: UInt = #line) -> UITestClosure {
    return { app in
        let element = element(app)
        XCTAssertTrue(element.exists, "❌ The element does not exist", file: file, line: line)
        closure?(element)
    }
}
