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
    func index(closestTo location: CGPoint) -> Int? {
        let distances = self.map{ view in
            view.frame.center.distance(to: location)
        }
        let nearest = distances.enumerated().min { (left, right) in
            return left.element < right.element
        }
        return nearest?.offset
    }
}
