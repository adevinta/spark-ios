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
    let colorToken: ColorToken?

    // MARK: - Initialization

    init(width: CGFloat,
         radius: CGFloat,
         colorToken: ColorToken?) {
        self.width = width
        self.radius = radius
        self.colorToken = colorToken
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
        if let colorToken = self.colorToken {
            if self.radius.isInfinite {
                Capsule(style: .continuous)
                    .stroke(colorToken.color, lineWidth: self.width)
            } else {
                RoundedRectangle(cornerRadius: self.radius)
                    .stroke(colorToken.color, lineWidth: self.width)
            }
        }
    }
}
