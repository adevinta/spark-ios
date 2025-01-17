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

    /// Add a border to the current view.
    /// - Parameters:
    ///   - width: The border width.
    ///   - radius: The border radius.
    ///   - colorToken: The color token of the border.
    /// - Returns: Current View.
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

    private let edges: Edge.Set
    private let padding: Padding

    // MARK: - Initialization

    public init(
        edges: Edge.Set,
        padding: Padding
    ) {
        self.edges = edges
        self.padding = padding
    }

    // MARK: - View

    public func body(content: Content) -> some View {
        content.padding(self.edges, self.padding.rawValue)
    }
}
