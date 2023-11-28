//
//  RatingInputUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 28.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI

public final class RatingInputUIView: UIControl {

//    private let theme: Theme
//    private let intent: RatingIntent
    private let starConfiguration: StarConfiguration

    private let viewModel: RatingDisplayViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Private variables
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.ratingInputs)
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        return stackView
    }()

    private lazy var ratingInputs: [RatingInputStarUIView] = {
        return (0..<RatingStarsCount.five.rawValue).map { i in
            let rating = RatingInputStarUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                configuration: self.starConfiguration
            )
            rating.accessibilityIdentifier = "\(RatingInputAccessibilityIdentifier.identifier)-\(i+1)"
            return rating
        }
    }()

    @ScaledUIMetric private var spacing: CGFloat

    public init(
        theme: Theme,
        intent: RatingIntent,
        rating: CGFloat = 0.0,
        configuration: StarConfiguration = .default) {

            self.viewModel = RatingDisplayViewModel(
                theme: theme,
                intent: intent,
                size: .input,
                count: .five,
                rating: rating
            )
            self.spacing = self.viewModel.ratingSize.spacing
            self.starConfiguration = configuration
            super.init()

            self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacing.update(traitCollection: traitCollection)

        self.stackView.spacing = self.spacing
    }

    private func setupView() {
        self.accessibilityIdentifier = RatingInputAccessibilityIdentifier.identifier
        var currentRating = self.viewModel.ratingValue

        for (i, ratingView) in self.ratingInputs.enumerated() {
            currentRating -= 1
            ratingView.rating = currentRating
            ratingView.publisher(for: .touchUpInside).subscribe(in: &self.cancellables) { [weak self] _ in
                self?.ratingStarPressed(i)
            }
        }
        self.addSubviewSizedEqually(self.stackView)
    }

    private func ratingStarPressed(_ index: Int) {

    }
}
