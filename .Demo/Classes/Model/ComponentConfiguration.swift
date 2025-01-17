//
//  ComponentConfiguration.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

class ComponentConfiguration: Identifiable {

    // MARK: - Global Properties

    let id: String = UUID().uuidString
    var theme: Themes = Themes.spark

    // MARK: - Accessibility Properties

    var isAccessibilityLabel: Bool = false
    var accessibilityLabel: String = ""
    var isAccessibilityValue: Bool = false
    var accessibilityValue: String = ""

    // MARK: - Initialization

    required init() {
    }
}
