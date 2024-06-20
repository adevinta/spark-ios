//
//  UITraitCollection-SizeAppearance.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 07.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

extension UITraitCollection {
    func hasDifferentSizeCategory(comparedTo traitCollection: UITraitCollection?) -> Bool {
        self.preferredContentSizeCategory != traitCollection?.preferredContentSizeCategory
    }
}
