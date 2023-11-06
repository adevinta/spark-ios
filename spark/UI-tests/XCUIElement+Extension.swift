//
//  XCUIElement+Extension.swift
//  Spark
//
//  Created by xavier.daleau on 06/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

extension XCUIElement {
    var traits: UIAccessibilityTraits? {
        return self.value(forKey: "traits") as? UIAccessibilityTraits
    }
}
