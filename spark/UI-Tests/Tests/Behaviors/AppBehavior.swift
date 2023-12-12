//
//  AppBehavior.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

protocol AppBehaviour {}

extension AppBehaviour {
    func the_app_is_started(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
            { config in
                XCTAssertTrue(true, "\(config.message) / The app is started",
                              file: file,
                              line: line)
            }
    }

    func the_user_is_on_the_home_screen(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
            { config in
                config.app.tabBars["Tab Bar"].buttons["Theme"].press(forDuration: 0.01)
            }
    }

    func the_user_is_on_the_components_screen(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
            { config in

                let cell = config.app.collectionViews.firstMatch.cells["Uikit"]

                config.assertTrue(
                    cell.exists,
                    message: "No Uikit cell found",
                    file: file,
                    line: line
                )
            }
        }

    func the_user_is_on_the_uicomponents_screen(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
            { config in

                let navBar = config.app.navigationBars["UIComponents"]

                config.assertTrue(
                    navBar.exists,
                    message: "No Uikit cell found",
                    file: file,
                    line: line
                )
            }
        }

    func the_user_selects_uikit(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
            { config in
                let cell = config.app.collectionViews.firstMatch.cells["Uikit"]
                cell.tap()
            }
        }

    func the_user_presses_on_components(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
            { config in
                config.app.tabBars["Tab Bar"].buttons["Components"].press(forDuration: 0.01)
            }
    }

    func print_debug_description(
        file: StaticString = #file,
        line: UInt = #line) -> UITestClosure {
        { config in
            print(config.app.debugDescription)
            print("HERE")
        }
    }
}
