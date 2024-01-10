//
//  AppBehavior.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

protocol AppBehavior {}

extension AppBehavior {
    func the_tab_bar(app: XCUIApplication) -> XCUIElement {
        return app.tabBars["Tab Bar"].firstMatch
    }

    func the_tab_bar_button(_ name: String) -> UIApplicationClosure {
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

    func the_collection_view(app: XCUIApplication) -> XCUIElement {
            return app.collectionViews.firstMatch
    }

    func the_collection_view_cell(_ name: String) -> UIApplicationClosure {
        return { app in
            return the_collection_view(app: app).cells[name]
        }
    }

    func the_uikit_button(app: XCUIApplication) -> XCUIElement {
        return the_collection_view_cell("Uikit")(app)
    }

    func the_radio_button_cell(app: XCUIApplication) -> XCUIElement {
        return the_collection_view_cell("Radio Button")(app)
    }

    func the_rating_input_cell(app: XCUIApplication) -> XCUIElement {
        return the_collection_view_cell("Rating Input")(app)
    }

    func the_uicomponents_screen(
        app: XCUIApplication) -> XCUIElement {
            return app.navigationBars["UIComponents"]
    }

    func the_radiobutton_screen(app: XCUIApplication) -> XCUIElement {
        return app.navigationBars["RadioButton"]
    }

    func to_the_radiobutton_screen(app: XCUIApplication) -> XCUIElement {
        the_components_button(app: app).tap()
        the_uikit_button(app: app).tap()
        the_radio_button_cell(app: app).tap()
        return app
    }

    func to_the_rating_input_screen(app: XCUIApplication) -> XCUIElement {
        the_components_button(app: app).tap()
        the_uikit_button(app: app).tap()
        the_rating_input_cell(app: app).tap()
        return app
    }
}
