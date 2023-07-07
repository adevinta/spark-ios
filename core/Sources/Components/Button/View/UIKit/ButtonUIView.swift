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
public final class ButtonUIView: UIView {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = ButtonAccessibilityIdentifier
    private typealias Constants = ButtonConstants

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.iconView,
                    self.textLabel
                ]
        )
        stackView.axis = .horizontal
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

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = AccessibilityIdentifier.iconImage
        return imageView
    }()

    private var textLabel: UILabel = {
        let label = UILabel()
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
    public var iconImage: UIImage? {
        get {
            return self.viewModel.iconImage?.leftValue
        }
        set {
            self.viewModel.set(iconImage: Self.getImageEither(from: newValue))
        }
    }

    /// The text of the button.
    public var text: String? {
        get {
            return self.textLabel.text
        }
        set {
            self.textLabel.text = newValue
            self.viewModel.set(text: newValue)
        }
    }

    /// The attributed text of the button.
    public var attributedText: NSAttributedString? {
        get {
            return self.textLabel.attributedText
        }
        set {
            self.textLabel.attributedText = newValue
            self.viewModel.set(attributedText: Self.getAttributedTextEither(from: newValue))
        }
    }

    /// The lineBreakMode for the text of the button.
    /// The default value is **byTruncatingTail**
    public var lineBreakMode: NSLineBreakMode {
        get {
            return self.textLabel.lineBreakMode
        }
        set {
            self.textLabel.lineBreakMode = newValue
        }
    }

    /// The state of the button: enabled or not.
    public var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.set(isEnabled: newValue)
        }
    }

    // MARK: - Internal Properties

    internal let viewModel: ButtonViewModel

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?

    private var contentStackViewLeadingConstraint: NSLayoutConstraint?
    private var contentStackViewTopConstraint: NSLayoutConstraint?
    private var contentStackViewTrailingConstraint: NSLayoutConstraint?
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
            iconImage: Self.getImageEither(from: iconImage),
            text: text,
            attributedText: Self.getAttributedTextEither(from: attributedText),
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
        // Add subviews
        self.addSubview(self.contentStackView)
        self.addSubview(self.clearButton)

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
        // Label
        // Only one of the text/attributedText can be set in the init
        if let text {
            self.textLabel.text = text
        } else if let attributedText {
            self.textLabel.attributedText = attributedText
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

        self.contentStackViewLeadingConstraint = self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        self.contentStackViewTopConstraint = self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor)
        self.contentStackViewTrailingConstraint = self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        self.contentStackViewBottomConstraint = self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        self.contentStackViewLeadingConstraint?.isActive = true
        self.contentStackViewTopConstraint?.isActive = true
        self.contentStackViewTrailingConstraint?.isActive = true
        self.contentStackViewBottomConstraint?.isActive = true
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

    // MARK: - Update UI

    private func updateBorderRadius() {
        self.setCornerRadius(self.cornerRadius)
    }

    private func updateHeight() {
        // Reload height only if value changed
        if self.heightConstraint?.constant != self.height {
            self.heightConstraint?.constant = self.height
            self.layoutIfNeeded()
        }
    }

    private func updateSpacings() {
        // Reload spacing only if value changed
        let verticalSpacing = self._verticalSpacing.wrappedValue
        let horizontalSpacing = self._horizontalSpacing.wrappedValue
        let horizontalPadding = self._horizontalPadding.wrappedValue

        let animationDuration = self.firstContentStackViewAnimation ? 0 : Constants.Animation.slowDuration
        if verticalSpacing != self.contentStackViewTopConstraint?.constant ||
            horizontalSpacing != self.contentStackViewLeadingConstraint?.constant ||
            horizontalPadding != self.contentStackView.spacing {
            UIView.animate(withDuration: animationDuration) { [weak self] in
                guard let self else { return }

                self.firstContentStackViewAnimation = false

                self.contentStackViewLeadingConstraint?.constant = horizontalSpacing
                self.contentStackViewTopConstraint?.constant = verticalSpacing
                self.contentStackViewTrailingConstraint?.constant = -horizontalSpacing
                self.contentStackViewBottomConstraint?.constant = -verticalSpacing
                self.contentStackView.layoutIfNeeded()

                self.contentStackView.spacing = horizontalPadding
            }
        }
    }

    private func updateIconHeight() {
        // Reload height only if value changed
        if self.iconImageViewHeightConstraint?.constant != self.iconHeight {
            self.iconImageViewHeightConstraint?.constant = self.iconHeight
            self.iconImageView.layoutIfNeeded()
        }
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // **
        // State
        self.subscribeTo(self.viewModel.$state) { [weak self] state in
            guard let self, let state else { return }

            // Update the user interaction enabled
            self.clearButton.isUserInteractionEnabled = state.isInteractionEnabled

            // Animate only if new alpha is different from current alpha
            let alpha = state.opacity
            if self.alpha != alpha {
                UIView.animate(withDuration: Constants.Animation.slowDuration) { [weak self] in
                    self?.alpha = alpha
                }
            } else {
                self.alpha = alpha
            }
        }
        // **

        // **
        // Colors
        self.subscribeTo(self.viewModel.$currentColors) { [weak self] colors in
            guard let self, let colors else { return }

            // Background Color
            if self.backgroundColor != colors.backgroundColor.uiColor {
                UIView.animate(withDuration: Constants.Animation.fastDuration) { [weak self] in
                    self?.backgroundColor = colors.backgroundColor.uiColor
                }
            } else {
                self.backgroundColor = colors.backgroundColor.uiColor
            }

            // Border Color
            self.setBorderColor(from: colors.borderColor)

            // Foreground Color
            self.iconImageView.tintColor = colors.foregroundColor.uiColor
            self.textLabel.textColor = colors.foregroundColor.uiColor
        }

        // **
        // Sizes
        self.subscribeTo(self.viewModel.$sizes) { [weak self] sizes in
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
        self.subscribeTo(self.viewModel.$border) { [weak self] border in
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
        self.subscribeTo(self.viewModel.$spacings) { [weak self] spacings in
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
        self.subscribeTo(self.viewModel.$content) { [weak self] content in
            guard let self, let content else { return }

            // Icon ImageView
            self.iconImageView.image = content.iconImage?.leftValue

            // Subviews positions and visibilities
            let animationDuration = self.firstContentStackViewSubviewAnimation ? 0 : Constants.Animation.slowDuration
            UIView.animate(withDuration: animationDuration) { [weak self] in
                guard let self else { return }

                self.firstContentStackViewSubviewAnimation = false

                if self.iconView.isHidden == content.shouldShowIconImage {
                    self.iconView.isHidden = !content.shouldShowIconImage
                }

                if self.textLabel.isHidden == content.shouldShowText {
                    self.textLabel.isHidden = !content.shouldShowText
                }
                self.contentStackView.layoutIfNeeded()
            }

            // Position
            self.contentStackView.semanticContentAttribute = content.isIconImageOnRight ? .forceRightToLeft : .forceLeftToRight
        }
        // **

        // **
        // Text Font
        self.subscribeTo(self.viewModel.$textFontToken) { [weak self] textFontToken in
            guard let self, let textFontToken else { return }

            self.textLabel.font = textFontToken.uiFont
        }
        // **
    }

    private func subscribeTo<Value>(_ publisher: some Publisher<Value, Never>, action: @escaping (Value) -> Void ) {
        publisher
            .receive(on: RunLoop.main)
            .sink { value in
                action(value)
            }
            .store(in: &self.subscriptions)
    }

    // MARK: - Actions

    @objc private func touchUpInsideAction() {
        self.unpressedAction()

        self.delegate?.button(self, didReceive: .touchUpInside)
        self.delegate?.buttonWasTapped(self)
    }

    @objc private func touchDownAction() {
        self.viewModel.pressedAction()
        self.delegate?.button(self, didReceive: .touchDown)
    }

    @objc private func touchUpOutsideAction() {
        self.unpressedAction()
        self.delegate?.button(self, didReceive: .touchUpOutside)
    }

    @objc private func touchCancelAction() {
        self.unpressedAction()
        self.delegate?.button(self, didReceive: .touchCancel)
    }

    private func unpressedAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.fastDuration, execute: { [weak self] in
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

    // MARK: - Either Getter

    private static func getImageEither(from value: UIImage?) -> ImageEither? {
        guard let value else {
            return nil
        }

        return .left(value)
    }

    private static func getAttributedTextEither(from value: NSAttributedString?) -> AttributedStringEither? {
        guard let value else {
            return nil
        }

        return .left(value)
    }
}
