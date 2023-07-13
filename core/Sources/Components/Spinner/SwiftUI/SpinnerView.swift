//
//  SpinnerView.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// SpinnerView is a single indeterminate spinner.
/// The spinner can have a size of `small` or `medium` and have different intents which determine the color of the spinner.
/// The spinner spin animation is 1 second linear infinite.
public struct SpinnerView: View {

    // MARK: - Type Alias
    private typealias AccessibilityIdentifier = SpinnerAccessibilityIdentifier

    // MARK: - Private Properties
    @ObservedObject private var viewModel: SpinnerViewModel
    @State private var rotationDegrees = 0.0

    @ScaledMetric private var size: CGFloat
    @ScaledMetric private var strokeWidth: CGFloat

    // MARK: - Init
    /// init
    /// Parameters:
    /// - theme: The current `Theme`
    /// - intent: The `SpinnerIntent` intent used for coloring the spinner. The default is `primary`
    /// - spinnerSize: The defined size of the spinner`SpinnerSize`. The default is `small`
    public init(theme: Theme,
                intent: SpinnerIntent = .primary,
                spinnerSize: SpinnerSize = .small) {
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
            .stroke(lineWidth: self.strokeWidth)
            .foregroundColor(self.viewModel.intentColor.color)
            .frame(width: self.size, height: self.size)
            .rotationEffect(.degrees(self.rotationDegrees))
            .animation(self.animation(), value: self.viewModel.isSpinning)
            .task {
                self.rotationDegrees = 360.0
                self.viewModel.isSpinning = true
            }
            .accessibilityIdentifier(AccessibilityIdentifier.spinner)
    }

    // MARK: - Public modifiers
    public func spinnerSize(_ spinnerSize: SpinnerSize) -> Self {
        self.viewModel.spinnerSize = spinnerSize
        return self
    }

    public func intent(_ intent: SpinnerIntent) -> Self {
        self.viewModel.intent = intent
        return self
    }

    // MARK: - Private helpers
    private func animation() -> Animation? {
        guard self.viewModel.isSpinning else {
            return nil
        }
        return .linear(duration: self.viewModel.duration)
            .repeatForever(autoreverses: false)
    }
}

