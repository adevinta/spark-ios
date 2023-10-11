//
//  ProgressBarContentView.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct ProgressBarContentView<IndicatorView: View>: View {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ProgressBarAccessibilityIdentifier
    private typealias Constants = ProgressBarConstants

    // MARK: - Components

    private var indicatorView: () -> IndicatorView

    // MARK: - Properties

    private let trackCornerRadius: CGFloat?
    private let trackBackgroundColor: (any ColorToken)?

    @ScaledMetric private var height: CGFloat = Constants.height

    // MARK: - Initialization

    init(
        trackCornerRadius: CGFloat?,
        trackBackgroundColor: (any ColorToken)?,
        @ViewBuilder indicatorView: @escaping () -> IndicatorView
    ) {
        self.trackCornerRadius = trackCornerRadius
        self.trackBackgroundColor = trackBackgroundColor
        self.indicatorView = indicatorView
    }

    // MARK: - View

    public var body: some View {
        ZStack() {
            // Track
            ProgressBarRectangle(cornerRadius: self.trackCornerRadius ?? 0)
                .fill(self.trackBackgroundColor)
                .accessibilityIdentifier(AccessibilityIdentifier.trackView)

            // Indicator view integration
            self.indicatorView()
        }
        .frame(height: self.height)
        .accessibilityIdentifier(AccessibilityIdentifier.contentView)
    }
}
