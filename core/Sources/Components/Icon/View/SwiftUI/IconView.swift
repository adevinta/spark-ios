//
//  IconView.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 24.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkTheming

public struct IconView: View {

    // MARK: - Private properties

    @ObservedObject private var viewModel: IconViewModel
    @ScaledMetric private var sizeValue: CGFloat
    private var iconImage: Image

    // MARK: - Initialization

    /// A SwiftUI Icon component
    /// - Parameters:
    ///   - theme: The Spark theme
    ///   - intent: Intent of icon
    ///   - size: Size of icon
    public init(
        theme: Theme,
        intent: IconIntent,
        size: IconSize,
        iconImage: Image
    ) {
        self.viewModel = IconViewModel(
            theme: theme,
            intent: intent,
            size: size
        )
        self._sizeValue = ScaledMetric(wrappedValue: size.value)
        self.iconImage = iconImage
    }

    public var body: some View {
        iconImage
            .resizable()
            .frame(width: sizeValue, height: sizeValue)
            .foregroundColor(self.viewModel.color.color)
            .accessibilityIdentifier(IconAccessibilityIdentifier.view)
    }
}
