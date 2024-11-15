//
//  SparkAnimate+ViewExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {

    /// Display a Spark Animation from a type and return a view.
    /// - parameter type: the animation type. Optional.
    /// - Returns: A view.
    @ViewBuilder
    func animate(for type: SparkAnimationType?) -> some View {
        switch type {
        case .bell:
            self.modifier(BellAnimationModifier())
        case nil:
            self
        }
    }
}
