//
//  RatingInputBehavior.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 20.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

protocol RatingInputBehavior {}

extension RatingInputBehavior {
    func the_rating_has_value(_ app: XCUIApplication) -> XCUIElement {
        return app.otherElements["spark-rating-display"]
    }

    func the_rating_star(_ number: Int) -> UIApplicationClosure {
        return { app in
            return app.otherElements["spark-rating-display-\(number)"]
        }
    }
}
