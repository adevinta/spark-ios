//
//  RatingDisplayUIView.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// RatingDisplayUIView is a view with which a 5 star rating can be shown.
/// The rating value is expected to be within the range [0...5]. Values outside of this range will be ignored. Anything less than zero will be shown as zero. Anything greater than 5 will be shown as five.
/// The rating display may be shown with 5 stars (the standard version) or just one star for a shortened version. For the shortened version, the expected value range is still [0...5]
public class RatingDisplayUIView: UIView {

    // MARK: - Private variables
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let viewModel: RatingDisplayViewModel
    private let fillMode: StarFillMode
    private var sizeConstraints = [NSLayoutConstraint]()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Public accessors
    /// Count: the number of stars to show in the rating.
    /// Only values five and one are allowed, five is the default.
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

    /// The current rating. This should be a value in the range [0...5].
    /// Anything small than 0 will be treated as a 0, and anything greater than 5 will be treated as a five.
    public var rating: CGFloat {
        get {
            return self.viewModel.rating
        }
        set {
            self.viewModel.rating = newValue
        }
    }

    /// The current theme.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }
    
    /// The intent for defining the color.
    public var intent: RatingIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }
    
    /// The size of the rating stars.
    /// Possible sizes `small`, `medium` and `input`.
    public var size: RatingDisplaySize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.size = newValue
        }
    }

    // MARK: - Internal accessors
    internal var isPressed: Bool {
        get {
            self.viewModel.ratingState.isPressed
        }
        set {
            self.viewModel.updateState(isPressed: newValue)
        }
    }

    internal var isEnabled: Bool {
        get {
            self.viewModel.ratingState.isEnabled
        }
        set {
            self.viewModel.updateState(isEnabled: newValue)
        }
    }

    internal var ratingStarViews : [StarUIView] { self.stackView.arrangedSubviews.compactMap { view in
            return view as? StarUIView
        }
    }

    // MARK: - Scaled metrics
    @ScaledUIMetric private var borderWidth: CGFloat
    @ScaledUIMetric private var ratingSize: CGFloat
    @ScaledUIMetric private var spacing: CGFloat

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacing.update(traitCollection: traitCollection)
        self._borderWidth.update(traitCollection: traitCollection)
        self._ratingSize.update(traitCollection: traitCollection)

        self.updateStarsViewsBorderWidths()
        self.stackView.spacing = self.spacing

        self.sizeConstraints.forEach { constraint in
            constraint.constant = self.ratingSize
        }
    }

    // MARK: - Private functions
    private func setupView() {
        self.accessibilityIdentifier = RatingDisplayAccessibilityIdentifier.identifier
        var currentRating = self.viewModel.ratingValue
        for i in 0..<count.rawValue {
            let star = StarUIView(
                rating: currentRating,
                fillMode: self.fillMode,
                lineWidth: self.borderWidth,
                borderColor: self.viewModel.colors.strokeColor.uiColor,
                fillColor: self.viewModel.colors.fillColor.uiColor
            )
            currentRating -= 1

            star.accessibilityIdentifier = "\(RatingDisplayAccessibilityIdentifier.identifier)-\(i+1)"

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
            self?.didUpdate(size: size)
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
        self.layer.opacity = Float(colors.opacity)
    }

    private func didUpdate(size: RatingSizeAttributes) {
        self.didUpdate(borderWidth: size.borderWidth)
        self.didUpdate(size: size.height)
        self.didUpdate(spacing: size.spacing)
    }

    private func didUpdate(borderWidth: CGFloat) {
        self.borderWidth = borderWidth

        self.updateStarsViewsBorderWidths()
    }

    private func updateStarsViewsBorderWidths() {
        for view in self.ratingStarViews {
            view.lineWidth = self.borderWidth
        }
    }

    private func didUpdate(spacing: CGFloat) {
        self.spacing = spacing
        self.stackView.spacing = self.spacing
    }

    private func didUpdate(size: CGFloat) {
        self.ratingSize = size

        self.sizeConstraints.forEach { constraint in
            constraint.constant = self.ratingSize
        }
    }
}
