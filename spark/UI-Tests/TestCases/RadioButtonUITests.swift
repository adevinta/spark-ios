//
//  RadioButtonUITests.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 11.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

final class RadioButtonUITests: XCTestCase, AppBehavior, RadioButtonBehavior {

    func test_radio_button_toggle() {
        Scenario("The user changes the selected radio button value") {
            Given("The user is on the radio button screen") {
                theUser(goes: to_the_radiobutton_screen)
                theUser(sees: the_radio_button_group)
                theUser(sees: the_radiobutton(0), \.isSelected)
            }
            When("The user taps on the second radio buttons") {
                theUser(taps: the_radiobutton(1))
            }
            Then("The the second radiobutton is selected") {
                theUser(sees: the_radiobutton(1), \.isSelected)
            }
        }

        Scenario("The user sets the single radio button to selected") {
            Given("The user is on the radio button screen") {
                theUser(sees: the_radio_button_group)
                theUser(sees: the_single_radio_button, \.isNotSelected)
            }
            When("The user taps on the single radio button") {
                theUser(taps: the_single_radio_button)
            }
            Then("The user sees the radio and checkbox buttons are selected") {
                theUser(sees: the_single_radio_button, \.isSelected)
                theUser(sees: the_set_selected_checkbox, \.isSelected)
            }
        }

        Scenario("The user toggles the single radio button using the configuration") {
            Given("The select state checkbox is selected") {
                theUser(sees: the_set_selected_checkbox, \.isSelected)
            }
            When("The user taps on the select configuration") {
                theUser(taps: the_set_selected_checkbox)
            }
            Then("The user sees the radio and checkbox buttons are not selected") {
                theUser(sees: the_single_radio_button, \.isNotSelected)
                theUser(sees: the_set_selected_checkbox, \.isNotSelected)
            }
        }
    }
}
