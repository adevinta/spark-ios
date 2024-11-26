//
//  View+SparkAnimationTypeExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {

    /// Set the **animationType** environement value from a type.
    /// - parameter type: the animation type. Optional.
    /// - Returns: A view.
    func animation(_ type: SparkAnimationType?) -> some View {
        self.environment(\.animationType, type)
    }
}
