//
//  SampleLaunchUITests.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

open class UITestCase: XCTestCase {

    func theUser(is predicate: @escaping (XCUIApplication) -> XCUIElement, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
        return { app in
            XCTAssertTrue(predicate(app).exists, file: file, line: line)
        }
    }

    func theUser(sees predicate: @escaping (XCUIApplication) -> XCUIElement, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
        return theUser(is: predicate, file: file, line: line)
    }

    func theUser(taps predicate: @escaping (XCUIApplication) -> XCUIElement, file: StaticString = #file, line: UInt = #line) -> UITestClosure {
        return { app in
            let element = predicate(app)
            XCTAssertTrue(element.exists, file: file, line: line)
            element.tap()
        }
    }
}

final class SampleLaunchUITests: UITestCase, AppBehaviour {

    func test_example() {
        Scenario("The user opens the radio buttons") {
            Given("The user is on the home screen") {
                theUser(sees: the_tab_bar)
                theUser(taps: the_theme_button)
            }
            When("The user navigates to the radio buttons") {
                theUser(taps: the_components_button)
                theUser(taps: the_uikit_button)
                theUser(taps: the_radio_button_cell)
            }
            Then("The user sees the radio buttons") {
                theUser(sees: the_radiobutton_screen)
            }
        }
        .validate()
    }
}
