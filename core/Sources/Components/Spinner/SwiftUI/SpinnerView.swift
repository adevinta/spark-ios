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

    @ScaledMetric private var size: CGFloat
    @ScaledMetric private var strokeWidth: CGFloat

    public init(theme: Theme,
                intent: SpinnerIntent,
                spinnerSize: SpinnerSize
    ) {
        self.init(viewModel: SpinnerViewModel(theme: theme, intent: intent, spinnerSize: spinnerSize))
    }

    init(viewModel: SpinnerViewModel) {
        self.viewModel = viewModel
        self._size = ScaledMetric(wrappedValue: viewModel.size)
        self._strokeWidth = ScaledMetric(wrappedValue: viewModel.strokeWidth)
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
                    self.viewModel.isSpinning = true
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
            return nil
        }
        return .linear(duration: self.viewModel.duration)
            .repeatForever(autoreverses: false)
            .speed(self.viewModel.duration)
    }
}

