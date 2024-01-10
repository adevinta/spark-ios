//
//  UIView+ElevationShadow.swift
//  SparkCore
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public extension UIView {

    /// Apply a shadow to the view
    /// Note: This will need to be reapplied when switching from dark to light theme as CGColors do not refresh automatically
    /// Note: You could watch changes in traitCollectionDidChange using traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
    /// - Parameter shadow: An ElevationShadow
    func applyShadow(_ shadow: ElevationShadow) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadow.colorToken.uiColor.cgColor
        self.layer.shadowOpacity = shadow.opacity
        self.layer.shadowOffset = CGSize(width: shadow.offset.x, height: shadow.offset.y)
        self.layer.shadowRadius = shadow.blur
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
