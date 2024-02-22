//
//  XCUIElement-Extension.swift
//  SparkDemoUITests
//
//  Created by Michael Zimmermann on 13.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement {
    var isNotSelected: Bool {
        return !self.isSelected
    }
}
