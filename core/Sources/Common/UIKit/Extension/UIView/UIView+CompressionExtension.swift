//
//  UIView+CompressionExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 20/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UIView {

    func setContentCompressionsResistancePriority(
        _ priority: UILayoutPriority,
        for axes: [NSLayoutConstraint.Axis]) {
            for axis in axes {
                self.setContentCompressionResistancePriority(
                    priority,
                    for: axis
                )
            }
        }
}
