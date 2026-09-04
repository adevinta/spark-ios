//
//  XXXIntentEnvironmentValues.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var xxxIntent: XXXIntent = .default
}

public extension View {

    /// Set the **intent** on the XXX.
    ///
    /// The default value for this property is *XXXIntent.default*.
    func sparkXXXIntent(_ intent: XXXIntent) -> some View {
        self.environment(\.xxxIntent, intent)
    }
}
