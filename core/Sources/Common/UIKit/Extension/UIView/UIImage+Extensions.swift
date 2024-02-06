//
//  UIImage+Extensions.swift
//  SparkCore
//
//  Created by louis.borlee on 06/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

extension UIImage {
    func copy(newSize: CGSize, retina: Bool = true) -> UIImage {
        // In next line, pass 0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
        // Pass 1 to force exact pixel size.
        UIGraphicsBeginImageContextWithOptions(
            newSize,
            false,
            retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }

        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
