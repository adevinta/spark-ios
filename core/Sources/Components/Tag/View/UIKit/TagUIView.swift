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
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.iconStackView,
                    self.textLabel
                ])
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.topIconSpaceView,
                    self.iconImageView,
                    self.bottomIconSpaceView
                ])
        stackView.axis = .vertical
        return stackView
    }()

    private let topIconSpaceView = UIView()

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = AccessibilityIdentifier.iconImage
        imageView.setContentCompressionResistancePriority(.required,
                                                          for: .vertical)
        imageView.setContentCompressionResistancePriority(.required,
                                                          for: .horizontal)
        return imageView
    }()

    private let bottomIconSpaceView = UIView()

    private var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = AccessibilityIdentifier.text
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        label.setContentCompressionResistancePriority(.required,
                                                      for: .horizontal)
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

    /// The intent of the tag.
    public var intent: TagIntent {
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
    private var contentStackViewTrailingConstraint: NSLayoutConstraint?

    private var topIconSpaceViewTopConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var height: CGFloat = TagConstants.height
    @ScaledUIMetric private var iconVerticalSpacing: CGFloat = 0
    @ScaledUIMetric private var contentHorizontalSpacing: CGFloat = 0

    private var _colors: TagColors? {
        didSet {
            self.reloadUIFromColors()
        }
    }
    private var colors: TagColors {
        // Init value from use case only if value is nil
        guard let colors = self._colors else {
            let colors = self.getColorsFromUseCase()
            self._colors = colors
            return colors
        }

        return colors
    }

    private let getColorsUseCase: any TagGetColorsUseCaseable

    // MARK: - Initialization

    /// Initialize a new tag view with icon image.
    /// - Parameters:
    ///   - theme: The spark theme of the tag.
    ///   - intent: The intent of the tag.
    ///   - variant: The variant of the tag.
    ///   - iconImage: The icon image of the tag.
    public convenience init(theme: Theme,
                            intent: TagIntent,
                            variant: TagVariant,
                            iconImage: UIImage) {
        self.init(theme,
                  intent: intent,
                  variant: variant,
                  iconImage: iconImage,
                  text: nil)
    }

    /// Initialize a new tag view with text.
    /// - Parameters:
    ///   - theme: The spark theme of the tag.
    ///   - intent: The intent of the tag.
    ///   - variant: The variant of the tag.
    ///   - text: The text of the tag.
    public convenience init(theme: Theme,
                            intent: TagIntent,
                            variant: TagVariant,
                            text: String) {
        self.init(theme,
                  intent: intent,
                  variant: variant,
                  iconImage: nil,
                  text: text)
    }

    /// Initialize a new tag view with icon image and text.
    /// - Parameters:
    ///   - theme: The spark theme of the tag.
    ///   - intent: The intent of the tag.
    ///   - variant: The variant of the tag.
    ///   - iconImage: The icon image of the tag.
    ///   - text: The text of the tag.
    public convenience init(theme: Theme,
                            intent: TagIntent,
                            variant: TagVariant,
                            iconImage: UIImage,
                            text: String) {
        self.init(theme,
                  intent: intent,
                  variant: variant,
                  iconImage: iconImage,
                  text: text)
    }

    private init(_ theme: Theme,
                 intent: TagIntent,
                 variant: TagVariant,
                 iconImage: UIImage?,
                 text: String?,
                 getColorsUseCase: any TagGetColorsUseCaseable = TagGetColorsUseCase()) {
        self.theme = theme
        self.intent = intent
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
        self.iconStackView.isHidden = (self.iconImage == nil)
    }

    private func reloadTextLabel() {
        self.textLabel.text = self.text
        self.textLabel.isHidden = (self.text == nil)
    }

    private func reloadUIFromTheme() {
        // Spacing
        self.iconVerticalSpacing = self.theme.layout.spacing.small
        self._iconVerticalSpacing.update(traitCollection: self.traitCollection)
        self.contentHorizontalSpacing = self.theme.layout.spacing.medium
        self._contentHorizontalSpacing.update(traitCollection: self.traitCollection)

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
        self.reloadUIFromIconVerticalSpacing()
        self.reloadUIFromContentHorizontalSpacing()
    }

    private func reloadUIFromIconVerticalSpacing() {
        // Reload spacing only if value changed
        let iconVerticalSpacing = self._iconVerticalSpacing.wrappedValue
        if iconVerticalSpacing != self.topIconSpaceViewTopConstraint?.constant {
            // Subviews
            self.contentStackView.spacing = iconVerticalSpacing

            // Constraint
            self.topIconSpaceViewTopConstraint?.constant = iconVerticalSpacing
            self.topIconSpaceViewTopConstraint?.isActive = true
            self.updateConstraintsIfNeeded()
        }
    }

    private func reloadUIFromContentHorizontalSpacing() {
        // Reload spacing only if value changed
        let contentHorizontalSpacing = self._contentHorizontalSpacing.wrappedValue
        if contentHorizontalSpacing != self.contentStackViewLeadingConstraint?.constant {
            self.contentStackViewLeadingConstraint?.constant = contentHorizontalSpacing
            self.contentStackViewTrailingConstraint?.constant = -contentHorizontalSpacing
            self.contentStackView.layoutIfNeeded()
        }
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.setupViewConstraints()
        self.setupContentStackViewConstraints()
        self.setupIconSpaceViewsContraints()
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
        self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentStackViewTrailingConstraint = self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.contentStackViewLeadingConstraint?.isActive = true
        self.contentStackViewTrailingConstraint?.isActive = true
    }

    private func setupIconSpaceViewsContraints() {
        self.topIconSpaceView.translatesAutoresizingMaskIntoConstraints = false
        self.topIconSpaceViewTopConstraint = self.topIconSpaceView.heightAnchor.constraint(
            equalToConstant: self.iconVerticalSpacing
        )

        self.bottomIconSpaceView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomIconSpaceView.heightAnchor.constraint(equalTo: self.topIconSpaceView.heightAnchor).isActive = true
    }

    private func setupIconImageViewConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.widthAnchor.constraint(equalTo: self.iconImageView.heightAnchor).isActive = true
    }

    // MARK: - Getter

    private func getColorsFromUseCase() -> TagColors {
        return self.getColorsUseCase.execute(
            theme: self.theme,
            intent: self.intent,
            variant: self.variant
        )
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Reload colors ?
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.reloadUIFromColors()
        }

        // **
        // Update content size
        self._height.update(traitCollection: self.traitCollection)
        self._iconVerticalSpacing.update(traitCollection: self.traitCollection)
        self._contentHorizontalSpacing.update(traitCollection: self.traitCollection)
        self.reloadUIFromSize()
        // **
    }
}

// MARK: - Label priorities
public extension TagUIView {
    func setLabelContentCompressionResistancePriority(_ priority: UILayoutPriority,
                                                      for axis: NSLayoutConstraint.Axis) {
        self.textLabel.setContentCompressionResistancePriority(priority,
                                                               for: axis)
    }

    func setLabelContentHuggingPriority(_ priority: UILayoutPriority,
                                        for axis: NSLayoutConstraint.Axis) {
        self.textLabel.setContentHuggingPriority(priority,
                                                 for: axis)
    }
}
