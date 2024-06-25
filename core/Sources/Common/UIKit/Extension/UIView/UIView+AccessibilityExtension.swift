//
//  UIView+AccessibilityExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

extension UIView {

    /// Insert or remove the trait on the current accessibilityTraits
    func accessibilityTraits(manage trait: UIAccessibilityTraits, insert: Bool) {
        if insert {
            self.accessibilityTraits.insert(trait)
        } else {
            self.accessibilityTraits.remove(trait)
        }
    }
}
