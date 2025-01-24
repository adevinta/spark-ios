//
//  Padding.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

enum Padding: CGFloat {
    case xSmall = 4
    case small = 8
    case medium = 16
    case large = 24
    case xLarge = 32
}

// MARK: - SwiftUI Extension & ViewModifier

extension View {

    func padding(
        _ edges: Edge.Set = .all,
        _ padding: Padding
    ) -> some View {
        self.modifier(
            PaddingViewModifier(edges: edges, padding: padding)
        )
    }
}

struct PaddingViewModifier: ViewModifier {

    // MARK: - Properties

    let edges: Edge.Set
    let padding: Padding

    // MARK: - View

    public func body(content: Content) -> some View {
        content.padding(self.edges, self.padding.rawValue)
    }
}
