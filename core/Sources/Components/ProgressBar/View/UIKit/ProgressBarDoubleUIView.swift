//
//  ProgressBarDoubleUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// The UIKit version for the progress bar double.
public final class ProgressBarDoubleUIView: ProgressBarMainUIView {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ProgressBarAccessibilityIdentifier

    // MARK: - Components

    private let bottomIndicatorView = UIView()

    // MARK: - Public Properties

    /// The spark theme of the progress bar double.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    /// The intent of the progress bar double.
    public var intent: ProgressBarDoubleIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.set(intent: newValue)
        }
    }

    /// The shape of the progress bar double.
    public var shape: ProgressBarShape {
        get {
            return self.viewModel.shape
        }
        set {
            self.viewModel.set(shape: newValue)
        }
    }

    /// The top indicator value of the progress bar double.
    /// note: Value **MUST** be into 0 (for 0 %) and 1 (for 100%)
    public var topValue: CGFloat = 0 {
        didSet {
            self.updateWidthConstraints(
                &self.indicatorWidthConstraint,
                multiplier: self.topValue,
                view: self.indicatorView
            )
        }
    }

    /// The bottom indicator value of the progress bar double.
    /// note: Value **MUST** be into 0 (for 0 %) and 1 (for 100%)
    public var bottomValue: CGFloat = 0 {
        didSet {
            self.updateWidthConstraints(
                &self.bottomIndicatorWidthConstraint,
                multiplier: self.bottomValue,
                view: self.bottomIndicatorView
            )
        }
    }

    // MARK: - Private Properties

    private let viewModel: ProgressBarDoubleViewModel

    private var bottomIndicatorWidthConstraint: NSLayoutConstraint?

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initialize a new progress bar double view
    /// - Parameters:
    ///   - theme: The spark theme of the progress bar double.
    ///   - intent: The intent of the progress bar double.
    ///   - shape: The shape of the progress bar double.
    public init(
        theme: Theme,
        intent: ProgressBarDoubleIntent,
        shape: ProgressBarShape
    ) {
        self.viewModel = .init(
            for: .uiKit,
            theme: theme,
            intent: intent,
            shape: shape
        )

        super.init()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    override func setupView() {
        super.setupView()

        // Add subview
        self.insertSubview(
            self.bottomIndicatorView,
            belowSubview: self.indicatorView
        )

        // Identifiers
        self.bottomIndicatorView.accessibilityIdentifier = AccessibilityIdentifier.bottomIndicatorView

        // Setup constraints
        self.setupBottomIndicatorConstraints()

        // Setup subscriptions
        self.setupSubscriptions()

        // Load view model
        self.viewModel.load()
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // Colors
        self.viewModel.$colors.subscribe(in: &self.subscriptions) { [weak self] colors in
            guard let self, let colors else { return }

            self.updateColors(colors)
            self.bottomIndicatorView.backgroundColor = colors.bottomIndicatorBackgroundColorToken.uiColor
        }

        // Corner Radius
        self.viewModel.$cornerRadius.subscribe(in: &self.subscriptions) { [weak self] cornerRadius in
            guard let cornerRadius else { return }
            self?.cornerRadius = cornerRadius
        }
    }

    // MARK: - Constraints

    internal func setupBottomIndicatorConstraints() {
        self.setupSpecificIndicatorConstraints(
            &self.bottomIndicatorWidthConstraint,
            on: self.bottomIndicatorView
        )
    }

    // MARK: - Update UI

    override func updateCornerRadius() {
        super.updateCornerRadius()

        self.bottomIndicatorView.setCornerRadius(self.cornerRadius)
    }

    // MARK: - Update Constraints

    override func updateWidthConstraints(
        _ constraint: inout NSLayoutConstraint?,
        multiplier: CGFloat,
        view: UIView
    ) {
        // Update constraints only if value is valid
        guard self.viewModel.isValidIndicatorValue(multiplier) else {
            return
        }

        super.updateWidthConstraints(&constraint, multiplier: multiplier, view: view)
    }
}
