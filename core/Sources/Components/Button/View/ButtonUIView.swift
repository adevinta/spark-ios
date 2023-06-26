//
//  ButtonUIView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// The `ButtonUIView`renders a Spark-button using UIKit.
public class ButtonUIView: UIView {

    // MARK: - Constants

    private enum Constants {
        static var borderWidth: CGFloat = 2
    }

    // MARK: - Private properties.

    private let button: UIButton = {
        let button = UIButton()
        button.isAccessibilityElement = false
        return button
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.isAccessibilityElement = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var imageViewWidthConstraint: NSLayoutConstraint?
    private var imageViewHeightConstraint: NSLayoutConstraint?
    private var imageViewLeadingConstraint: NSLayoutConstraint?
    private var imageViewTrailingConstraint: NSLayoutConstraint?

    private var textLabelBottomConstraint: NSLayoutConstraint?
    private var textLabelTrailingConstraint: NSLayoutConstraint?
    private var textLabelLeadingConstraint: NSLayoutConstraint?
    private var buttonHeightConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var spacingLarge: CGFloat
    @ScaledUIMetric private var spacingMedium: CGFloat
    @ScaledUIMetric private var borderRadiusLarge: CGFloat
    @ScaledUIMetric private var borderWidth: CGFloat = Constants.borderWidth

    private var cancellables = Set<AnyCancellable>()

    private var scaledButtonHeight: CGFloat {
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let traitCollection = self.traitCollection

        return bodyFontMetrics.scaledValue(for: self.buttonHeight, compatibleWith: traitCollection)
    }

    private var buttonHeight: CGFloat {
        return self.size.height
    }

    private var colors: ButtonColorables {
        return self.viewModel.colors
    }

    private var opacity: CGFloat {
        return self.viewModel.opacity
    }

    private var spacing: LayoutSpacing {
        return self.theme.layout.spacing
    }

    // MARK: - Public properties.

    /// Set a delegate to receive selection state change callbacks. Alternatively, you can use the `tapPublisher`.
    public weak var delegate: ButtonUIViewDelegate?

    /// The tap publisher. Alternatively, you can set a delegate.
    public var tapPublisher: UIControl.EventPublisher {
        return self.button.publisher(for: .touchUpInside)
    }

    /// Publishes when a touch was cancelled (e.g. by the system).
    public var touchCancelPublisher: UIControl.EventPublisher {
        return self.button.publisher(for: .touchCancel)
    }

    /// Publishes when a touch was started but the touch ended outside of the button view bounds.
    public var touchUpOutsidePublisher: UIControl.EventPublisher {
        return self.button.publisher(for: .touchUpOutside)
    }

    /// Publishes instantly when the button is touched down.
    /// - warning: This should not trigger a user action and should only be used for things like tracking.
    public var touchDownPublisher: UIControl.EventPublisher {
        return self.button.publisher(for: .touchDown)
    }

    /// The text displayed in the button.
    public var text: String {
        get {
            self.viewModel.text
        }
        set {
            self.viewModel.text = newValue
            self.textLabel.text = text
            self.updateAccessibility()
        }
    }

    /// The button corner shape.
    public var shape: ButtonShape {
        get {
            return self.viewModel.shape
        }
        set {
            guard newValue != self.viewModel.shape else { return }
            self.viewModel.shape = newValue

            self.updateShape()
        }
    }

    /// The size of the button.
    public var size: ButtonSize {
        get {
            return self.viewModel.size
        }
        set {
            guard newValue != self.viewModel.size else { return }
            self.viewModel.size = newValue

            self.updateSize()
            self.updateViewConstraints()
        }
    }

    /// The icon of the button.
    public var icon: ButtonIcon {
        get {
            return viewModel.icon
        }
        set {
            guard newValue != icon else { return }
            self.viewModel.icon = newValue

            self.imageView.image = self.icon.image
            self.updateViewConstraints()
        }
    }

    /// The control state of the button (e.g. `.enabled` or `.disabled`).
    public var state: ButtonState {
        get {
            return self.viewModel.state
        }
        set {
            guard newValue != self.viewModel.state else { return }

            self.viewModel.state = newValue

            self.updateState()
            self.updateViewConstraints()

            self.updateAccessibility()
        }
    }
    /// Sets the theme of the checkbox.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    // MARK: - Internal properties

    var colorsUseCase: ButtonGetColorsUseCaseable {
        return self.viewModel.colorsUseCase
    }

    var viewModel: ButtonViewModel

    var isPressed: Bool = false {
        didSet {
            self.updateTheme()
        }
    }

    var interactionEnabled: Bool {
        return self.viewModel.interactionEnabled
    }

    // MARK: - Initialize

    /// Not implemented. Please use another init.
    /// - Parameter coder: the coder.
    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    /// Initialize a new button UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - text: The button text.
    ///   - icon: The button icon. **.none** by default.
    ///   - state: The control state controls whether the button is enabled or disabled.
    ///   - variant: Button variant sets the styling of the button.
    ///   - intentColor: Button variant sets the intent and colors of the button.
    public convenience init(
        theme: Theme,
        text: String,
        icon: ButtonIcon = .none,
        state: ButtonState = .enabled,
        variant: ButtonVariant = .filled,
        intentColor: ButtonIntentColor
    ) {
        self.init(
            theme: theme,
            text: text,
            icon: icon,
            colorsUseCase: ButtonGetColorsUseCase(),
            state: state,
            variant: variant,
            intentColor: intentColor
        )
    }

    init(
        theme: Theme,
        text: String,
        icon: ButtonIcon,
        colorsUseCase: ButtonGetColorsUseCaseable = ButtonGetColorsUseCase(),
        state: ButtonState = .enabled,
        variant: ButtonVariant = .filled,
        intentColor: ButtonIntentColor
    ) {
        self.viewModel = .init(
            text: text,
            icon: icon,
            theme: theme,
            colorsUseCase: colorsUseCase,
            state: state,
            intentColor: intentColor,
            variant: variant
        )

        self.spacingLarge = theme.layout.spacing.large
        self.spacingMedium = theme.layout.spacing.medium
        self.borderRadiusLarge = theme.border.radius.large

        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.isAccessibilityElement = true
        self.translatesAutoresizingMaskIntoConstraints = false

        let imageView = self.imageView
        let textLabel = self.textLabel
        let button = self.button
        let contentView = self.contentView
        self.addSubview(contentView)
        contentView.addSubview(textLabel)
        contentView.addSubview(imageView)

        textLabel.text = self.text
        contentView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)

        button.addTarget(self, action: #selector(self.actionTouchUpInside(sender:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.actionTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.actionTouchUpOutside(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.actionTouchCancel(sender:)), for: .touchCancel)

        button.translatesAutoresizingMaskIntoConstraints = true
        button.frame = self.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.image = self.icon.image
        self.addSubview(button)

        self.setupConstraints()

        self.updateSize()
        self.updateTheme()
        self.updateState()
        self.updateViewConstraints()
        self.updateAccessibility()
        self.subscribe()
    }

    private func setupConstraints() {
        let view = self
        let imageView = self.imageView
        let textLabel = self.textLabel
        let contentView = self.contentView

        contentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        self.buttonHeightConstraint = textLabel.heightAnchor.constraint(equalToConstant: self.scaledButtonHeight)
        self.buttonHeightConstraint?.isActive = true

        imageView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 0)
        self.imageViewWidthConstraint?.isActive = true
        self.imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
        self.imageViewHeightConstraint?.isActive = true

        switch self.icon {
        case .leading, .none, .iconOnly:
            textLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor)
            self.textLabelLeadingConstraint?.isActive = true
            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
            self.textLabelTrailingConstraint?.isActive = true
            self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor)
            self.imageViewLeadingConstraint?.isActive = true

