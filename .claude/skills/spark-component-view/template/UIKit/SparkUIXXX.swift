//
//  SparkUIXXX.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 13/01/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import UIKit
import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming
import Combine

/// A rating visually represents the completion status of a task or process.
///
/// ## Context
///
/// The **value** passed in parameter must be between **0 and 5**.
///
/// You can also add a text, count and aditional texts or labels in the init.
///
/// ## Example of usage
///
/// ```swift
/// let theme: SparkTheming.Theme = MyTheme()
///
/// let ratingDisplay = SparkUIXXX(theme: theme)
/// ratingDisplay.value = 3.76
/// ratingDisplay.size = .large
/// ratingDisplay.stars = .one
/// ratingDisplay.text = "(3,76)"
/// ratingDisplay.countText = "49"
/// ratingDisplay.additionalText = "excellent"
/// self.addSubview(ratingDisplay)
/// ```
///
/// ## Accessibility
///
/// By default, the accessibility value corresponding to the percentage of the value (Eg : **40%** for 0.4).
/// To override this value, you need to set a new **accessibilityValue**.
///
/// You also must set an **accessibilityLabel** to provide some context on the purpose of the component.
///
/// If you use a **count text**, a localized accessibilityValue is set on the Label : "based on XXX reviews".
/// To override this value, you must use the **init** with a **countLabel**
///
/// ## Rendering
///
/// ### With .five star
///
/// ![XXX rendering.](rating_display_default.png)
///
/// ### With .one star
///
/// ![XXX rendering.](rating_display_one_star.png)
///
/// ### With .small size
///
/// ![XXX rendering.](rating_display_small_size.png)
///
/// ### With text
///
/// ![XXX rendering.](rating_display_text.png)
///
/// ### With attributedText
///
/// ![XXX rendering.](rating_display_label.png)
///
/// ### With text label
///
/// ![XXX rendering.](rating_display_label.png)
///
/// ### With value and count texts
///
/// ![XXX rendering.](rating_display_value_and_count_label.png)
///
/// ### With value, count and additional texts
///
/// ![XXX rendering.](rating_display_all_label.png)
public final class SparkUIXXX: UIView {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.starsStackView,
            self.textLabel,
            self.countLabel,
            self.additionalLabel
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var starsStackView: XXXStarsUIStackView = {
        let view = XXXStarsUIStackView(viewModel: self.viewModel)
        view.colors = self.viewModel.colors
        view.size = self.size.cgFloat
        view.contentSpacing = self.viewModel.spacings.stars
        view.stars = self.stars.rawValue
        view.value = self.value
        return view
    }()

    /// The UILabel used to display the rating value.
    ///
    /// Please **do not set a text/attributedText** in this label but use
    /// the ``text`` and ``attributedText`` directly on the ``SparkUIXXX``.
    public var textLabel: UILabel = {
        let label = UILabel()
        label.applyStyles()
        return label
    }()

    /// The UILabel used to display the count value.
    ///
    /// For example, the number of reviews.
    ///
    /// Please **do not set a text/attributedText** in this label but use
    /// the ``countText`` and ``attributedCountText`` directly on the ``SparkUIXXX``.
    public var countLabel: UILabel = {
        let label = UILabel()
        label.applyStyles()
        return label
    }()

    /// The UILabel used to display the additional information.
    ///
    /// Please **do not set a text/attributedText** in this label but use
    /// the ``additionalText`` and ``attributedAdditionalText`` directly on the ``SparkUIXXX``.
    public var additionalLabel: UILabel = {
        let label = UILabel()
        label.applyStyles()
        return label
    }()

    // MARK: - Public Properties

    /// The spark theme of the rating.
    public var theme: any Theme {
        didSet {
            self.viewModel.theme = self.theme
        }
    }

    /// The size of the rating.
    /// Check the ``XXXSize`` to see the **default** value.
    public lazy var size: XXXSize = .default {
        didSet {
            self.viewModel.size = self.size
            self.starsStackView.size = self.size.cgFloat
        }
    }

    /// The number of stars of the rating.
    /// Check the ``XXXStars`` to see the **default** value.
    public var stars: XXXStars = .default {
        didSet {
            self.starsStackView.stars = self.stars.rawValue
        }
    }

    /// The indicator value of the rating.
    /// note: Value **MUST** be into 0 and 5.
    public var value: Double = 0 {
        didSet {
            self.starsStackView.value = self.value
            self.updateAccessibilityValue()
        }
    }

    /// The text of the rating. Displayed to the right of the stars.
    /// Text can be nil, in this case, no text is displayed.
    public var text: String? {
        get {
            self.textLabel.text
        }
        set {
            self.textLabel.text(newValue)
        }
    }

    /// The attributedText of the rating. Displayed to the right of the stars.
    /// Text can be nil, in this case, no text is displayed.
    public var attributedText: NSAttributedString? {
        get {
            self.textLabel.attributedText
        }
        set {
            self.textLabel.attributedText(newValue)
        }
    }

    /// The count text of the rating. Displayed to the right of the stars/value.
    /// Text can be nil, in this case, no text is displayed.
    ///
    /// **Parentheses** is added **automatically**, do not add them.
    ///
    /// Also set the accessibilityLabel with the localized string.
    /// Update the accessibilityLabel in ``countLabel`` to override this value.
    public var countText: String? {
        get {
            self.countLabel.text
        }
        set {
            self.countLabel.text(newValue?.addParentheses)
            self.countLabel.accessibilityLabel = .accessibilityLabelDisplayCount(text: newValue)
        }
    }

