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

    private let rotation: CGFloat = BellConstants.rotationInDegress
    @State private var ringBell: Bool = false
    @State private var count: Int = 0

    private let delay: TimeInterval
    private let `repeat`: SparkAnimationRepeat
    private var completion: (() -> Void)? = nil

    // MARK: - Initialization

    init(
        delay: TimeInterval,
        `repeat`: SparkAnimationRepeat,
        completion: (() -> Void)? = nil
    ) {
        self.delay = delay
        self.`repeat` = `repeat`
        self.completion = completion
    }

    // MARK: - Content

    func body(content: Content) -> some View {
        content
            .rotationEffect(
                .degrees(self.ringBell ? -self.rotation : self.rotation)
            )
            .animation(
                .interpolatingSpring(stiffness: 400, damping: 4),
                value: self.ringBell
            )
            .rotationEffect(
                .degrees(self.ringBell ? self.rotation : -self.rotation)
            )
            .animation(.easeOut, value: self.ringBell)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: {
                    self.ringBell.toggle()
                })
            }
            .onChange(of: self.ringBell) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {

                    self.count += 1
                    if self.repeat.canContinue(count: self.count) {
                        self.ringBell.toggle()
                    } else {
                        self.completion?()
                    }
                })
            }
            .id("BellAnimation-\(self.count)") // Needed to reload the animation from the initial position
    }
}
