//
//  UIView+ExecuteExtension.swift
//  SparkCore
//
//  Created by robin.lemaire on 26/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

enum UIExecuteAnimationType {
    case unanimated
    case animated(duration: TimeInterval)
}

extension UIView {

    /// Execute a code with or without animation.
    static func execute(
        animationType: UIExecuteAnimationType,
        instructions: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch animationType {
        case .unanimated:
            instructions()
            completion?(true)

        case .animated(let duration):
            UIView.animate(
                withDuration: duration,
                animations: instructions,
                completion: completion)
        }
    }

    /// Execute a code with or without transition animation.
    static func execute(
        with view: UIView,
        animationType: UIExecuteAnimationType,
        options: UIView.AnimationOptions = [],
        instructions: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        switch animationType {
        case .unanimated:
            instructions()
            completion?(true)

        case .animated(let duration):
            UIView.transition(
                with: view,
                duration: duration,
                options: options,
                animations: instructions,
                completion: completion)
        }
    }
}
