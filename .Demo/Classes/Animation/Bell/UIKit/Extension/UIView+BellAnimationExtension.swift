//
//  UIView+BellAnimationExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 18/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

internal extension UIView {

    class func bellAnimation(
        on views: [UIView],
        delay: TimeInterval,
        repeat: SparkAnimationRepeat,
        completion: ((Bool) -> Void)?
    ) {
        // Load the animations for all subviews
        for view in views {
            view.animate(
                delay: delay,
                repeat: `repeat`,
                completion: completion
            )
        }
    }

    private func animate(
        count: Int = 0,
        delay: TimeInterval,
        repeat: SparkAnimationRepeat,
        completion: ((Bool) -> Void)?
    ) {
        UIView.animate(
            withDuration: 0.1,
            delay: count == 0 ? delay : 2.0,
            animations: { [weak self] in
                self?.transform = .init(rotationAngle: -BellConstants.rotationInDegress.degreesToRadians)
            }, completion: { [weak self] result1 in
                guard result1 else { return }
                UIView.animate(
                    withDuration: 2.0,
                    delay: .zero,
                    usingSpringWithDamping: 0.1,
                    initialSpringVelocity: 0,
                    options: .curveEaseInOut,
                    animations: { [weak self] in
                        self?.transform = CGAffineTransformIdentity
                    }, completion: { [weak self] result2 in
                        guard result2 else { return }
                        // Restart the animation if needed
                        let count = count + 1
                        if `repeat`.canContinue(count: count) {
                            self?.animate(
                                count: count,
                                delay: delay,
                                repeat: `repeat`,
                                completion: completion
                            )
                        } else {
                            completion?(result2)
                        }
                    }
                )
            }
        )
    }
}
