//
//  UIView+AnimationExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 18/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UIView {

    /// Animate a view with a Spark animation.
    /// - parameter type: the spark animation type.
    /// - parameter view: the view to animate.
    /// - parameter delay: the delay before before starting the animation. Default is *.zero*.
    /// - parameter repeat: the repeat type of the animation. Default is *.once*.
    /// - parameter completion: the completion when the animation is finished. *Optional*. Default is *nil*.
    class func animate(
        withType type: SparkAnimationType,
        on view: UIView,
        delay: TimeInterval = .zero,
        repeat: SparkAnimationRepeat = .once,
        completion: ((Bool) -> Void)? = nil
    ) {
        self.animate(
            withType: type,
            on: [view],
            delay: delay,
            repeat: `repeat`,
            completion: completion)
    }

    /// Animate some views with a Spark animation.
    /// - parameter type: the spark animation type.
    /// - parameter views: the views to animate.
    /// - parameter delay: the delay before before starting the animation. Default is *.zero*.
    /// - parameter repeat: the repeat type of the animation. Default is *.once*.
    /// - parameter completion: the completion when the animation is finished. *Optional*. Default is *nil*.
    class func animate(
        withType type: SparkAnimationType,
        on views: [UIView],
        delay: TimeInterval = .zero,
        repeat: SparkAnimationRepeat = .once,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch type {
        case .bell:
            UIView.bellAnimation(
                on: views,
                delay: delay,
                repeat: `repeat`,
                completion: completion
            )
        }
    }
}
