//
//  IsEnabledModifier.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 03.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct IsEnabledModifier: ViewModifier {
    let isEnabled: Bool
    let action: (Bool) -> Void

    func body(content: Content) -> some View {
        DispatchQueue.main.async {
            self.action(self.isEnabled)
        }

        return content.disabled(!self.isEnabled)
    }
}

struct IsEnabledEnvironmentModifier: EnvironmentalModifier {
    let action: (Bool) -> Void

    func resolve(in environment: EnvironmentValues) -> IsEnabledModifier {
        return IsEnabledModifier(isEnabled: environment.isEnabled, action: action)
    }
}

extension View {
    func isEnabledChanged(_ action: @escaping (Bool) -> Void) -> some View {
        self.modifier(IsEnabledEnvironmentModifier(action: action))
    }
}
