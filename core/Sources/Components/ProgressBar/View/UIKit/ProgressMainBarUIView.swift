//
//  ProgressBarMainUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// This ProgressMainBar view contains all communs subviews (track & indicator), styles, constraints, ... for all progress bar.
/// This view doesn't have a public init.
public class ProgressBarMainUIView: UIView {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ProgressBarAccessibilityIdentifier
    private typealias Constants = ProgressBarConstants

    // MARK: - Components

    internal let trackView = UIView()
    internal let indicatorView = UIView()

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?
    var indicatorWidthConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var height: CGFloat = Constants.height
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.updateCornerRadius()
        }
    }

    // MARK: - Initialization

    internal init() {
        super.init(frame: .zero)

        // Setup
        self.setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    /// Setup the view: subviews, identifiers, constraints, UI.
    /// This method is internal because it can be override by the view that inherits from this class.
    internal func setupView() {
        // Add subviews
        self.addSubview(self.trackView)
        self.addSubview(self.indicatorView)

        // Identifiers
        self.trackView.accessibilityIdentifier = AccessibilityIdentifier.trackView
        self.indicatorView.accessibilityIdentifier = AccessibilityIdentifier.indicatorView

        // View properties
        self.backgroundColor = .clear

        // Setup constraints
        self.setupConstraints()

        // Updates
        self.updateHeight()
        self.updateCornerRadius()
    }

    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layoutIfNeeded()
        self.updateCornerRadius()
    }

    // MARK: - Constraints

    private func setupConstraints() {
        // Global
        self.setupViewConstraints()

        // Subviews
        self.setupTrackConstraints()
        self.setupIndicatorConstraints()
    }

    private func setupViewConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: .zero)
        self.heightConstraint?.isActive = true
    }

    private func setupTrackConstraints() {
        self.trackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.stickEdges(
            from: self.trackView,
            to: self
        )
    }

    /// Setup the indicator view constraints on the view (top, leading, trailing, trailing) and width (a percent of the view width).
    /// This method is internal because it can be override by the view that inherits from this class.
    internal func setupIndicatorConstraints() {
        self.setupSpecificIndicatorConstraints(
            &self.indicatorWidthConstraint,
            on: self.indicatorView
        )
    }

    /// Setup the some indicator view constraints on the view (top, leading, trailing, trailing) and width (a percent of the view width).
    /// - Parameters:
    ///   - widthConstraint: width layoutConstraint to set from the width of the view
    ///   - view: view to constrain
    /// This method is internal because it can be override by the view that inherits from this class
    internal final func setupSpecificIndicatorConstraints(
        _ widthConstraint: inout NSLayoutConstraint?,
        on view: UIView
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])

        widthConstraint = view.widthAnchor.constraint(
            equalTo: self.trackView.widthAnchor
        )
        widthConstraint?.isActive = true
    }

    /// Update the some width constraints multiplier.
    /// - Parameters:
    ///   - widthConstraint: width layoutConstraint to set from the width of the view
    ///   - multiplier: multiplier of the constraint
    ///   - view: view to constrain
    /// This method is internal because it can be override by the view that inherits from this class
    internal func updateWidthConstraints(
        _ constraint: inout NSLayoutConstraint?,
        multiplier: CGFloat,
        view: UIView
    ) {
        NSLayoutConstraint.updateMultiplier(
            on: &constraint,
            multiplier: multiplier,
            layout: view.widthAnchor,
            equalTo: self.trackView.widthAnchor
        )
        view.updateConstraintsIfNeeded()
    }

    // MARK: - Update UI

    /// Update the corner radius of the track and the indicator view
    /// This method is internal because it can be override by the view that inherits from this class
    internal func updateCornerRadius() {
        self.trackView.setCornerRadius(self.cornerRadius)
        self.indicatorView.setCornerRadius(self.cornerRadius)
    }

    private func updateHeight() {
        // Reload size only if value changed
        if self.height > 0 && self.height != self.heightConstraint?.constant {
            self.heightConstraint?.constant = self.height
            self.updateConstraintsIfNeeded()
        }
    }

    /// Update the background color of the track and the indicator view
    /// This method is internal because it can be override by the view that inherits from this class
    internal func updateColors(_ colors: (any ProgressBarMainColors)?) {
        guard let colors else { return }
        
        self.trackView.backgroundColor = colors.trackBackgroundColorToken.uiColor
        self.indicatorView.backgroundColor = colors.indicatorBackgroundColorToken.uiColor
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._height.update(traitCollection: self.traitCollection)
        self.updateHeight()
    }

    // MARK: - Intrinsic Content Size

    public override var intrinsicContentSize: CGSize {
        return CGSize(
            width: self.frame.width,
            height: self.height
        )
    }
}
