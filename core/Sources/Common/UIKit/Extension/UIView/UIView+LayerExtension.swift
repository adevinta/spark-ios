//
//  UIView+LayerExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 18/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UIView {

    func setBorderColor(from colorToken: any ColorToken) {
        self.layer.borderColor = colorToken.uiColor.cgColor
    }

    func setBorderWidth(_ borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
    }

    func setCornerRadius(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius.isInfinite ? self.frame.height / 2 : cornerRadius
    }

    func setMasksToBounds(_ masksToBounds: Bool) {
        self.layer.masksToBounds = masksToBounds
    }
}
