//
//  BorderViewModifier.swift
//  SparkCore
//
//  Created by robin.lemaire on 31/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct BorderViewModifier: ViewModifier {

    // MARK: - Properties

    let width: CGFloat
    let radius: CGFloat
    let color: ColorToken

    // MARK: - Initialization

    init(width: CGFloat,
         radius: CGFloat,
         color: ColorToken) {
        self.width = width
        self.radius = radius
        self.color = color
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius)
            .overlay(
                self.shape
            )
    }

    // MARK: - Builder

    @ViewBuilder var shape: some View {
        if self.radius.isInfinite {
            Capsule(style: .continuous)
                .stroke(self.color.swiftUIColor, lineWidth: self.width)
        } else {
            RoundedRectangle(cornerRadius: self.radius)
                .stroke(self.color.swiftUIColor, lineWidth: self.width)
        }
    }
}
