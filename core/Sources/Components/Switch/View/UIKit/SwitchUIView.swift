//
//  SwitchUIView.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

// TODO: Add Pressed state (rounded rect)

/// The delegate for the UIKit switch.
public protocol SwitchUIViewDelegate: AnyObject {
    /// When isOn value is changed
    /// - Parameters:
    ///   - switchView: The current switch view.
    ///   - isOn: The current value of the switch.
    func switchDidChange(_ switchView: SwitchUIView, isOn: Bool)
}

/// The UIKit version for the switch.
public final class SwitchUIView: UIView {

    // MARK: - Type alias

    private typealias AccessibilityIdentifier = SwitchAccessibilityIdentifier
    private typealias Constants = SwitchConstants

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.toggleView,
                    self.textLabel
                ]
        )
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.isBaselineRelativeArrangement = true

        return stackView
    }()

    private lazy var toggleView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = AccessibilityIdentifier.toggleView
        view.addSubview(self.toggleContentStackView)
        view.isUserInteractionEnabled = true
        view.setContentCompressionResistancePriority(.required,
                                                     for: .vertical)
        view.setContentCompressionResistancePriority(.required,
                                                     for: .horizontal)
        return view
    }()

    private lazy var toggleContentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    self.toggleLeftSpaceView,
                    self.toggleDotView,
                    self.toggleRightSpaceView
                ]
        )
        stackView.axis = .horizontal
        stackView.isUserInteractionEnabled = false
        return stackView
    }()

    private var toggleLeftSpaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var toggleDotView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = AccessibilityIdentifier.toggleDotView
        view.addSubview(self.toggleDotImageView)
        return view
    }()

    private var toggleDotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = AccessibilityIdentifier.toggleDotImageView
        return imageView
    }()

    private var toggleRightSpaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = AccessibilityIdentifier.text
        label.setContentCompressionResistancePriority(.required,
                                                      for: .vertical)
        return label
    }()

    // MARK: - Public Properties

    /// The delegate used to notify about some changed on switch.
    public weak var delegate: SwitchUIViewDelegate?

    private let isOnChangedSubject = PassthroughSubject<Bool, Never>()
    /// The publisher used to notify when isOn value changed on switch.
    public private(set) lazy var isOnChangedPublisher: AnyPublisher<Bool, Never> = self.isOnChangedSubject.eraseToAnyPublisher()

    /// The spark theme of the switch.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    /// The value of the switch.
    public var isOn: Bool {
        get {
            return self.viewModel.isOn
        }
        set {
            self.viewModel.isOn = newValue
            self.viewModel.reloadToggle()
        }
    }

    /// The alignment of the switch.
    public var alignment: SwitchAlignment {
        get {
            return self.viewModel.alignment
        }
        set {
            self.viewModel.set(alignment: newValue)
        }
    }

    /// The intentColor of the switch.
    public var intentColor: SwitchIntentColor {
        get {
            return self.viewModel.intentColor
        }
        set {
            self.viewModel.set(intentColor: newValue)
        }
    }

    /// The state of the switch: enabled or not.
    public var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.set(isEnabled: newValue)
        }
    }

    /// The images of the switch.
    public var images: SwitchUIImages? {
        get {
            return self.viewModel.images?.leftValue
        }
        set {
            self.viewModel.set(images: Self.getImagesEither(from: newValue))
        }
    }

    /// The text of the switch.
    public var text: String? {
        get {
            return self.textLabel.text
        }
        set {
            self.textLabel.text = newValue
            self.viewModel.textChanged(newValue)
        }
    }

    /// The attributed text of the switch.
    public var attributedText: NSAttributedString? {
        get {
            return self.textLabel.attributedText
        }
        set {
            self.textLabel.attributedText = newValue
        }
    }

    // MARK: - Private Properties

    private let viewModel: SwitchViewModel

    private var toggleWidthConstraint: NSLayoutConstraint?
    private var toggleHeightConstraint: NSLayoutConstraint?

    private var toggleContentLeadingConstraint: NSLayoutConstraint?
    private var toggleContentTopConstraint: NSLayoutConstraint?
    private var toggleContentTrailingConstraint: NSLayoutConstraint?
    private var toggleContentBottomConstraint: NSLayoutConstraint?

    private var toggleDotLeadingConstraint: NSLayoutConstraint?
    private var toggleDotTopConstraint: NSLayoutConstraint?
    private var toggleDotTrailingConstraint: NSLayoutConstraint?
    private var toggleDotBottomConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var contentStackViewSpacing: CGFloat = .zero
    @ScaledUIMetric private var toggleHeight: CGFloat = Constants.ToggleSizes.height
    @ScaledUIMetric private var toggleWidth: CGFloat = Constants.ToggleSizes.width
    @ScaledUIMetric private var toggleSpacing: CGFloat = Constants.ToggleSizes.padding
    @ScaledUIMetric private var toggleDotSpacing: CGFloat = Constants.toggleDotImagePadding

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    /// Initialize a new switch view without images and with text.
    /// - Parameters:
    ///   - theme: The spark theme of the switch.
    ///   - isOn: The value of the switch.
    ///   - alignment: The alignment of the switch.
    ///   - intentColor: The intent color of the switch.
    ///   - isEnabled: The state of the switch: enabled or not.
    ///   - text: The text of the switch.
    public convenience init(
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        text: String
    ) {
        self.init(
            theme,
            isOn: isOn,
            alignment: alignment,
            intentColor: intentColor,
            isEnabled: isEnabled,
            images: nil,
            text: text,
            attributedText: nil
        )
    }

    /// Initialize a new switch view without images and with attributedText.
    /// - Parameters:
    ///   - theme: The spark theme of the switch.
    ///   - isOn: The value of the switch.
    ///   - alignment: The alignment of the switch.
    ///   - intentColor: The intent color of the switch.
    ///   - isEnabled: The state of the switch: enabled or not.
    ///   - attributedText: The attributed text of the switch.
    public convenience init(
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        attributedText: NSAttributedString
    ) {
        self.init(
            theme,
            isOn: isOn,
            alignment: alignment,
            intentColor: intentColor,
            isEnabled: isEnabled,
            images: nil,
            text: nil,
            attributedText: attributedText
        )
    }

    /// Initialize a new switch view with images and text.
    /// - Parameters:
    ///   - theme: The spark theme of the switch.
    ///   - isOn: The value of the switch.
    ///   - alignment: The alignment of the switch.
    ///   - intentColor: The intent color of the switch.
    ///   - isEnabled: The state of the switch: enabled or not.
    ///   - images: The images of the switch.
    ///   - text: The text of the switch.
    public convenience init(
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        images: SwitchUIImages,
        text: String
    ) {
        self.init(
            theme,
            isOn: isOn,
            alignment: alignment,
            intentColor: intentColor,
            isEnabled: isEnabled,
            images: images,
            text: text,
            attributedText: nil
        )
    }

    /// Initialize a new switch view with images and attributed text.
    /// - Parameters:
    ///   - theme: The spark theme of the switch.
    ///   - isOn: The value of the switch.
    ///   - alignment: The alignment of the switch.
    ///   - intentColor: The intent color of the switch.
    ///   - isEnabled: The state of the switch: enabled or not.
    ///   - images: The images of the switch.
    ///   - attributedText: The attributed text of the switch.
    public convenience init(
        theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        images: SwitchUIImages,
        attributedText: NSAttributedString
    ) {
        self.init(
            theme,
            isOn: isOn,
            alignment: alignment,
            intentColor: intentColor,
            isEnabled: isEnabled,
            images: images,
            text: nil,
            attributedText: attributedText
        )
    }

    private init(
        _ theme: Theme,
        isOn: Bool,
        alignment: SwitchAlignment,
        intentColor: SwitchIntentColor,
        isEnabled: Bool,
        images: SwitchUIImages?,
        text: String?,
        attributedText: NSAttributedString?
    ) {
        self.viewModel = .init(
            theme: theme,
            isOn: isOn,
            alignment: alignment,
            intentColor: intentColor,
            isEnabled: isEnabled,
            images: Self.getImagesEither(from: images)
        )

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
        // Add subview
        self.addSubview(self.contentStackView)

        // View properties
        self.backgroundColor = .clear

        // Setup gestures
        self.setupGesturesRecognizer()

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

        self.layoutIfNeeded()
        self.toggleView.setCornerRadius(self.theme.border.radius.full)
        self.toggleDotView.setCornerRadius(self.theme.border.radius.full)
    }

    // MARK: - Gesture

    private func setupGesturesRecognizer() {
        self.setupToggleTapGestureRecognizer()
        self.setupToggleSwipeGestureRecognizer()
    }

    private func setupToggleTapGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleTapGestureAction))
        self.toggleView.addGestureRecognizer(gestureRecognizer)
    }

    private func setupToggleSwipeGestureRecognizer() {
        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.toggleSwipeGestureAction))
        rightGestureRecognizer.direction = .right
        self.toggleView.addGestureRecognizer(rightGestureRecognizer)

        let leftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.toggleSwipeGestureAction))
        leftGestureRecognizer.direction = .left
        self.toggleView.addGestureRecognizer(leftGestureRecognizer)
    }

    // MARK: - Constraints

    private func setupConstraints() {
        // Global
        self.setupViewConstraints()
        self.setupContentStackViewConstraints()

        // Toggle View and subviews
        self.setupToggleViewConstraints()
        self.setupToggleContentStackViewConstraints()
        self.setupToggleDotViewConstraints()
        self.setupToggleDotImageViewConstraints()

        // Text Label
        self.setupTextLabelContraints()
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

    private func setupToggleViewConstraints() {
        self.toggleView.translatesAutoresizingMaskIntoConstraints = false

        self.toggleWidthConstraint = self.toggleView.widthAnchor.constraint(equalToConstant: .zero)
        self.toggleHeightConstraint = self.toggleView.heightAnchor.constraint(equalToConstant: .zero)
    }

    private func setupToggleContentStackViewConstraints() {
        self.toggleContentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.toggleContentLeadingConstraint = self.toggleContentStackView.leadingAnchor.constraint(equalTo: self.toggleView.leadingAnchor)
        self.toggleContentLeadingConstraint?.isActive = true
        self.toggleContentTopConstraint = self.toggleContentStackView.topAnchor.constraint(equalTo: self.toggleView.topAnchor)
        self.toggleContentTopConstraint?.isActive = true
        self.toggleContentTrailingConstraint = self.toggleContentStackView.trailingAnchor.constraint(equalTo: self.toggleView.trailingAnchor)
        self.toggleContentTrailingConstraint?.isActive = true
        self.toggleContentBottomConstraint = self.toggleContentStackView.bottomAnchor.constraint(equalTo: self.toggleView.bottomAnchor)
        self.toggleContentBottomConstraint?.isActive = true
    }

    private func setupToggleDotViewConstraints() {
        self.toggleDotView.translatesAutoresizingMaskIntoConstraints = false
        self.toggleDotView.widthAnchor.constraint(equalTo: self.toggleDotView.heightAnchor).isActive = true
    }

    private func setupToggleDotImageViewConstraints() {
        self.toggleDotImageView.translatesAutoresizingMaskIntoConstraints = false

        self.toggleDotLeadingConstraint = self.toggleDotImageView.leadingAnchor.constraint(equalTo: self.toggleDotView.leadingAnchor)
        self.toggleDotLeadingConstraint?.isActive = true
        self.toggleDotTopConstraint = self.toggleDotImageView.topAnchor.constraint(equalTo: self.toggleDotView.topAnchor)
        self.toggleDotTopConstraint?.isActive = true
        self.toggleDotTrailingConstraint = self.toggleDotImageView.trailingAnchor.constraint(equalTo: self.toggleDotView.trailingAnchor)
        self.toggleDotTrailingConstraint?.isActive = true
        self.toggleDotBottomConstraint = self.toggleDotImageView.bottomAnchor.constraint(equalTo: self.toggleDotView.bottomAnchor)
        self.toggleDotBottomConstraint?.isActive = true
    }

    private func setupTextLabelContraints() {
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel.heightAnchor.constraint(greaterThanOrEqualTo: self.toggleView.heightAnchor).isActive = true
    }

    // MARK: - Actions

    @objc private func toggleTapGestureAction(_ sender: UITapGestureRecognizer) {
        self.viewModel.toggle()
    }

    @objc private func toggleSwipeGestureAction(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left where self.isOn, .right where !self.isOn:
            self.viewModel.toggle()

        default:
            break
        }
    }

    // MARK: - Update UI

    private func updateToggleContentViewSpacings() {
        // Reload spacing only if value changed
        let spacing = self._toggleSpacing.wrappedValue

        if spacing != self.toggleContentLeadingConstraint?.constant {

            self.toggleContentLeadingConstraint?.constant = spacing
            self.toggleContentTopConstraint?.constant = spacing
            self.toggleContentTrailingConstraint?.constant = -spacing
            self.toggleContentBottomConstraint?.constant = -spacing

            self.toggleContentStackView.layoutIfNeeded()
        }
    }

    private func updateToggleViewSize() {
        // Reload size only if value changed
        var valueChanged = false

        let width = self._toggleWidth.wrappedValue
        if width > 0 && width != self.toggleWidthConstraint?.constant {
            self.toggleWidthConstraint?.constant = width
            self.toggleWidthConstraint?.isActive = true
            valueChanged = true
        }

        let height = self._toggleHeight.wrappedValue
        if height > 0 && height != self.toggleHeightConstraint?.constant {
            self.toggleHeightConstraint?.constant = height
            self.toggleHeightConstraint?.isActive = true
            valueChanged = true
        }

        if valueChanged {
            self.toggleView.layoutIfNeeded()
        }
    }

    private func updateToggleDotImageViewSpacings() {
        // Reload spacing only if value changed
        let spacing = self._toggleDotSpacing.wrappedValue

        if spacing != self.toggleDotLeadingConstraint?.constant {

            self.toggleDotLeadingConstraint?.constant = spacing
            self.toggleDotTopConstraint?.constant = spacing
            self.toggleDotTrailingConstraint?.constant = -spacing
            self.toggleDotBottomConstraint?.constant = -spacing

            self.toggleDotImageView.layoutIfNeeded()
        }
    }

    private func updateContentStackViewSpacing() {
        // Reload spacing only if value changed and constraint is active
        let spacing = self._contentStackViewSpacing.wrappedValue

        if spacing != self.contentStackView.spacing {
            self.contentStackView.spacing = spacing
        }
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // **
        // Is On
        self.subscribeTo(self.viewModel.$isOnChanged) { [weak self] isOn in
            guard let self, let isOn else { return }

            self.delegate?.switchDidChange(self, isOn: isOn)
            self.isOnChangedSubject.send(isOn)
        }

        // **
        // Interaction
        self.subscribeTo(self.viewModel.$isToggleInteractionEnabled) { [weak self] isEnabled in
            guard let self, let isEnabled else { return }

            self.toggleView.isUserInteractionEnabled = isEnabled
        }
        self.subscribeTo(self.viewModel.$toggleOpacity) { [weak self] toggleOpacity in
            guard let self, let toggleOpacity else { return }

            // Animate only if new alpha is different from current alpha
            let animated = self.toggleView.alpha != toggleOpacity

            if animated {
                UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
                    self?.toggleView.alpha = toggleOpacity
                }
            } else {
                self.toggleView.alpha = toggleOpacity
            }
        }
        // **

        // **
        // Colors
        self.subscribeTo(self.viewModel.$toggleBackgroundColorToken) { [weak self] colorToken in
            guard let self, let colorToken else { return }

            // Animate only if there is currently an color on View and if new color is different from current color
            let animated = self.toggleView.backgroundColor != nil && self.toggleView.backgroundColor != colorToken.uiColor

            if animated {
                UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
                    self?.toggleView.backgroundColor = colorToken.uiColor
                }
            } else {
                self.toggleView.backgroundColor = colorToken.uiColor
            }
        }
        self.subscribeTo(self.viewModel.$toggleDotBackgroundColorToken) { [weak self] colorToken in
            guard let self, let colorToken else { return }

            self.toggleDotView.backgroundColor = colorToken.uiColor
        }
        self.subscribeTo(self.viewModel.$toggleDotForegroundColorToken) { [weak self] colorToken in
            guard let self, let colorToken else { return }

            // Animate only if there is currently an color on View and if new color is different from current color
            let animated = self.toggleDotImageView.tintColor != nil && self.toggleDotImageView.tintColor != colorToken.uiColor

            if animated {
                UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
                    self?.toggleDotImageView.tintColor = colorToken.uiColor
                }
            } else {
                self.toggleDotImageView.tintColor = colorToken.uiColor
            }
        }
        self.subscribeTo(self.viewModel.$textForegroundColorToken) { [weak self] colorToken in
            guard let self, let colorToken else { return }

            self.textLabel.textColor = colorToken.uiColor
        }
        // **

        // Aligments
        self.subscribeTo(self.viewModel.$isToggleOnLeft) { [weak self] isToggleOnLeft in
            guard let self, let isToggleOnLeft else { return }

            self.contentStackView.semanticContentAttribute = isToggleOnLeft ? .forceLeftToRight : .forceRightToLeft
        }
        self.subscribeTo(self.viewModel.$horizontalSpacing) { [weak self] horizontalSpacing in
            guard let self, let horizontalSpacing else { return }

            self.contentStackViewSpacing = horizontalSpacing
            self._contentStackViewSpacing.update(traitCollection: self.traitCollection)
            self.updateContentStackViewSpacing()
        }

        // **
        // Show spaces
        self.subscribeTo(self.viewModel.$showToggleLeftSpace) { [weak self] showSpace in
            guard let self, let showSpace else { return }

            // Lock interaction before animation
            let currentUserInteraction = self.toggleView.isUserInteractionEnabled
            self.toggleView.isUserInteractionEnabled = false

            UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
                self?.toggleLeftSpaceView.isHidden = !showSpace
                self?.toggleRightSpaceView.isHidden = showSpace
            } completion: { [weak self] _ in
                // Unlock interaction after animation
                self?.toggleView.isUserInteractionEnabled = currentUserInteraction
            }
        }
        // **

        // Show images
        self.subscribeTo(self.viewModel.$toggleDotImage) { [weak self] toggleDotImage in
            guard let self else { return }

            let image = toggleDotImage?.leftValue

            // Animate only if there is currently an image on ImageView and new image is exists
            let animated = self.toggleDotImageView.image != nil && image != nil

            if animated {
                UIView.transition(
                    with: self.toggleDotImageView,
                    duration: Constants.animationDuration,
                    options: .transitionCrossDissolve,
                    animations: {
                        self.toggleDotImageView.image = image
                    },
                    completion: nil
                )
            } else {
                self.toggleDotImageView.image = image
            }
        }

        // Text Label Font
        self.subscribeTo(self.viewModel.$textFontToken) { [weak self] fontToken in
            guard let self, let fontToken else { return }

            self.textLabel.font = fontToken.uiFont
        }
    }

    private func subscribeTo<Value>(_ publisher: some Publisher<Value, Never>, action: @escaping (Value) -> Void ) {
        publisher
            .receive(on: RunLoop.main)
            .sink { value in
                action(value)
            }
            .store(in: &self.subscriptions)
    }

    // MARK: - Trait Collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Update size content
        self._contentStackViewSpacing.update(traitCollection: self.traitCollection)
        self.updateContentStackViewSpacing()

        self._toggleSpacing.update(traitCollection: self.traitCollection)
        self.updateToggleContentViewSpacings()
        self.updateToggleDotImageViewSpacings()

        self._toggleWidth.update(traitCollection: self.traitCollection)
        self._toggleHeight.update(traitCollection: self.traitCollection)
        self.updateToggleViewSize()
    }

    // MARK: - Label priorities

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

    // MARK: - Either Getter

    private static func getImagesEither(from value: SwitchUIImages?) -> SwitchImagesEither? {
        guard let value else {
            return nil
        }

        return .left(value)
    }
}
