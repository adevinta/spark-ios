//
//  View+SparkAnimateExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {

    /// Display a Spark Animation from a type and return a view.
    /// - parameter type: the animation type. Optional.
    /// - parameter delay: the delay before before starting the animation. Default is *.zero*.
    /// - parameter repeat: the repeat type of the animation. Default is *.once*.
    /// - parameter completion: the completion when the animation is finished. *Optional*. Default is *nil*.
    /// - Returns: A view.
    @ViewBuilder
    func animate(
        for type: SparkAnimationType?,
        delay: TimeInterval = .zero,
        repeat: SparkAnimationRepeat = .once,
        completion: (() -> Void)? = nil
    ) -> some View {
        switch type {
        case .bell:
            self.modifier(BellAnimationModifier(
                delay: delay,
                repeat: `repeat`,
                completion: completion
            ))
        case nil:
            self
        }
    }
}
