//
//  SparkAnimationKey.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

/// The Spark Animation EnvironmentKey.
public struct SparkAnimationKey: EnvironmentKey {
    public static let defaultValue: SparkAnimationType? = nil
}

/// The Spark animationType EnvironmentValues.
public extension EnvironmentValues {

    /// The animation type. Optional.
    var animationType: SparkAnimationType? {
        get { self[SparkAnimationKey.self] }
        set { self[SparkAnimationKey.self] = newValue }
    }
}
