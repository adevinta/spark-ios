//
//  UIView+ExecuteExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 26/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

extension UIView {

    /// Execute a code with or without animation.
    static func execute(
        isAnimated: Bool,
        withDuration duration: TimeInterval,
        context: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        if isAnimated {
            UIView.animate(
                withDuration: duration,
                animations: context,
                completion: completion)
        } else {
            context()
            completion?(true)
        }
    }

    /// Execute a code with or without transition animation.
    static func execute(
        with view: UIView,
        isTransitionAnimated: Bool,
        withDuration duration: TimeInterval,
        options: UIView.AnimationOptions = [],
        context: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        if isTransitionAnimated {
            UIView.transition(
                with: view,
                duration: duration,
                options: options,
                animations: context,
                completion: completion)
        } else {
            context()
            completion?(true)
        }
    }
}
