//
//  NSLayoutConstraint+MultiplierExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 26/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    /// There is no native possibility to update the multiplier
    /// So we need to recreate the constraint with the new multiplier
    static func updateMultiplier(
        on constraint: inout NSLayoutConstraint?,
        multiplier: CGFloat,
        layout: NSLayoutDimension,
        equalTo: NSLayoutDimension
    ) {
        constraint?.isActive = false

        constraint = layout.constraint(
            equalTo: equalTo,
            multiplier: multiplier
        )

        constraint?.isActive = true
    }
}
