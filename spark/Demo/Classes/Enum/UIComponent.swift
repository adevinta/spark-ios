//
//  Component.swift
//  SparkDemo
//
//  Created by alican.aycil on 08.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation


struct UIComponent: RawRepresentable, CaseIterable, Equatable {
    static var allCases: [UIComponent] = [.badge, .button, .checkbox, .chip, .icon, .progressBarIndeterminate, .progressBarSingle, .radioButton, .ratingDisplay, .ratingInput, .spinner, .star, .switchButton, .tab, .tag, .textField]

    var rawValue: String

    static let badge = UIComponent(rawValue: "Badge")
    static let button = UIComponent(rawValue: "Button")
    static let checkbox = UIComponent(rawValue: "Checkbox")
    static let chip = UIComponent(rawValue: "Chip")
    static let icon = UIComponent(rawValue: "Icon")
    static let progressBarIndeterminate = UIComponent(rawValue: "Progress Bar Indeterminate")
    static let progressBarSingle = UIComponent(rawValue: "Progress Bar Single")
    static let radioButton = UIComponent(rawValue: "Radio Button")
    static let ratingDisplay = UIComponent(rawValue: "Rating Display")
    static let ratingInput = UIComponent(rawValue: "Rating Input")
    static let spinner = UIComponent(rawValue: "Spinner")
    static let star = UIComponent(rawValue: "Star")
    static let switchButton = UIComponent(rawValue: "Switch Button")
    static let tab = UIComponent(rawValue: "Tab")
    static let tag = UIComponent(rawValue: "Tag")
    static let textField = UIComponent(rawValue: "TextField")
}