        case .trailing:
            textLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor)
            self.textLabelLeadingConstraint?.isActive = true
            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor)
            self.textLabelTrailingConstraint?.isActive = true
            self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            self.imageViewTrailingConstraint?.isActive = true
        }
    }

    // MARK: - Overrides

    /// The trait collection was updated causing the view to update its constraints (e.g. dynamic content size change).
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateViewConstraints()

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.updateTheme()
        }

        let traitCollection = self.traitCollection
        _spacingLarge.update(traitCollection: traitCollection)
        _spacingMedium.update(traitCollection: traitCollection)
        _borderRadiusLarge.update(traitCollection: traitCollection)
        _borderWidth.update(traitCollection: traitCollection)

        self.setNeedsDisplay()
    }

}

// MARK: - Private methods
private extension ButtonUIView {
    func subscribe() {
        self.viewModel.$colors
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.updateTheme()
            }
            .store(in: &self.cancellables)

        self.subscribeTo(self.viewModel.$theme) { [weak self] _ in
            guard let self else { return }
            self.updateTheme()

            self.updateSize()
            self.updateTheme()
            self.updateState()
            self.updateViewConstraints()
        }
    }

    private func subscribeTo<Value>(_ publisher: some Publisher<Value, Never>, action: @escaping (Value) -> Void) {
        publisher
            .receive(on: RunLoop.main)
            .sink { value in
                action(value)
            }
            .store(in: &self.cancellables)
    }

    func updateAccessibility() {
        if self.state == .disabled {
            self.accessibilityTraits.insert(.notEnabled)
        } else {
            self.accessibilityTraits.remove(.notEnabled)
        }

        self.accessibilityLabel = self.viewModel.text
    }

    func updateViewConstraints() {
        let textLabel = self.textLabel
        let imageView = self.imageView
        let contentView = self.contentView

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let iconSize = self.buttonHeight - 2 * self.spacing.medium
        let scaledIconSize = bodyFontMetrics.scaledValue(for: iconSize, compatibleWith: traitCollection)
        self.imageViewWidthConstraint?.constant = scaledIconSize
        self.imageViewHeightConstraint?.constant = scaledIconSize

        if let bottomConstraint = self.textLabelBottomConstraint {
            NSLayoutConstraint.deactivate([bottomConstraint])
        }
        self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        self.textLabelBottomConstraint?.isActive = true

        imageView.isHidden = !viewModel.hasIcon
        textLabel.isHidden = !viewModel.hasText

        NSLayoutConstraint.deactivate([self.textLabelLeadingConstraint, self.textLabelTrailingConstraint, self.imageViewLeadingConstraint, self.imageViewTrailingConstraint].compactMap { $0 })
        self.textLabelLeadingConstraint = nil
        self.textLabelTrailingConstraint = nil
        self.imageViewLeadingConstraint = nil
        self.imageViewTrailingConstraint = nil

        self.updateSize()

        let largeSpacing = self.spacingLarge
        let mediumSpacing = self.spacingMedium
        switch self.icon {
        case .leading:
            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: mediumSpacing)
            self.textLabelLeadingConstraint?.isActive = true

            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -largeSpacing)
            self.textLabelTrailingConstraint?.isActive = true

            self.imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: largeSpacing)
            self.imageViewLeadingConstraint?.isActive = true
        case .trailing:
            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -mediumSpacing)
            self.textLabelTrailingConstraint?.isActive = true

            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: largeSpacing)
            self.textLabelLeadingConstraint?.isActive = true

            self.imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -largeSpacing)
            self.imageViewTrailingConstraint?.isActive = true
        case .none:
            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: largeSpacing)
            self.textLabelLeadingConstraint?.isActive = true

            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -largeSpacing)
            self.textLabelTrailingConstraint?.isActive = true
        case .iconOnly:
            self.imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumSpacing)
            self.imageViewLeadingConstraint?.isActive = true

            self.imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumSpacing)
            self.imageViewTrailingConstraint?.isActive = true
        }

        self.setNeedsLayout()
    }

    func updateShape() {
        switch self.shape {
        case .square:
            self.layer.cornerRadius = 0
        case .rounded:
            self.layer.cornerRadius = min(self.borderRadiusLarge, self.scaledButtonHeight / 2)
        case .pill:
            self.layer.cornerRadius = self.scaledButtonHeight / 2
        }
        self.layer.borderWidth = self.borderWidth
    }

    func updateSize() {
        self.buttonHeightConstraint?.constant = self.scaledButtonHeight
        self.updateShape()
    }

    func updateTheme() {
        let theme = self.theme
        self.spacingLarge = theme.layout.spacing.large
        self.spacingMedium = theme.layout.spacing.medium
        self.borderRadiusLarge = theme.border.radius.large

        let colors = self.colors
        if self.isPressed {
            self.backgroundColor = colors.pressedBackgroundColor.uiColor
            self.layer.borderColor = colors.pressedBorderColor.uiColor.cgColor
        } else {
            self.backgroundColor = colors.backgroundColor.uiColor
            self.layer.borderColor = colors.borderColor.uiColor.cgColor
        }

        let font = self.theme.typography.callout.uiFont
        self.textLabel.font = font
        self.textLabel.adjustsFontForContentSizeCategory = true
        self.textLabel.textColor = colors.textColor.uiColor
        self.imageView.tintColor = colors.textColor.uiColor
    }

    func updateState() {
        let opacity = self.opacity
        self.alpha = opacity
    }
}

// MARK: - Actions
private extension ButtonUIView {
    @IBAction func actionTouchUpInside(sender: UIButton) {
        self.isPressed = false

        guard self.interactionEnabled else { return }
        self.delegate?.button(self, didReceive: .touchUpInside)
        self.delegate?.buttonWasTapped(self)
    }

    @IBAction func actionTouchDown(sender: UIButton) {
        guard self.interactionEnabled else { return }
        self.isPressed = true
        self.delegate?.button(self, didReceive: .touchDown)
    }

    @IBAction func actionTouchUpOutside(sender: UIButton) {
        self.isPressed = false
        self.delegate?.button(self, didReceive: .touchUpOutside)
    }

    @IBAction func actionTouchCancel(sender: UIButton) {
        self.isPressed = false
        self.delegate?.button(self, didReceive: .touchCancel)
    }
}
