//
//  Component.swift
//  SparkDemo
//
//  Created by alican.aycil on 08.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct UIComponent: RawRepresentable, CaseIterable, Equatable {
    static var allCases: [UIComponent] = [
        .badge,
        .bottomSheet,
        .button,
        .iconButton,
        .checkbox,
        .chip,
        .divider,
        .formField,
        .icon,
        .popover,
        .progressBarIndeterminate,
        .progressBarSingle,
        .progressTracker,
        .radioButton,
        .ratingDisplay,
        .ratingInput,
        .slider,
        .spinner,
        .star,
        .switchButton,
        .tab,
        .tag,
        .textField,
        .textFieldAddons,
        .textLink
    ]

    var rawValue: String

    static let badge = UIComponent(rawValue: "Badge")
    static let bottomSheet = UIComponent(rawValue: "Bottom Sheet")
    static let button = UIComponent(rawValue: "Button")
    static let checkbox = UIComponent(rawValue: "Checkbox")
    static let chip = UIComponent(rawValue: "Chip")
    static let divider = UIComponent(rawValue: "Divider")
    static let formField = UIComponent(rawValue: "FormField")
    static let icon = UIComponent(rawValue: "Icon")
    static let iconButton = UIComponent(rawValue: "Icon Button")
    static let popover = UIComponent(rawValue: "Popover")
    static let progressBarIndeterminate = UIComponent(rawValue: "Progress Bar Indeterminate")
    static let progressBarSingle = UIComponent(rawValue: "Progress Bar Single")
    static let progressTracker = UIComponent(rawValue: "Progress Tracker")
    static let radioButton = UIComponent(rawValue: "Radio Button")
    static let ratingDisplay = UIComponent(rawValue: "Rating Display")
    static let ratingInput = UIComponent(rawValue: "Rating Input")
    static let slider = UIComponent(rawValue: "Slider")
    static let spinner = UIComponent(rawValue: "Spinner")
    static let star = UIComponent(rawValue: "Star")
    static let switchButton = UIComponent(rawValue: "Switch Button")
    static let tab = UIComponent(rawValue: "Tab")
    static let tag = UIComponent(rawValue: "Tag")
    static let textField = UIComponent(rawValue: "TextField")
    static let textFieldAddons = UIComponent(rawValue: "TextFieldAddons")
    static let textLink = UIComponent(rawValue: "TextLink")
}
