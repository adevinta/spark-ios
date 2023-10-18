//
//  ProgressBarIndeterminateUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

/// The UIKit version for the progress bar indeterminate.
public final class ProgressBarIndeterminateUIView: ProgressBarMainUIView {

    // MARK: - Type alias

    private typealias Constants = ProgressBarConstants

    // MARK: - Public Properties

    /// The spark theme of the progress bar indeterminate.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    /// The shape of the progress bar indeterminate.
    public var shape: ProgressBarShape {
        get {
            return self.viewModel.shape
        }
        set {
            self.viewModel.set(shape: newValue)
        }
    }

    /// The intent of the progress bar indeterminate.
    public var intent: ProgressBarIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.set(intent: newValue)
        }
    }

    // MARK: - Private Properties

    private let viewModel: ProgressBarIndeterminateViewModel

    var indicatorLeadingConstraint: NSLayoutConstraint?

    var firstAnimator: UIViewPropertyAnimator?
    var lastAnimator: UIViewPropertyAnimator?

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initialize a new progress bar indeterminate view.
    /// By default, the animation is not started.
    /// - Parameters:
    ///   - theme: The spark theme of the progress bar indeterminate.
    ///   - intent: The intent of the progress bar indeterminate.
    ///   - shape: The shape of the progress bar indeterminate.
    public init(
        theme: Theme,
        intent: ProgressBarIntent,
        shape: ProgressBarShape
    ) {
        self.viewModel = .init(
            for: .uiKit,
            theme: theme,
            intent: intent,
            shape: shape,
            isAnimating: false
        )

        super.init()

        // Setup
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    override func setupView() {
        super.setupView()

        // Setup subscriptions
        self.setupSubscriptions()

        // Load view model
        self.viewModel.load()
    }

    // MARK: - Constraints

    override func setupIndicatorConstraints() {
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.indicatorView.topAnchor.constraint(equalTo: self.topAnchor),
            self.indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.indicatorLeadingConstraint = self.indicatorView.leadingAnchor.constraint(
            equalTo: self.trackView.leadingAnchor
        )
        self.indicatorLeadingConstraint?.isActive = true

        self.indicatorWidthConstraint = self.indicatorView.widthAnchor.constraint(equalToConstant: 0)
        self.indicatorWidthConstraint?.isActive = true
    }

    // MARK: - Animation

    /// Start the infinite animation
    public func startAnimating() {
        if !self.viewModel.isAnimating {
            self.resetIndicatorConstraints()
            self.reloadAnimation()

            self.viewModel.isAnimating = true
        }
    }

    /// Stop the infinite  animation
    public func stopAnimating() {
        if self.viewModel.isAnimating {
            // Stop animation
            self.firstAnimator?.stopAnimation(true)
            self.lastAnimator?.stopAnimation(true)

            self.resetIndicatorConstraints()

            self.viewModel.isAnimating = false
        }
    }

    private func reloadAnimation(
        isFirstAnimation: Bool = true
    ) {
        let animationDuration = Constants.Animation.duration
        // Frames
        // **
        // First Animator
        let easeInAnimation = self.viewModel.easeInAnimatedData(
            trackWidth: self.trackView.frame.width
        )
        self.firstAnimator = UIViewPropertyAnimator(
            duration: animationDuration,
            curve: .easeIn
        )
        self.firstAnimator?.addAnimations { [weak self] in
            self?.indicatorLeadingConstraint?.constant = easeInAnimation.leadingSpaceWidth
            self?.indicatorWidthConstraint?.constant = easeInAnimation.indicatorWidth

            self?.layoutIfNeeded()
        }
        // **

        // **
        // Last Animator
        let easeOutAnimation = self.viewModel.easeOutAnimatedData(
            trackWidth: self.trackView.frame.width
        )
        self.lastAnimator = UIViewPropertyAnimator(
            duration: animationDuration,
            curve: .easeOut
        )
        self.lastAnimator?.addAnimations { [weak self] in
            self?.indicatorLeadingConstraint?.constant = easeOutAnimation.leadingSpaceWidth
            self?.indicatorWidthConstraint?.constant = easeOutAnimation.indicatorWidth

            self?.layoutIfNeeded()
        }
        self.lastAnimator?.addCompletion { [weak self] position in
            if position == .end {
                self?.resetIndicatorConstraints()

                self?.reloadAnimation(
                    isFirstAnimation: false
                )
            }
        }
        // **

        // Start animations
        self.firstAnimator?.startAnimation(
            afterDelay: isFirstAnimation ? 0 : animationDuration
        )
        self.lastAnimator?.startAnimation(
            afterDelay: isFirstAnimation ? animationDuration : animationDuration * 2
        )
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // Colors
        self.viewModel.$colors.subscribe(in: &self.subscriptions) { [weak self] colors in
            self?.updateColors(colors)
        }

        // Corner Radius
        self.viewModel.$cornerRadius.subscribe(in: &self.subscriptions) { [weak self] cornerRadius in
            guard let cornerRadius else { return }
            self?.cornerRadius = cornerRadius
        }
    }

    // MARK: - Update Constraints

    private func resetIndicatorConstraints() {
        let animation = self.viewModel.resetAnimatedData(
            trackWidth: self.trackView.frame.width
        )
        self.indicatorLeadingConstraint?.constant = animation.leadingSpaceWidth
        self.indicatorWidthConstraint?.constant = animation.indicatorWidth

        self.layoutIfNeeded()
    }
}
