//
//  ButtonUIView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// The UIKit version for the button.
public final class ButtonUIView: UIControl {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ButtonAccessibilityIdentifier
    private typealias Animation = ButtonConstants.Animation

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.iconView,
                    self.titleLabel
                ]
        )
        stackView.axis = .horizontal
        stackView.accessibilityIdentifier = AccessibilityIdentifier.contentStackView
        return stackView
    }()

    private lazy var iconView: UIView = {
        let view = UIView()
        view.addSubview(self.iconImageView)
        view.accessibilityIdentifier = AccessibilityIdentifier.icon
        view.setContentCompressionResistancePriority(.required,
                                                     for: .vertical)
        view.setContentCompressionResistancePriority(.required,
                                                     for: .horizontal)
        return view
    }()

    private var iconImageView: UIControlStateImageView = {
        let imageView = UIControlStateImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = AccessibilityIdentifier.iconImage
        return imageView
    }()

    private var titleLabel: UIControlStateLabel = {
        let label = UIControlStateLabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = AccessibilityIdentifier.text
        label.lineBreakMode = .byTruncatingMiddle
        return label
    }()

    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.isAccessibilityElement = false
        button.addTarget(self, action: #selector(self.touchUpInsideAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.touchDownAction), for: .touchDown)
        button.addTarget(self, action: #selector(self.touchUpOutsideAction), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.touchCancelAction), for: .touchCancel)
        button.accessibilityIdentifier = AccessibilityIdentifier.clearButton
        return button
    }()

    // MARK: - Public Properties

    /// The delegate used to notify about some changed on button.
    public weak var delegate: ButtonUIViewDelegate?

    /// The tap publisher. Alternatively, you can set a delegate.
    public var tapPublisher: UIControl.EventPublisher {
        return self.clearButton.publisher(for: .touchUpInside)
    }

    /// Publishes when a touch was cancelled (e.g. by the system).
    public var touchCancelPublisher: UIControl.EventPublisher {
        return self.clearButton.publisher(for: .touchCancel)
    }

    /// Publishes when a touch was started but the touch ended outside of the button view bounds.
    public var touchUpOutsidePublisher: UIControl.EventPublisher {
        return self.clearButton.publisher(for: .touchUpOutside)
    }

    /// Publishes instantly when the button is touched down.
    /// - warning: This should not trigger a user action and should only be used for things like tracking.
    public var touchDownPublisher: UIControl.EventPublisher {
        return self.clearButton.publisher(for: .touchDown)
    }

    /// The spark theme of the button.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    /// The intent of the button.
    public var intent: ButtonIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.set(intent: newValue)
        }
    }

    /// The variant of the button.
    public var variant: ButtonVariant {
        get {
            return self.viewModel.variant
        }
        set {
            self.viewModel.set(variant: newValue)
        }
    }

    /// The size of the button.
    public var size: ButtonSize {
        get {
            return self.viewModel.size
        }
        set {
            self.viewModel.set(size: newValue)
        }
    }

    /// The shape of the button.
    public var shape: ButtonShape {
        get {
            return self.viewModel.shape
        }
        set {
            self.viewModel.set(shape: newValue)
        }
    }

    /// The alignment of the button.
    public var alignment: ButtonAlignment {
        get {
            return self.viewModel.alignment
        }
        set {
            self.viewModel.set(alignment: newValue)
        }
    }

    /// The icon image of the button.
    @available(*, deprecated, message: "Use setImage(_:, for:) and image(for:) instead")
    public var iconImage: UIImage? {
        get {
            return self.image(for: .normal)
        }
        set {
            self.setImage(newValue, for: .normal)
        }
    }

    /// The text of the button.
    @available(*, deprecated, message: "Use setTitle(_:, for:) and title(for:) instead")
    public var text: String? {
        get {
            return self.title(for: .normal)
        }
        set {
            self.setTitle(newValue, for: .normal)
        }
    }

    /// The attributed text of the button.
    @available(*, deprecated, message: "Use setAttributedTitle(_:, for:) and attributedTitle(for:) instead")
    public var attributedText: NSAttributedString? {
        get {
            return self.attributedTitle(for: .normal)
        }
        set {
            self.setAttributedTitle(newValue, for: .normal)
        }
    }

    /// The lineBreakMode for the text of the button.
    /// The default value is **byTruncatingTail**
    public var lineBreakMode: NSLineBreakMode {
        get {
            return self.titleLabel.lineBreakMode
        }
        set {
            self.titleLabel.lineBreakMode = newValue
        }
    }

    /// A Boolean value indicating whether the button is in the enabled state.
    public override var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            super.isEnabled = newValue
            self.viewModel.set(isEnabled: newValue)
            self.titleLabel.updateContent(from: self)
            self.iconImageView.updateContent(from: self)
        }
    }

    /// A Boolean value indicating whether the button is in the selected state.
    public override var isSelected: Bool {
        didSet {
            self.titleLabel.updateContent(from: self)
            self.iconImageView.updateContent(from: self)
        }
    }

    /// A Boolean value indicating whether the button draws a highlight.
    public override var isHighlighted: Bool {
        didSet {
            self.titleLabel.updateContent(from: self)
            self.iconImageView.updateContent(from: self)
        }
    }

    /// Button modifications should be animated or not. **True** by default.
    public var isAnimated: Bool = true

    // MARK: - Internal Properties

    internal let viewModel: ButtonViewModel

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?

    private var contentStackViewLeadingConstraint: NSLayoutConstraint?
    private var contentStackViewTopConstraint: NSLayoutConstraint?
    private var contentStackViewBottomConstraint: NSLayoutConstraint?

    private var iconImageViewHeightConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var height: CGFloat = 0
    @ScaledUIMetric private var verticalSpacing: CGFloat = 0
    @ScaledUIMetric private var horizontalSpacing: CGFloat = 0
    @ScaledUIMetric private var horizontalPadding: CGFloat = 0
    @ScaledUIMetric private var iconHeight: CGFloat = 0
    private var cornerRadius: CGFloat = 0

    private var firstContentStackViewAnimation: Bool = true
    private var firstContentStackViewSubviewAnimation: Bool = true

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initialize a new button view.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - isEnabled: The state of the button: enabled or not.
    public convenience init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        isEnabled: Bool
    ) {
        self.init(
            theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: nil,
            text: nil,
            attributedText: nil,
            isEnabled: isEnabled
        )
    }

    /// Initialize a new button view with a text.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - text: The text of the button.
    ///   - isEnabled: The state of the button: enabled or not.
    @available(*, deprecated, message: "Use init(theme: , intent: , variant: , size: , shape: , alignment: , isEnabled) instead")
    public convenience init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        text: String,
        isEnabled: Bool
    ) {
        self.init(
            theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: nil,
            text: text,
            attributedText: nil,
            isEnabled: isEnabled
        )
    }

    /// Initialize a new button view with an attributed text.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - attributedText: The attributed text of the button.
    ///   - isEnabled: The state of the button: enabled or not.
    @available(*, deprecated, message: "Use init(theme: , intent: , variant: , size: , shape: , alignment: , isEnabled) instead")
    public convenience init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        attributedText: NSAttributedString,
        isEnabled: Bool
    ) {
        self.init(
            theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: nil,
            text: nil,
            attributedText: attributedText,
            isEnabled: isEnabled
        )
    }

    /// Initialize a new button view with an icon image.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - iconImage: The icon image of the button.
    ///   - isEnabled: The state of the button: enabled or not.
    @available(*, deprecated, message: "Use init(theme: , intent: , variant: , size: , shape: , alignment: , isEnabled) instead")
    public convenience init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        iconImage: UIImage,
        isEnabled: Bool
    ) {
        self.init(
            theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: iconImage,
            text: nil,
            attributedText: nil,
            isEnabled: isEnabled
        )
    }

    /// Initialize a new button view with an icon image and a text.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - iconImage: The icon image of the button.
    ///   - text: The text of the button.
    ///   - isEnabled: The state of the button: enabled or not.
    @available(*, deprecated, message: "Use init(theme: , intent: , variant: , size: , shape: , alignment: , isEnabled) instead")
    public convenience init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        iconImage: UIImage,
        text: String,
        isEnabled: Bool
    ) {
        self.init(
            theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: iconImage,
            text: text,
            attributedText: nil,
            isEnabled: isEnabled
        )
    }

    /// Initialize a new button view with an icon image and an attributed text.
    /// - Parameters:
    ///   - theme: The spark theme of the button.
    ///   - intent: The intent of the button.
    ///   - variant: The variant of the button.
    ///   - size: The size of the button.
    ///   - shape: The shape of the button.
    ///   - alignment: The alignment of the button.
    ///   - iconImage: The icon image of the button.
    ///   - attributedText: The attributed text of the button.
    ///   - isEnabled: The state of the button: enabled or not.
    @available(*, deprecated, message: "Use init(theme: , intent: , variant: , size: , shape: , alignment: , isEnabled) instead")
    public convenience init(
        theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        iconImage: UIImage,
        attributedText: NSAttributedString,
        isEnabled: Bool
    ) {
        self.init(
            theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: iconImage,
            text: nil,
            attributedText: attributedText,
            isEnabled: isEnabled
        )
    }

    private init(
        _ theme: Theme,
        intent: ButtonIntent,
        variant: ButtonVariant,
        size: ButtonSize,
        shape: ButtonShape,
        alignment: ButtonAlignment,
        iconImage: UIImage?,
        text: String?,
        attributedText: NSAttributedString?,
        isEnabled: Bool
    ) {
        self.viewModel = .init(
            theme: theme,
            intent: intent,
            variant: variant,
            size: size,
            shape: shape,
            alignment: alignment,
            iconImage: iconImage.map { .left($0) },
            title: text,
            attributedTitle: attributedText.map { .left($0) },
            isEnabled: isEnabled)

        super.init(frame: .zero)

        // Setup
        self.setupView()
        self.setupProperties(
            text: text,
            attributedText: attributedText
        )
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - View setup

    private func setupView() {
        self.accessibilityTraits = [.button]
        // Add subviews
        self.addSubview(self.contentStackView)
        self.addSubview(self.clearButton)

        // Needed values from viewModel (important for superview)
        self.height = self.viewModel.sizes?.height ?? 0

        // Setup constraints
        self.setupConstraints()

        // Setup publisher subcriptions
        self.setupSubscriptions()

        // Load view model
        self.viewModel.load()
    }

    private func setupProperties(
        text: String?,
        attributedText: NSAttributedString?
    ) {
        // Accessibility Identifier
        self.accessibilityIdentifier = AccessibilityIdentifier.view

        // Label
        // Only one of the text/attributedText can be set in the init
        if let text {
            self.titleLabel.text = text
        } else if let attributedText {
            self.titleLabel.attributedText = attributedText
        }
    }

    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.updateBorderRadius()
    }

    // MARK: - Constraints

    private func setupConstraints() {
        self.setupViewConstraints()
        self.setupContentStackViewConstraints()
        self.setupIconViewConstraints()
        self.setupIconImageViewConstraints()
        self.setupClearButtonConstraints()
    }

    private func setupViewConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: self.height)
        self.heightConstraint?.isActive = true

        self.widthAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor).isActive = true
    }

    private func setupContentStackViewConstraints() {
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.contentStackViewLeadingConstraint = self.contentStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor)
        self.contentStackViewTopConstraint = self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let contentStackViewCenterXAnchor = self.contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        self.contentStackViewBottomConstraint = self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        NSLayoutConstraint.activate([
            self.contentStackViewLeadingConstraint,
            self.contentStackViewTopConstraint,
            contentStackViewCenterXAnchor,
            self.contentStackViewBottomConstraint,
        ].compactMap({ $0 }))
    }

    private func setupIconViewConstraints() {
        self.iconView.translatesAutoresizingMaskIntoConstraints = false
        self.iconView.widthAnchor.constraint(greaterThanOrEqualTo: self.iconImageView.widthAnchor).isActive = true
    }

    private func setupIconImageViewConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false

        self.iconImageViewHeightConstraint = self.iconImageView.heightAnchor.constraint(equalToConstant: self.iconHeight)
        self.iconImageViewHeightConstraint?.isActive = true

        self.iconImageView.widthAnchor.constraint(equalTo: self.iconImageView.heightAnchor).isActive = true
        self.iconImageView.centerXAnchor.constraint(equalTo: self.iconView.centerXAnchor).isActive = true
        self.iconImageView.centerYAnchor.constraint(equalTo: self.iconView.centerYAnchor).isActive = true
    }

    private func setupClearButtonConstraints() {
        self.clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.stickEdges(from: self.clearButton, to: self)
    }

    // MARK: - Setter & Getter

    /// The image of the button for a state.
    /// - parameter state: state of the image
    public func image(for state: ControlState) -> UIImage? {
        return self.iconImageView.image(for: state)
    }

    /// Set the image of the button for a state.
    /// - parameter image: new image of the button
    /// - parameter state: state of the image
    public func setImage(_ image: UIImage?, for state: ControlState) {
        if state == .normal {
            self.viewModel.set(iconImage: image.map { .left($0) })
        }

        self.iconImageView.setImage(image, for: state, on: self)
    }

    /// The title of the button for a state.
    /// - parameter state: state of the title
    public func title(for state: ControlState) -> String? {
        return self.titleLabel.text(for: state)
    }

    /// Set the title of the button for a state.
    /// - parameter title: new title of the button
    /// - parameter state: state of the title
    public func setTitle(_ title: String?, for state: ControlState) {
        if state == .normal {
            self.viewModel.set(title: title)
        }

        self.titleLabel.setText(title, for: state, on: self)
    }

    /// The title of the button for a state.
    /// - parameter state: state of the title
    public func attributedTitle(for state: ControlState) -> NSAttributedString? {
        return self.titleLabel.attributedText(for: state)
    }

    /// Set the attributedTitle of the button for a state.
    /// - parameter attributedTitle: new attributedTitle of the button
    /// - parameter state: state of the attributedTitle
    public func setAttributedTitle(_ attributedTitle: NSAttributedString?, for state: ControlState) {
        if state == .normal {
            self.viewModel.set(attributedTitle: attributedTitle.map { .left($0) })
        }

        self.titleLabel.setAttributedText(attributedTitle, for: state, on: self)
    }

    // MARK: - Update UI

    private func updateBorderRadius() {
        self.setCornerRadius(self.cornerRadius)
    }

    private func updateHeight() {
        // Reload height only if value changed
        if self.heightConstraint?.constant != self.height {
            self.heightConstraint?.constant = self.height
            self.updateConstraintsIfNeeded()
        }
    }

    private func updateSpacings() {
        // Reload spacing only if value changed
        let verticalSpacing = self._verticalSpacing.wrappedValue
        let horizontalSpacing = self._horizontalSpacing.wrappedValue
        let horizontalPadding = self._horizontalPadding.wrappedValue

        if verticalSpacing != self.contentStackViewTopConstraint?.constant ||
            horizontalSpacing != self.contentStackViewLeadingConstraint?.constant ||
            horizontalPadding != self.contentStackView.spacing {

            let isAnimated = self.isAnimated && !self.firstContentStackViewAnimation
            let animationType: UIExecuteAnimationType = isAnimated ? .animated(duration: Animation.slowDuration) : .unanimated

            UIView.execute(animationType: animationType) { [weak self] in
                guard let self else { return }

                self.firstContentStackViewAnimation = false

                self.contentStackViewLeadingConstraint?.constant = horizontalSpacing
                self.contentStackViewTopConstraint?.constant = verticalSpacing
                self.contentStackViewBottomConstraint?.constant = -verticalSpacing
                self.contentStackView.updateConstraintsIfNeeded()

                self.contentStackView.spacing = horizontalPadding
            }
        }
    }

    private func updateIconHeight() {
        // Reload height only if value changed
        if self.iconImageViewHeightConstraint?.constant != self.iconHeight {
            self.iconImageViewHeightConstraint?.constant = self.iconHeight
            self.iconImageView.updateConstraintsIfNeeded()
        }
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // **
        // State
        self.viewModel.$state.subscribe(in: &self.subscriptions) { [weak self] state in
            guard let self, let state else { return }

            // Update the user interaction enabled
            self.clearButton.isUserInteractionEnabled = state.isUserInteractionEnabled
            if !state.isUserInteractionEnabled {
                self.accessibilityTraits.insert(.notEnabled)
            } else {
                self.accessibilityTraits.remove(.notEnabled)
            }

            // Animate only if new alpha is different from current alpha
            let alpha = state.opacity

            let isAnimated = self.isAnimated && self.alpha != alpha
            let animationType: UIExecuteAnimationType = isAnimated ? .animated(duration: Animation.slowDuration) : .unanimated

            UIView.execute(animationType: animationType) { [weak self] in
                self?.alpha = alpha
            }
        }
        // **

        // **
        // Colors
        self.viewModel.$currentColors.subscribe(in: &self.subscriptions) { [weak self] colors in
            guard let self, let colors else { return }

            // Background Color
            let isAnimated = self.isAnimated && self.backgroundColor != colors.backgroundColor.uiColor
            let animationType: UIExecuteAnimationType = isAnimated ? .animated(duration: Animation.fastDuration) : .unanimated
            
            UIView.execute(animationType: animationType) { [weak self] in
                self?.backgroundColor = colors.backgroundColor.uiColor
            }

            // Border Color
            self.setBorderColor(from: colors.borderColor)

            // Foreground Color
            self.iconImageView.tintColor = colors.iconTintColor.uiColor
            if let titleColor = colors.titleColor {
                self.titleLabel.textColor = titleColor.uiColor
            }
        }

        // **
        // Sizes
        self.viewModel.$sizes.subscribe(in: &self.subscriptions) { [weak self] sizes in
            guard let self, let sizes else { return }

            // Height
            self.height = sizes.height
            self._height.update(traitCollection: self.traitCollection)
            self.updateHeight()

            // Icon size
            self.iconHeight = sizes.iconSize
            self._iconHeight.update(traitCollection: self.traitCollection)
            self.updateIconHeight()
        }
        // **

        // **
        // Border
        self.viewModel.$border.subscribe(in: &self.subscriptions) { [weak self] border in
            guard let self, let border else { return }

            // Radius
            self.cornerRadius = border.radius
            self.updateBorderRadius()

            // Width
            self.setBorderWidth(border.width)
        }
        // **

        // **
        // Spacings
        self.viewModel.$spacings.subscribe(in: &self.subscriptions) { [weak self] spacings in
            guard let self, let spacings else { return }

            self.verticalSpacing = spacings.verticalSpacing
            self._verticalSpacing.update(traitCollection: self.traitCollection)

            self.horizontalSpacing = spacings.horizontalSpacing
            self._horizontalSpacing.update(traitCollection: self.traitCollection)

            self.horizontalPadding = spacings.horizontalPadding
            self._horizontalPadding.update(traitCollection: self.traitCollection)

            self.updateSpacings()
        }
        // **

        // **
        // Content
        self.viewModel.$content.subscribe(in: &self.subscriptions) { [weak self] content in
            guard let self, let content else { return }

            // Icon ImageView
            self.iconImageView.image = content.iconImage?.leftValue

            // Subviews positions and visibilities
            let isAnimated = self.isAnimated && !self.firstContentStackViewSubviewAnimation
            let animationType: UIExecuteAnimationType = isAnimated ? .animated(duration: Animation.slowDuration) : .unanimated

            UIView.execute(animationType: animationType) { [weak self] in
                guard let self else { return }

                self.firstContentStackViewSubviewAnimation = false

                if self.iconView.isHidden == content.shouldShowIconImage {
                    self.iconView.isHidden = !content.shouldShowIconImage
                }

                if self.titleLabel.isHidden == content.shouldShowTitle {
                    self.titleLabel.isHidden = !content.shouldShowTitle
                }
                self.contentStackView.updateConstraintsIfNeeded()
            }

            // Position
            self.contentStackView.semanticContentAttribute = content.isIconImageTrailing ? .forceRightToLeft : .forceLeftToRight
        }
        // **

        // **
        // Title Font
        self.viewModel.$titleFontToken.subscribe(in: &self.subscriptions) { [weak self] titleFontToken in
            guard let self, let titleFontToken else { return }

            self.titleLabel.font = titleFontToken.uiFont
        }
        // **
    }

    // MARK: - Actions

    @objc private func touchUpInsideAction() {
        self.isHighlighted = false

        self.unpressedAction()

        self.delegate?.button(self, didReceive: .touchUpInside)
        self.delegate?.buttonWasTapped(self)
        self.sendActions(for: .touchUpInside)
    }

    @objc private func touchDownAction() {
        self.isHighlighted = true

        self.viewModel.pressedAction()

        self.delegate?.button(self, didReceive: .touchDown)
        self.sendActions(for: .touchDown)
    }

    @objc private func touchUpOutsideAction() {
        self.isHighlighted = false

        self.unpressedAction()

        self.delegate?.button(self, didReceive: .touchUpOutside)
        self.sendActions(for: .touchUpOutside)
    }

    @objc private func touchCancelAction() {
        self.isHighlighted = false

        self.unpressedAction()

        self.delegate?.button(self, didReceive: .touchCancel)
        self.sendActions(for: .touchCancel)
    }

    private func unpressedAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Animation.fastDuration, execute: { [weak self] in
            self?.viewModel.unpressedAction()
        })
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Update heights
        self._height.update(traitCollection: self.traitCollection)
        self.updateHeight()
        self._iconHeight.update(traitCollection: self.traitCollection)
        self.updateIconHeight()

        // Update spacings
        self._verticalSpacing.update(traitCollection: self.traitCollection)
        self._horizontalSpacing.update(traitCollection: self.traitCollection)
        self._horizontalPadding.update(traitCollection: self.traitCollection)
        self.updateSpacings()
    }
}
