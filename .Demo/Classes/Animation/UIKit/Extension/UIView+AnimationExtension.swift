//
//  UIView+AnimationExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 18/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

public extension UIView {

    // TODO: comment
    class func animate(
        withType type: SparkAnimationType,
        on views: UIView...,
        delay: TimeInterval = .zero,
        repeat: Bool = false, // create a repeat enum: none, once, limited, unlimited
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
