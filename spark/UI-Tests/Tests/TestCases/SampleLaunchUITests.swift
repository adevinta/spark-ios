//
//  SampleLaunchUITests.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

final class SampleLaunchUITests: XCTestCase, AppBehaviour {

    func test_example() {
        Scenario("The user opens the radio buttons") {
            Given {
                the_user_is_on_the_home_screen()
            }
            When {
                the_user_presses_on_components()
                the_user_selects_uikit()
                print_debug_description()
            }
            Then {
                the_user_is_on_the_uicomponents_screen()
            }
        }
        .validate()
    }
}
