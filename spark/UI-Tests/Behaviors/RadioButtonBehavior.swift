//
//  RadioButtonBehavior.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

protocol RadioButtonBehavior { }

extension RadioButtonBehavior {
    func the_radio_button_group(app: XCUIApplication) -> XCUIElement {
        return app.otherElements["spark-radio-button"]
    }

    func the_radiobutton(_ value: Int) -> UIApplicationClosure {
        return { app in
            return the_radio_button_group(app: app).otherElements["spark-radio-button-\(value)"]
        }
    }

    func the_single_radio_button(app: XCUIApplication) -> XCUIElement {
        return app.otherElements["radio-button-single"]
    }

    func the_set_selected_checkbox(app: XCUIApplication) -> XCUIElement {
        return app.otherElements["selected_for_single_radio_button-Item-Checkbox"]
    }
}
