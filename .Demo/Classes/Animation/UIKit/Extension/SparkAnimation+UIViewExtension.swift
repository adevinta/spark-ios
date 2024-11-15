//
//  SparkAnimation+UIViewExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UIView {

//    /// Start a Spark animation.
//    /// - parameter type: the animation type to launch.
//    func startAnimation(for type: SparkAnimationType) {
//        animation.start()
//    }
//
//    /// Stop a Spark animation.
//    /// - parameter type: the animation type to stop.
//    func stopAnimation(for type: SparkAnimationType) {
//        animation.stop()
//    }

    /// Start a Spark animation.
    /// - parameter animation: the animation to launch.
    func startAnimation(_ animation: SparkAnimation) {
        animation.start()
    }

    /// Stop a Spark animation.
    /// - parameter animation: the animation to stop.
    func stopAnimation(_ animation: SparkAnimation) {
        animation.stop()
    }
}
