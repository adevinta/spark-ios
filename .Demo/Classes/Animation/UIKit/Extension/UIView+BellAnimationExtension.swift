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
        repeat: Bool,
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
        isFirstAnimation: Bool = true,
        delay: TimeInterval,
        repeat: Bool,
        completion: ((Bool) -> Void)?
    ) {
        UIView.animate(
            withDuration: 0.1,
            delay: isFirstAnimation ? delay : 2.0,
            animations: { [weak self] in
                self?.transform = .init(rotationAngle: Double.pi * 0.075)
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
                        if `repeat` {
                            self?.animate(
                                isFirstAnimation: false,
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
