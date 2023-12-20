//
//  RatingInputUITests.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 20.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

final class RatingInputUITests: XCTestCase, AppBehavior, RatingInputBehavior {

    func test_rating_input() {
        Scenario("Half star not selected") {
            Given() {
                theUser(goes: to_the_rating_input_screen)
                theUser(sees: the_rating_has_value, 1.0)
            }
            When {
                theUser(taps: the_rating_star(3))
            }
            Then {
                theUser(sees: the_rating_has_value, 3.0)
            }
        }
    }
}
