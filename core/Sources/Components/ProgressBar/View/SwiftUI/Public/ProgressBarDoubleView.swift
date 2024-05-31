//
//  ProgressBarDoubleView.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct ProgressBarDoubleView: View {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ProgressBarAccessibilityIdentifier
    private typealias Constants = ProgressBarConstants

    // MARK: - Properties

    @ObservedObject var viewModel: ProgressBarDoubleViewModel

    private let topValue: CGFloat
    private let bottomValue: CGFloat

    // MARK: - Initialization

    /// Initialize a new progress bar double view
    /// - Parameters:
    ///   - theme: The spark theme of the progress bar double.
    ///   - intent: The intent of the progress bar double.
    ///   - shape: The shape of the progress bar double.
    ///   - topValue: The top indicator value of the progress bar double.. Value **MUST** be into 0 (for 0 %) and 1 (for 100%)
    ///   - bottomValue: The bottom indicator value of the progress bar double.. Value **MUST** be into 0 (for 0 %) and 1 (for 100%)
    public init(
        theme: any Theme,
        intent: ProgressBarDoubleIntent,
        shape: ProgressBarShape,
        topValue: CGFloat,
        bottomValue: CGFloat
    ) {
        self.viewModel = .init(
            for: .swiftUI,
            theme: theme,
            intent: intent,
            shape: shape
        )
        self.topValue = topValue
        self.bottomValue = bottomValue
    }

    // MARK: - View

    public var body: some View {
        ProgressBarContentView(
            trackCornerRadius: self.viewModel.cornerRadius,
            trackBackgroundColor: self.viewModel.colors?.trackBackgroundColorToken,
            indicatorView: {
                // Bottom Indicator
                self.bottomIndicator()

                // Top Indicator
                self.topIndicator()
            }
        )
    }

    @ViewBuilder
    private func bottomIndicator() -> some View {
        if self.viewModel.isValidIndicatorValue(self.bottomValue) {
            self.bottomRectangle().proportionalWidth(from: self.bottomValue)
        } else {
            self.bottomRectangle()
        }
    }

    private func bottomRectangle() -> some View {
        RoundedRectangle(cornerRadius: self.viewModel.cornerRadius ?? 0)
            .fill(self.viewModel.colors?.bottomIndicatorBackgroundColorToken)
            .accessibilityIdentifier(AccessibilityIdentifier.bottomIndicatorView)
    }

    @ViewBuilder
    private func topIndicator() -> some View {
        if self.viewModel.isValidIndicatorValue(self.topValue) {
            self.topRectangle().proportionalWidth(from: self.topValue)
        } else {
            self.topRectangle()
        }
    }

    private func topRectangle() -> some View {
        RoundedRectangle(cornerRadius: self.viewModel.cornerRadius ?? 0)
            .fill(self.viewModel.colors?.indicatorBackgroundColorToken)

    }

}
