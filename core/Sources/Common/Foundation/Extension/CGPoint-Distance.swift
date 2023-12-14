//
//  CGPoint-Distance.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

extension CGPoint {

    /// Returns the distance between two points
    func distance(to other: CGPoint) -> CGFloat {
        CGFloat(hypotf(Float(self.x - other.x), Float(self.y - other.y)))
    }
}
