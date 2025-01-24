//
//  Radius.swift
//  SparkDemo
//
//  Created by robin.lemaire on 23/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

enum Radius: CGFloat {
    case small = 6
    case medium = 12
    case large = 24
}

// MARK: - SwiftUI Extension & ViewModifier

extension View {

    func radius(
        _ radius: Radius
    ) -> some View {
        self.modifier(
            RadiusViewModifier(radius: radius)
        )
    }
}

struct RadiusViewModifier: ViewModifier {

    // MARK: - Properties

    let radius: Radius

    // MARK: - View

    public func body(content: Content) -> some View {
        content.clipShape(.rect(cornerRadius: self.radius.rawValue))
    }
}
