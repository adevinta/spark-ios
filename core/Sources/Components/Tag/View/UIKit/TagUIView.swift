//
//  TagUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 17/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// The UIKit version for the tag.
public final class TagUIView: UIView {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = TagAccessibilityIdentifier

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [
                                            self.iconImageView,
                                            self.textLabel
                                        ])
        stackView.axis = .horizontal
        return stackView
    }()

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = AccessibilityIdentifier.iconImage
        return imageView
    }()

    private var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = AccessibilityIdentifier.text
        return label
    }()

    // MARK: - Public Properties

    /// The spark theme of the tag.
    public var theme: Theme {
        didSet {
            self._colors = self.getColorsFromUseCase()
            self.reloadUIFromTheme()
            self.reloadUIFromSpacing()
        }
    }

    /// The intentColor of the tag.
    public var intentColor: TagIntentColor {
        didSet {
            self._colors = self.getColorsFromUseCase()
        }
    }

    /// The variant of the tag.
    public var variant: TagVariant {
        didSet {
            self._colors = self.getColorsFromUseCase()
        }
    }

    /// The icon image of the tag.
    /// Image can be nil, in this case, no image is displayed.
    /// If image is nil, **you must add a text**.
    public var iconImage: UIImage? {
        didSet {
            self.reloadIconImageView()
        }
    }

    /// The text of the tag.
    /// Text can be nil, in this case, no text is displayed.
    /// If text is nil, **you must add a iconImage**.
    public var text: String? {
        didSet {
            self.reloadTextLabel()
        }
    }

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?

    private var contentStackViewLeadingConstraint: NSLayoutConstraint?
    private var contentStackViewTopConstraint: NSLayoutConstraint?
    private var contentStackViewTrailingConstraint: NSLayoutConstraint?
    private var contentStackViewBottomConstraint: NSLayoutConstraint?

    private var height: CGFloat = TagConstants.height
    @ScaledUIMetric private var smallSpacing: CGFloat = 0
    @ScaledUIMetric private var mediumSpacing: CGFloat = 0

    private var _colors: TagColorables? {
        didSet {
            self.reloadUIFromColors()
        }
    }
    private var colors: TagColorables {
        // Init value from use case only if value is nil
        guard let colors = self._colors else {
            let colors = self.getColorsFromUseCase()
            self._colors = colors
            return colors
        }

        return colors
    }

    private let getColorsUseCase: TagGetColorsUseCaseable

    // MARK: - Initialization

    /// Initialize a new tag view with icon image.
    /// - Parameters:
    ///   - theme: The spark theme.
    ///   - intentColor: The intentColor of the tag.
    ///   - variant: The variant of the tag.
    ///   - iconImage: The icon image of the tag.
    public convenience init(theme: Theme,
                            intentColor: TagIntentColor,
                            variant: TagVariant,
                            iconImage: UIImage) {
        self.init(theme,
                  intentColor: intentColor,
                  variant: variant,
                  iconImage: iconImage,
                  text: nil)
    }

    /// Initialize a new tag view with text.
    /// - Parameters:
    ///   - theme: The spark theme.
    ///   - intentColor: The intentColor of the tag.
    ///   - variant: The variant of the tag.
    ///   - text: The text of the tag.
    public convenience init(theme: Theme,
                            intentColor: TagIntentColor,
                            variant: TagVariant,
                            text: String) {
        self.init(theme,
                  intentColor: intentColor,
                  variant: variant,
                  iconImage: nil,
                  text: text)
    }

    /// Initialize a new tag view with icon image and text.
    /// - Parameters:
    ///   - theme: The spark theme.
    ///   - intentColor: The intentColor of the tag.
    ///   - variant: The variant of the tag.
    ///   - iconImage: The icon image of the tag.
    ///   - text: The text of the tag.
    public convenience init(theme: Theme,
                            intentColor: TagIntentColor,
                            variant: TagVariant,
                            iconImage: UIImage,
                            text: String) {
        self.init(theme,
                  intentColor: intentColor,
                  variant: variant,
                  iconImage: iconImage,
                  text: text)
    }

    private init(_ theme: Theme,
                 intentColor: TagIntentColor,
                 variant: TagVariant,
                 iconImage: UIImage?,
                 text: String?,
                 getColorsUseCase: TagGetColorsUseCaseable = TagGetColorsUseCase()) {
        self.theme = theme
        self.intentColor = intentColor
        self.variant = variant
        self.iconImage = iconImage
        self.text = text
        self.getColorsUseCase = getColorsUseCase

        super.init(frame: .zero)

        self.setupView()
        self.loadUI()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    private func setupView() {
        // Add subview
        self.addSubview(self.contentStackView)

        // Setup constraints
        self.setupConstraints()
    }

    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.setCornerRadius(self.theme.border.radius.full)
    }

    // MARK: - Load UI

    private func loadUI() {
        self.reloadIconImageView()
        self.reloadTextLabel()
        self.reloadUIFromTheme()
        self.reloadUIFromColors()
        self.reloadUIFromSize()
    }

    private func reloadIconImageView() {
        self.iconImageView.image = self.iconImage
        self.iconImageView.isHidden = (self.iconImage == nil)
    }

    private func reloadTextLabel() {
        self.textLabel.text = self.text
        self.textLabel.isHidden = (self.text == nil)
    }

    private func reloadUIFromTheme() {
        // Spacing
        self.smallSpacing = self.theme.layout.spacing.small
        self._smallSpacing.update(traitCollection: self.traitCollection)
        self.mediumSpacing = self.theme.layout.spacing.medium
        self._mediumSpacing.update(traitCollection: self.traitCollection)

        // View
        self.setBorderWidth(self.theme.border.width.small)
        self.setMasksToBounds(true)

        // Subviews
        self.textLabel.font = self.theme.typography.captionHighlight.uiFont
    }

    private func reloadUIFromColors() {
        // View
        self.backgroundColor = self.colors.backgroundColor.uiColor
        self.setBorderColor(from: self.colors.borderColor)

        // Subviews
        self.iconImageView.tintColor = self.colors.foregroundColor.uiColor
        self.textLabel.textColor = self.colors.foregroundColor.uiColor
    }

    private func reloadUIFromSize() {
        self.reloadUIFromHeight()
        self.reloadUIFromSpacing()
    }

    private func reloadUIFromHeight() {
        // Reload height only if value changed
        if self.height != self.heightConstraint?.constant {
            self.heightConstraint?.constant = self.height
            self.layoutIfNeeded()
        }
    }

    private func reloadUIFromSpacing() {
        self.reloadUIFromSmallSpacing()
        self.reloadUIFromMediumSpacing()
    }

    private func reloadUIFromSmallSpacing() {
        // Reload spacing only if value changed
        let smallSpacing = self._smallSpacing.wrappedValue
        if smallSpacing != self.contentStackViewTopConstraint?.constant {
            // Subviews
            self.contentStackView.spacing = smallSpacing

            // Constraint
            self.contentStackViewTopConstraint?.constant = smallSpacing
            self.contentStackViewBottomConstraint?.constant = -smallSpacing
            self.contentStackView.layoutIfNeeded()
        }
    }

    private func reloadUIFromMediumSpacing() {
        // Reload spacing only if value changed
        let mediumSpacing = self._mediumSpacing.wrappedValue
        if mediumSpacing != self.contentStackViewLeadingConstraint?.constant {
            self.contentStackViewLeadingConstraint?.constant = mediumSpacing
            self.contentStackViewTrailingConstraint?.constant = -mediumSpacing
            self.contentStackView.layoutIfNeeded()
        }
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.setupViewConstraints()
        self.setupContentStackViewConstraints()
        self.setupIconImageViewConstraints()
    }

    private func setupViewConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: self.height)
        self.heightConstraint?.isActive = true
    }

    private func setupContentStackViewConstraints() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.contentStackViewLeadingConstraint = self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        self.contentStackViewTopConstraint = self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor)
        self.contentStackViewTrailingConstraint = self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        self.contentStackViewBottomConstraint = self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        self.contentStackViewLeadingConstraint?.isActive = true
        self.contentStackViewTopConstraint?.isActive = true
        self.contentStackViewTrailingConstraint?.isActive = true
        self.contentStackViewBottomConstraint?.isActive = true
    }

    private func setupIconImageViewConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.widthAnchor.constraint(equalTo: self.contentStackView.heightAnchor).isActive = true
    }

    // MARK: - Getter

    private func getColorsFromUseCase() -> TagColorables {
        return self.getColorsUseCase.execute(from: self.theme,
                                             intentColor: self.intentColor,
                                             variant: self.variant)
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Reload colors ?
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.reloadUIFromColors()
        }

        // **
        // Update content size ?
        self.height = UIFontMetrics.default.scaledValue(
            for: TagConstants.height,
            compatibleWith: self.traitCollection
        )
        self._smallSpacing.update(traitCollection: self.traitCollection)
        self._mediumSpacing.update(traitCollection: self.traitCollection)
        self.reloadUIFromSize()
        // **
    }
}
