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
    func the_tab_bar(app: XCUIApplication) -> XCUIElement {
        return app.tabBars["Tab Bar"].firstMatch
    }

    func the_tab_bar_button(_ name: String) -> (XCUIApplication) -> XCUIElement {
        return { app in
            the_tab_bar(app: app).buttons[name]
        }
    }

    func the_theme_button(app: XCUIApplication) -> XCUIElement {
        return the_tab_bar_button("Theme")(app)
    }

    func the_components_button(app: XCUIApplication) -> XCUIElement {
        return the_tab_bar_button("Components")(app)
    }

    func the_uikit_button(app: XCUIApplication) -> XCUIElement {
        return app.collectionViews.firstMatch.cells["Uikit"]
    }

    func the_radio_button_cell(app: XCUIApplication) -> XCUIElement {
        return app.collectionViews.firstMatch.cells["Radio Button"]
    }

    func the_uicomponents_screen(
        app: XCUIApplication) -> XCUIElement {
            return app.navigationBars["UIComponents"]
    }

    func the_radiobutton_screen(app: XCUIApplication) -> XCUIElement {
        return app.navigationBars["RadioButton"]
    }

    func print_debug_description(app: XCUIApplication) {
        print(app.debugDescription)
        print("HELLO")
    }
}
