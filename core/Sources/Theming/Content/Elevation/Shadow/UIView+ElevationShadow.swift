//
//  UIView+ElevationShadow.swift
//  SparkCore
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public extension UIView {
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
