//
//  RatingDisplayView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public struct RatingDisplayView: View {

    private let fillMode: StarFillMode
    @ObservedObject private var viewModel: RatingDisplayViewModel

    // MARK: - Scaled metrics
    @ScaledMetric private var borderWidth: CGFloat
    @ScaledMetric private var ratingSize: CGFloat
    @ScaledMetric private var spacing: CGFloat

    // MARK: - Initialization


    /// Create a rating display view with the following parameters
    /// - Parameters:
    ///   - theme: The current theme
    ///   - intent: The intent to define the colors
    ///   - count: The number of stars in the rating view. The default is `five`.
    ///   - size: The size of the rating view. The default is `medium`
    ///   - rating: The rating value. This should be a value within the range 0...5
    ///   - fillMode: Define incomplete stars are to be filled. The default is `.half`
    ///   - configuration: A configuration of the star. A default value is defined.
    public init(
        theme: Theme,
        intent: RatingIntent,
        count: RatingStarsCount = .five,
        size: RatingDisplaySize = .medium,
        rating: CGFloat = 0.0,
        fillMode: StarFillMode = .half,
        configuration: StarConfiguration = .default
    ) {
        let viewModel = RatingDisplayViewModel(
            theme: theme,
            intent: intent,
            size: size,
            count: count,
            rating: rating
        )
        self.fillMode = fillMode
        self._spacing = .init(wrappedValue: viewModel.ratingSize.spacing)
        self._ratingSize = .init(wrappedValue: viewModel.ratingSize.height)
        self._borderWidth = .init(wrappedValue: viewModel.ratingSize.borderWidth)

        self.viewModel = viewModel
    }

    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
