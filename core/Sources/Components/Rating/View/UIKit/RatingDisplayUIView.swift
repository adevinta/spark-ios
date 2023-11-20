//
//  RatingDisplayUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

public class RatingDisplayUIView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        return stackView
    }()
    
    private let viewModel: RatingDisplayViewModel
    private let fillMode: StarFillMode
    private var sizeConstraints = [NSLayoutConstraint]()
    private var cancellable = Set<AnyCancellable>()

    private var ratingStarViews : [StarUIView] { self.stackView.arrangedSubviews.compactMap { view in
            return view as? StarUIView
        }
    }

    public var count: RatingStarsCount {
        get {
            return self.viewModel.count
        }
        set {
            guard self.viewModel.count != newValue else { return }
            self.viewModel.count = newValue
            self.updateView()
        }
    }

    public var rating: CGFloat {
        get {
            return self.viewModel.rating
        }
        set {
            self.viewModel.rating = newValue
        }
    }

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }
    
    public var intent: RatingIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }
    
    public var size: RatingDisplaySize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.size = newValue
        }
    }
    
    public var lineWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.borderWidth = newValue
            self.didUpdate(borderWidth: self.borderWidth)
        }
    }
    
    @ScaledUIMetric private var borderWidth: CGFloat
    @ScaledUIMetric private var ratingSize: CGFloat
    @ScaledUIMetric private var spacing: CGFloat

    public init(
        theme: Theme,
        intent: RatingIntent,
        count: RatingStarsCount = .five,
        size: RatingDisplaySize = .medium,
        rating: CGFloat = 0.0,
        fillMode: StarFillMode = .half,
        configuration: StarConfiguration = .default
    ) {
        self.fillMode = fillMode
        self.viewModel = RatingDisplayViewModel(
            theme: theme,
            intent: intent,
            size: size,
            count: count,
            rating: rating
        )
        self.spacing = self.viewModel.ratingSize.spacing
        self.ratingSize = self.viewModel.ratingSize.height
        self.borderWidth = self.viewModel.ratingSize.borderWidth

        super.init(frame: .zero)
        self.setupView()
        self.setupSubscriptions()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacing.update(traitCollection: traitCollection)
        self._borderWidth.update(traitCollection: traitCollection)
        self._ratingSize.update(traitCollection: traitCollection)

        self.didUpdate(borderWidth: self.borderWidth)

        self.sizeConstraints.forEach { constraint in
            constraint.constant = self.ratingSize
        }
    }

    private func setupView() {
        var currentRating = self.viewModel.ratingValue
        for _ in 0..<count.rawValue {
            let star = StarUIView(
                rating: currentRating,
                fillMode: self.fillMode,
                lineWidth: self.borderWidth,
                borderColor: self.viewModel.colors.strokeColor.uiColor,
                fillColor: self.viewModel.colors.fillColor.uiColor
            )
            currentRating -= 1

            self.sizeConstraints.append(star.widthAnchor.constraint(equalToConstant: self.ratingSize))
            self.sizeConstraints.append(star.heightAnchor.constraint(equalToConstant: self.ratingSize))
            self.stackView.addArrangedSubview(star)
        }

        self.addSubviewSizedEqually(self.stackView)

        NSLayoutConstraint.activate(self.sizeConstraints)
    }

    private func updateView() {
        self.stackView.removeArrangedSubviews()
        NSLayoutConstraint.deactivate(self.sizeConstraints)
        self.sizeConstraints = []
        self.setupView()
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.subscribe(in: &self.cancellable) { [weak self] colors in
            self?.didUpdate(colors: colors)
        }

        self.viewModel.$ratingSize.subscribe(in: &self.cancellable) { [weak self] size in
            self?.didUpdate(borderWidth: size.borderWidth)
            self?.didUpdate(size: size.height)
            self?.didUpdate(spacing: size.spacing)
        }

        self.viewModel.$ratingValue.subscribe(in: &self.cancellable) {
            [weak self] ratingValue in
            self?.didUpdate(rating: ratingValue)
        }

    }

    private func didUpdate(rating: CGFloat) {
        var currentRating = rating
        for view in self.ratingStarViews {
            view.rating = currentRating
            currentRating -= 1
        }
    }

    private func didUpdate(colors: RatingColors) {
        for view in self.ratingStarViews {
            view.borderColor = colors.strokeColor.uiColor
            view.fillColor = colors.fillColor.uiColor
        }
    }

    private func didUpdate(borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        for view in self.ratingStarViews {
            view.lineWidth = borderWidth
        }
    }

    private func didUpdate(spacing: CGFloat) {
        self.spacing = spacing
        self.stackView.spacing = self.spacing
    }

    private func didUpdate(size: CGFloat) {
        self.ratingSize = size

        self.sizeConstraints.forEach { constraint in
            constraint.constant = size
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
