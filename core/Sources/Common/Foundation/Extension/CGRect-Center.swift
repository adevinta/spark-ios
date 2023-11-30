//
//  CGRect.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension CGRect {
    var centerX: CGFloat {
        return (self.minX + self.maxX)/2
    }

    var centerY: CGFloat {
        return (self.minY + self.maxY)/2
    }

    var center: CGPoint {
        return CGPoint(x: self.centerX, y: self.centerY)
    }
}
