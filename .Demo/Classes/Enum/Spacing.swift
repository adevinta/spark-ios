//
//  Spacing.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

enum Spacing: CGFloat {
    case none = 0
    case xSmall = 4
    case small = 8
    case medium = 16
    case large = 24
    case xLarge = 32
    case xxLarge = 48
    case xxxLarge = 64
}

// MARK: - SwiftUI Extensions

extension VStack where Content: View {

    init(
        alignment: HorizontalAlignment = .center,
        spacing: Spacing,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: spacing.rawValue,
            content: content
        )
    }
}

extension HStack where Content: View {

    init(
        alignment: VerticalAlignment = .center,
        spacing: Spacing,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            spacing: spacing.rawValue,
            content: content
        )
    }
}
