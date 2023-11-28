//
//  RatingInputStarUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 27.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit

public final class RatingInputStarUIView: UIControl {

    private var sizeConstraints = [NSLayoutConstraint]()
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: RatingDisplayViewModel

    private lazy var star = StarUIView(
        rating: self.viewModel.rating,
        fillMode: .full,
        lineWidth: self.borderWidth,
        borderColor: self.viewModel.colors.strokeColor.uiColor,
        fillColor: self.viewModel.colors.fillColor.uiColor
    )

    // MARK: - Scaled metrics
    @ScaledUIMetric private var borderWidth: CGFloat
    @ScaledUIMetric private var ratingSize: CGFloat

    public override var isSelected: Bool {
        get {
            return self.viewModel.rating == 1.0
        }
        set {
            self.viewModel.rating = newValue ? 1.0 : 0.0
        }
    }

    public override var isHighlighted: Bool {
        get {
            return self.viewModel.ratingState.isPressed
        }
        set {
            self.viewModel.setState(isPressed: newValue)
        }
    }

    public var rating: CGFloat {
        get {
            return self.viewModel.rating
        }
        set {
            self.viewModel.rating = StarFillMode.full.rating(of: newValue)
        }
    }

    public init(
        theme: Theme,
        intent: RatingIntent,
        rating: CGFloat = 0.0,
        configuration: StarConfiguration = .default
    ) {
        self.viewModel = .init(
            theme: theme,
            intent: intent,
            size: .input,
            count: .one,
            rating: rating)

        self.borderWidth = self.viewModel.ratingSize.borderWidth
        self.ratingSize = self.viewModel.ratingSize.height
    
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._borderWidth.update(traitCollection: traitCollection)
        self._ratingSize.update(traitCollection: traitCollection)

        self.didUpdate(borderWidth: self.borderWidth)

        self.sizeConstraints.forEach { constraint in
            constraint.constant = self.ratingSize
        }
    }

    private func didUpdate(borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        self.star.lineWidth = self.borderWidth
    }

    private func setupView() {
        self.addSubviewSizedEqually(self.star)

        self.sizeConstraints.append(star.widthAnchor.constraint(equalToConstant: self.ratingSize))
        self.sizeConstraints.append(star.heightAnchor.constraint(equalToConstant: self.ratingSize))

        NSLayoutConstraint.activate(self.sizeConstraints)
    }
}
