//
//  RatingDisplayView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.12.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// RatingDisplayView is a view with which a 5 star rating can be shown.
/// The rating value is expected to be within the range [0...5]. Values outside of this range will be ignored. Anything less than zero will be shown as zero. Anything greater than 5 will be shown as five.
/// The rating display may be shown with 5 stars (the standard version) or just one star for a shortened version. For the shortened version, the expected value range is still [0...5]
public struct RatingDisplayView: View {

    // MARK: - Private properties
    private let fillMode: StarFillMode
    private let configuration: StarConfiguration
    @ObservedObject private var viewModel: RatingDisplayViewModel

    // MARK: - Scaled metrics
    @ScaledMetric private var scalingFactor: CGFloat = 1

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
        self.viewModel = viewModel
        self.configuration = configuration
    }

    // MARK: - View
    public var body: some View {
        self.stars()
            .accessibilityIdentifier(RatingDisplayAccessibilityIdentifier.identifier)
    }

    @ViewBuilder
    private func stars() -> some View {
        if self.viewModel.count == .one {
            self.oneStar(
                rating: self.viewModel.ratingValue,
                index: 0
            )
        } else {
            self.fiveStars()
        }
    }

    // MARK: - Private functions
    @ViewBuilder
    private func oneStar(rating: CGFloat, index: Int) -> some View {
        let size = self.viewModel.ratingSize.height * self.scalingFactor
        StarView(
            rating: rating,
            fillMode: self.fillMode,
            lineWidth: self.viewModel.ratingSize.borderWidth * self.scalingFactor,
            borderColor: self.viewModel.colors.strokeColor.color,
            fillColor: self.viewModel.colors.fillColor.color,
            configuration: self.configuration
        )
        .frame(
            width: size,
            height: size
        )
        .accessibilityIdentifier("\(RatingDisplayAccessibilityIdentifier.identifier)-\(index)")
    }

    @ViewBuilder
    private func fiveStars() -> some View {
        HStack(spacing: self.viewModel.ratingSize.spacing * self.scalingFactor) {
            ForEach((0...4), id: \.self) { index in
                self.oneStar(
                    rating: self.viewModel.ratingValue - CGFloat(index),
                    index: index
                )
            }
        }
    }
}
