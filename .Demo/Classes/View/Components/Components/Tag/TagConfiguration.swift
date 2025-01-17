//
//  TagConfiguration.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import Foundation

class TagConfiguration: ComponentConfiguration {

    // MARK: - Properties
    
    var intent: TagIntent = .random
    var variant: TagVariant = .random
    var text: String = "My Tag"
    var icon: Iconography?
    var isAttributedText: Bool = false

    // MARK: - Initialization

    required init() {
        super.init()

        self.isAccessibilityLabel = true
    }
}
