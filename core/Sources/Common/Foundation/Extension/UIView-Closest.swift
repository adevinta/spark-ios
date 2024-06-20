//
//  UIView-Closest.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: UIView {

    /// Returns the index of the array of views which is closest to the point.
    func index(closestTo location: CGPoint) -> Int? {
        return self.map(\.frame).index(closestTo: location)
    }
}

extension Array where Element == CGRect {
    /// Returns the index of the array of rects which is closest to the point.
    func index(closestTo location: CGPoint) -> Int? {
        let distances = self.map{ rect in
            rect.center.distance(to: location)
        }
        let nearest = distances.enumerated().min { left, right in
            return left.element < right.element
        }
        return nearest?.offset
    }

}
