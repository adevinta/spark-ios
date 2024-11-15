//
//  BellAnimationModifier.swift
//  SparkDemo
//
//  Created by robin.lemaire on 15/11/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

internal struct BellAnimationModifier: ViewModifier {

    // MARK: - Properties

    private let rotation: CGFloat = 15
    @State private var animated: Bool = true

    // MARK: - Content

    func body(content: Content) -> some View {
        content
            .rotationEffect(
                .degrees(animated ? self.rotation : -self.rotation)
            )
            .animation(
                .interpolatingSpring(stiffness: 400, damping: 4),
                value: animated
            )
            .rotationEffect(
                .degrees(animated ? -self.rotation : self.rotation)
            )
            .animation(.easeOut, value: self.animated)
            .onAppear() {
                self.animated.toggle()
            }
            .onChange(of: self.animated) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.animated.toggle()
                })
            }
    }
}