    /// The count attributedText of the rating. Displayed to the right of the stars/value.
    /// Text can be nil, in this case, no text is displayed.
    ///
    /// Also set the accessibilityLabel with the localized string.
    /// Update the accessibilityLabel in ``countLabel`` to override this value.
    public var attributedCountText: NSAttributedString? {
        get {
            self.countLabel.attributedText
        }
        set {
            self.countLabel.attributedText(newValue)
            self.countLabel.accessibilityLabel = .accessibilityLabelDisplayCount(text: newValue?.string)
        }
    }

    /// The additional information text of the rating. Displayed to the right of the stars/value/count.
    /// Text can be nil, in this case, no text is displayed.
    public var additionalText: String? {
        get {
            self.additionalLabel.text
        }
        set {
            self.additionalLabel.text(newValue)
        }
    }

    /// The additional information attributedText  of the rating. Displayed to the right of the stars/value/count.
    /// Text can be nil, in this case, no text is displayed.
    public var attributedAdditionalText: NSAttributedString? {
        get {
            self.additionalLabel.attributedText
        }
        set {
            self.additionalLabel.attributedText(newValue)
        }
    }

    public override var accessibilityLabel: String? {
        get {
            if let customAccessibilityLabel {
                return customAccessibilityLabel
            } else {
                return [
                    self.textLabel.accessibilityLabel,
                    self.countLabel.accessibilityLabel,
                    self.additionalLabel.accessibilityLabel
                ].compactMap { $0 }
                    .joined(separator: ",")
            }
        }
        set {
            self.customAccessibilityLabel = newValue
        }
    }

    // MARK: - Private Properties

    private let viewModel = XXXViewModel()

    private var subscriptions = Set<AnyCancellable>()

    private var customAccessibilityLabel: String?

    @LimitedScaledUIMetric private var contentSpacing: CGFloat = 0

    // MARK: - Initialization

    /// Create a rating display.
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///
    /// Implementation example :
    /// ```swift
    /// let theme: SparkTheming.Theme = MyTheme()
    ///
    /// let ratingDisplay = SparkUIXXX(theme: theme)
    /// ratingDisplay.value = 3.76
    /// ratingDisplay.size = .large
    /// ratingDisplay.stars = .one
    /// ratingDisplay.text = "(3,76)"
    /// self.addSubview(ratingDisplay)
    /// ```
    ///
    /// ## Rendering
    ///
    /// ![XXX rendering.](rating_display_default.png)
    public init(theme: any Theme) {
        self.theme = theme

        super.init(frame: .zero)

        // Setup
        self.setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    func setupView() {
        // Add subviews
        self.addSubview(self.contentStackView)

        // View properties
        self.backgroundColor = .clear

        // Updates UI
        self.updateSpacing()

        // Setup constraints
        self.setupConstraints()

        // Setup subscriptions
        self.setupSubscriptions()

        // Setup Accessibility
        self.setupAccessibility()

        // Load view model
        self.viewModel.setup(
            theme: self.theme,
            size: self.size
        )
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setupContentViewConstraints()
    }

    private func setupContentViewConstraints() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self
        )
    }

    // MARK: - Accessibility

    private func setupAccessibility() {
        self.isAccessibilityElement = true
        self.accessibilityIdentifier = XXXAccessibilityIdentifier.view
        self.updateAccessibilityValue()
    }

    private func updateAccessibilityValue() {
        self.accessibilityValue = String.accessibilityValue(
            rating: self.value,
            numberOfStars: self.stars.rawValue
        )
    }

    // MARK: - Update UI

    private func updateSpacing() {
        self.contentStackView.spacing = self.contentSpacing
    }

    // MARK: - Subscribe

    func setupSubscriptions() {
        // Colors
        self.viewModel.$colors.subscribe(in: &self.subscriptions) { [weak self] colors in
            guard let self else { return }

            self.starsStackView.colors = colors
        }

        // Spacings
        self.viewModel.$spacings.subscribe(in: &self.subscriptions) { [weak self] spacings in
            guard let self else { return }

            self._contentSpacing = .init(wrappedValue: spacings.content)
            self._contentSpacing.update(traitCollection: self.traitCollection)

            self.starsStackView.contentSpacing = spacings.stars

            self.updateSpacing()
        }

        // TextStyle
        self.viewModel.$textStyles.subscribe(in: &self.subscriptions) { [weak self] textStyles in
            guard let self else { return }

            self.textLabel.applyTextStyle(textStyles.value)
            self.countLabel.applyTextStyle(textStyles.count)
            self.additionalLabel.applyTextStyle(textStyles.additional)
        }
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._contentSpacing.update(traitCollection: self.traitCollection)
        self.updateSpacing()
    }
}

// MARK: - Extension

private extension UILabel {

    func applyStyles() {
        self.numberOfLines = 1
        self.lineBreakMode = .byTruncatingTail
        self.adjustsFontForContentSizeCategory = true
        self.accessibilityIdentifier = XXXAccessibilityIdentifier.text
        self.setContentCompressionResistancePriority(
            .required,
            for: .vertical
        )
        self.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        self.isHidden = true
    }

    func applyTextStyle(_ textStyle: XXXTextStyle) {
        self.textColor(textStyle.colorToken)
        self.font(textStyle.fontToken)
    }
}
