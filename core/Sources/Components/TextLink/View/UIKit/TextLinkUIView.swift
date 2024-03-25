//
//  TextLinkUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

/// The UIKit version for the text link.
public final class TextLinkUIView: UIControl {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.imageContentStackView,
                    self.textLabel
                ]
        )
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.accessibilityIdentifier = TextLinkAccessibilityIdentifier.contentStackView
        stackView.isUserInteractionEnabled = false
        return stackView
    }()

    private lazy var imageContentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.imageTopSpaceView,
                    self.imageView,
                    self.imageBottomSpaceView,
                ]
        )
        stackView.axis = .vertical
        stackView.accessibilityIdentifier = TextLinkAccessibilityIdentifier.imageContentStackView
        return stackView
    }()

    private let imageTopSpaceView = UIView()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintAdjustmentMode = .normal
        imageView.accessibilityIdentifier = TextLinkAccessibilityIdentifier.image
        return imageView
    }()

    private let imageBottomSpaceView = UIView()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = self.numberOfLines
        label.lineBreakMode = self.lineBreakMode
        label.textAlignment = self.textAlignment
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = TextLinkAccessibilityIdentifier.text
        return label
    }()

    /// The tap publisher. Alternatively, you can use the native **action** (addAction) or **target** (addTarget).
    public var tapPublisher: UIControl.EventPublisher {
        return self.publisher(for: .touchUpInside)
    }

    // MARK: - Public Properties

    /// The spark theme of the text link.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    /// The text of the text link.
    public var text: String {
        get {
            return self.viewModel.text
        }
        set {
            self.viewModel.text = newValue
            self.accessibilityLabelManager.internalValue = newValue
        }
    }

    /// The intent of the text link.
    public var intent: TextLinkIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    /// The optional range to specify the highlighted part of the text link.
    public var textHighlightRange: NSRange? {
        get {
            return self.viewModel.textHighlightRange
        }
        set {
            self.viewModel.textHighlightRange = newValue
        }
    }

    /// The typography of the text link.
    public var typography: TextLinkTypography {
        get {
            return self.viewModel.typography
        }
        set {
            self.viewModel.typography = newValue
        }
    }

    /// The variant of the text link.
    public var variant: TextLinkVariant {
        get {
            return self.viewModel.variant
        }
        set {
            self.viewModel.variant = newValue
        }
    }

    /// The optional image of the text link.
    public var image: UIImage? {
        didSet {
            self.updateImage()
        }
    }

    /// The alignment of the text link.
    public var alignment: TextLinkAlignment {
        get {
            return self.viewModel.alignment
        }
        set {
            self.viewModel.alignment = newValue
        }
    }

    /// The text  alignment  of the textlink. Default is **.natural**.
    public var textAlignment: NSTextAlignment = .natural {
        didSet {
            self.textLabel.textAlignment = self.textAlignment
        }
    }

    /// The line break mode of the textlink. Default is **.byTruncatingTail**.
    public var lineBreakMode: NSLineBreakMode = .byTruncatingTail {
        didSet {
            self.textLabel.lineBreakMode = self.lineBreakMode
        }
    }

    /// The number of lines of the textlink. Default is **1**.
    public var numberOfLines: Int = 1 {
        didSet {
            self.textLabel.numberOfLines = self.numberOfLines
        }
    }

    /// A Boolean value indicating whether the text link draws a highlight.
    public override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            self.viewModel.isHighlighted = newValue
        }
    }

    public override var accessibilityLabel: String? {
        get {
            return self.accessibilityLabelManager.value
        }
        set {
            self.accessibilityLabelManager.value = newValue
        }
    }

    // MARK: - Private Properties

    private let viewModel: TextLinkViewModel

    private var imageTopSpaceViewConstraint: NSLayoutConstraint?
    private var imageViewHeightConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var contentStackViewSpacing: CGFloat = 0

    private var accessibilityLabelManager = AccessibilityLabelManager()

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initialize a new text link view.
    /// - Parameters:
    ///   - theme: The spark theme of the text link.
    ///   - text: The text of the text link.
    ///   - textHighlightRange: The optional range to specify the highlighted part of the text link.
    ///   - intent: The intent of the text link.
    ///   - typography: The typography of the text link.
    ///   - variant: The variant of the text link.
    ///   - image: The optional image of the text link..
    ///   - alignment: The alignment of the content of the textlink: image on left or right of the text.
    public init(
        theme: any Theme,
        text: String,
        textHighlightRange: NSRange? = nil,
        intent: TextLinkIntent,
        typography: TextLinkTypography,
        variant: TextLinkVariant,
        image: UIImage? = nil,
        alignment: TextLinkAlignment = .leadingImage
    ) {
        self.viewModel = .init(
            for: .uiKit,
            theme: theme,
            text: text,
            textHighlightRange: textHighlightRange,
            intent: intent,
            typography: typography,
            variant: variant,
            alignment: alignment
        )

        self.image = image

        super.init(frame: .zero)

        // Setup
        self.setupView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    func setupView() {
        // Add subviews
        self.addSubview(self.contentStackView)

        // Accessibility
        self.accessibilityTraits = [.button]
        self.accessibilityIdentifier = TextLinkAccessibilityIdentifier.view
        self.isAccessibilityElement = true

        // View properties
        self.backgroundColor = .clear
        self.updateImage()

        // Setup constraints
        self.setupConstraints()

        // Setup gesture
        self.enableTouch()

        // Setup subscriptions
        self.setupSubscriptions()

        // Load view model
        self.viewModel.load()
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.setupViewConstraints()
        self.setupContentStackViewConstraints()
        self.setupImageSpaceViewsConstraints()
        self.setupImageViewConstraints()
    }

    private func setupViewConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupContentStackViewConstraints() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self,
            insets: .zero
        )
    }

    private func setupImageSpaceViewsConstraints() {
        self.imageTopSpaceView.translatesAutoresizingMaskIntoConstraints = false
        self.imageBottomSpaceView.translatesAutoresizingMaskIntoConstraints = false

        self.imageTopSpaceViewConstraint = self.imageTopSpaceView.heightAnchor.constraint(equalToConstant: .zero)
        self.imageTopSpaceViewConstraint?.isActive = true

        self.imageBottomSpaceView.heightAnchor.constraint(equalTo: self.imageTopSpaceView.heightAnchor).isActive = true
    }

    private func setupImageViewConstraints() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        self.imageViewHeightConstraint = self.imageView.widthAnchor.constraint(equalToConstant: .zero)
        self.imageViewHeightConstraint?.isActive = true

        self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor).isActive = true
    }

    // MARK: - Update UI

    private func updateImage() {
        self.imageContentStackView.isHidden = self.image == nil
        self.imageView.image = self.image
    }

    private func updateContentStackViewSpacing() {
        // Reload spacing only if value changed and constraint is active
        if self.contentStackViewSpacing != self.contentStackView.spacing {
            self.contentStackView.spacing = contentStackViewSpacing
            self.invalidateIntrinsicContentSize()
        }
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // Attributed Text
        self.viewModel.$attributedText.subscribe(in: &self.subscriptions) { [weak self] attributedText in
            guard let self, let attributedText else { return }

            self.textLabel.attributedText = attributedText.leftValue
        }

        // Spacing
        self.viewModel.$spacing.subscribe(in: &self.subscriptions) { [weak self] spacing in
            guard let self else { return }

            self.contentStackViewSpacing = spacing
            self._contentStackViewSpacing.update(traitCollection: self.traitCollection)

            self.updateContentStackViewSpacing()
        }

        // Image Size
        self.viewModel.$imageSize.subscribe(in: &self.subscriptions) { [weak self] imageSize in
            guard let self, let imageSize else { return }

            self.imageViewHeightConstraint?.constant = imageSize.size
            self.imageView.updateConstraintsIfNeeded()

            self.imageTopSpaceViewConstraint?.constant = imageSize.padding
            self.imageTopSpaceView.updateConstraintsIfNeeded()
        }

        // Image Tint Color
        self.viewModel.$imageTintColor.subscribe(in: &self.subscriptions) { [weak self] imageTintColor in
            guard let self else { return }

            self.imageView.tintColor = imageTintColor.uiColor
        }

        // Image Position
        self.viewModel.$isTrailingImage.subscribe(in: &self.subscriptions) { [weak self] isTrailingImage in
            guard let self else { return }

            self.contentStackView.semanticContentAttribute = isTrailingImage ? .forceRightToLeft : .forceLeftToRight
        }
    }

    // MARK: - Label priorities

    public func setLabelContentCompressionResistancePriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) {
        self.textLabel.setContentCompressionResistancePriority(priority, for: axis)
    }

    public func setLabelContentHuggingPriority(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) {
        self.textLabel.setContentHuggingPriority(priority, for: axis)
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Update spacings
        self._contentStackViewSpacing.update(traitCollection: self.traitCollection)
        self.updateContentStackViewSpacing()

        self.viewModel.contentSizeCategoryDidUpdate()
    }
}
