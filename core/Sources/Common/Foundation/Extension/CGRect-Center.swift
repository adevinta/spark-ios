//
//  CGRect.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension CGRect {
    /// Returns the center of the x-coordinate of the rect
    var centerX: CGFloat {
        return (self.minX + self.maxX)/2
    }

    /// Returns the center of the y-coordinate of the rect
    var centerY: CGFloat {
        return (self.minY + self.maxY)/2
    }

    /// The center point of the rect
    var center: CGPoint {
        return CGPoint(x: self.centerX, y: self.centerY)
    }
}
