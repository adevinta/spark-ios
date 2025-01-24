//
//  TextEditorConfiguration.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

class TextEditorConfiguration: ComponentConfiguration {

    // MARK: - Properties

    var intent: TextEditorIntent = .random
    var text = "My TextEditor"
    var placeholder = "My placeholder"

    // MARK: - Initialization

    required init() {
        super.init()

        self.isEnabled.showConfiguration = true
        self.height.showConfiguration = true
        self.accessibilityLabel.showConfiguration = true
    }
}
