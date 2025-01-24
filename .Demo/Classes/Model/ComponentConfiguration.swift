//
//  ComponentConfiguration.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

// TODO: add optional scaled Size
// TODO: add isEnabled: true by default -> ShowConfigurationBool

class ComponentConfiguration: Identifiable {

    // MARK: - Global Properties

    let id = UUID().uuidString
    var theme = Themes.spark
    var isEnabled = ShowConfigurationBool()

    // MARK: - Accessibility Properties

    var accessibilityLabel = ShowConfigurationString()
    var accessibilityValue = ShowConfigurationString()

    // MARK: - Size Properties

    var width = ShowConfigurationSize(name: "Width")
    var height = ShowConfigurationSize(name: "Height")

    // MARK: - Initialization

    required init() {
    }

    // MARK: - Getter

    func isInvertedBackground() -> Bool {
        return false
    }
}

// MARK: - Sub

struct ShowConfigurationBool {

    // MARK: - Properties

    var showConfiguration = false
    var value = true
}

struct ShowConfigurationString {

    // MARK: - Properties

    var showConfiguration = false
    var value = ""
}

class ShowConfigurationSize: Identifiable {

    // MARK: - Properties

    var id: String
    var name: String

    lazy var showConfiguration: Bool = false

    var text = ""
    var minText = ""
    var maxText = ""
    var infinite = false

    // MARK: - Initialization

    init(name: String) {
        self.id = name
        self.name = name
    }

    // MARK: - Getter

    func value() -> CGFloat? {
        return self.text.cgFloat
    }

    func minValue() -> CGFloat? {
        return self.minText.cgFloat
    }

    func maxValue() -> CGFloat? {
        guard !self.infinite else {
            return .infinity
        }

        return self.maxText.cgFloat
    }
}
