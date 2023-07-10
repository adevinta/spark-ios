//
//  SpinnerView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct SpinnerView: View {
    @ObservedObject private var viewModel: SpinnerViewModel
    @State private var rotationDegrees = 0.0
    @Binding private var isSpinning: Bool

    @ScaledMetric private var size: CGFloat
    @ScaledMetric private var strokeWidth: CGFloat

    public init(theme: Theme,
                intent: SpinnerIntent,
                spinnerSize: SpinnerSize,
                isSpinning: Binding<Bool>
    ) {
        self.init(viewModel: SpinnerViewModel(theme: theme, intent: intent, spinnerSize: spinnerSize), isSpinning: isSpinning)
    }

    init(viewModel: SpinnerViewModel, isSpinning: Binding<Bool>) {
        self.viewModel = viewModel
        self._size = ScaledMetric(wrappedValue: viewModel.size)
        self._strokeWidth = ScaledMetric(wrappedValue: viewModel.strokeWidth)
        self._isSpinning = isSpinning
    }

    public var body: some View {
            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(lineWidth: self.viewModel.strokeWidth)
                .foregroundColor(self.viewModel.intentColor.color)
                .frame(width: self.viewModel.size, height: self.viewModel.size)
                .offset(y: 0)
                .rotationEffect(.degrees(self.rotationDegrees))
                .animation(self.animation(isSpinning: self.viewModel.isSpinning), value: self.viewModel.isSpinning)
                .task {
                    self.rotationDegrees = 360.0
                    self.viewModel.isSpinning = self.isSpinning
                }
                .onChange(of: self.isSpinning) { newValue in
                    print("Value changed of isSpinning = \(newValue)")
                    self.viewModel.isSpinning = newValue
                }
    }

    public func theme(_ theme: Theme) -> Self {
        self.viewModel.theme = theme
        return self
    }

    public func spinnerSize(_ spinnerSize: SpinnerSize) -> Self {
        self.viewModel.spinnerSize = spinnerSize
        return self
    }

    public func intent(_ intent: SpinnerIntent) -> Self {
        self.viewModel.intent = intent
        return self
    }

    private func animation(isSpinning: Bool) -> Animation? {
        guard isSpinning else {
            print("returning nil")
            return nil
        }
        print("Created new animation isSpinning = \(isSpinning)")
        return .linear(duration: self.viewModel.duration)
            .repeat(while: isSpinning)
            .speed(self.viewModel.duration)
    }

}

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = false) -> Animation {
        if expression {
            print("Animation should start")
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            print("Animation should stop")
            return self
        }
    }
}
