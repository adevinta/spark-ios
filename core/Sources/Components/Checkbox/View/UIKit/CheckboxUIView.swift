//
//  CheckboxUIView.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

/// The `CheckboxUIView`renders a single checkbox using UIKit.
public final class CheckboxUIView: UIView {

    // MARK: - Constants

    private enum Constants {
        static var checkboxSize: CGFloat = 20
        static var hitTestMargin: CGFloat = 8
        static var controlBorderWidth: CGFloat = 4
    }

    // MARK: - Private properties.

    private let button: UIButton = {
        let button = UIButton()
        button.isAccessibilityElement = false
        return button
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    private var supplementaryTextLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    private lazy var controlView: CheckboxControlUIView = {
        let controlView = CheckboxControlUIView(
            selectionIcon: self.viewModel.checkedImage,
            theme: self.theme
        )
        controlView.isAccessibilityElement = false
        controlView.translatesAutoresizingMaskIntoConstraints = false
        return controlView
    }()

    private var controlViewWidthConstraint: NSLayoutConstraint?
    private var controlViewHeightConstraint: NSLayoutConstraint?
    private var textLabelBottomConstraint: NSLayoutConstraint?
    private var textLabelLeadingConstraint: NSLayoutConstraint?
    private var textLabelTrailingConstraint: NSLayoutConstraint?
    private var controlViewLeadingConstraint: NSLayoutConstraint?
    private var controlViewTrailingConstraint: NSLayoutConstraint?

    private var checkboxPosition: CheckboxPosition = .left
    private var cancellables = Set<AnyCancellable>()

    @ScaledUIMetric private var checkboxSize: CGFloat = Constants.checkboxSize
    @ScaledUIMetric private var controlBorderWidth: CGFloat = Constants.controlBorderWidth

    private var spacing: LayoutSpacing {
        return self.theme.layout.spacing
    }

    private var colors: CheckboxColorables {
        return self.viewModel.colors
    }

    // MARK: - Public properties.

    /// Set a delegate to receive selection state change callbacks. Alternatively, you can use bindings.
    public weak var delegate: CheckboxUIViewDelegate?

    /// The text displayed in the checkbox.
    public var text: String {
        get {
            return self.viewModel.text
        }
        set {
            self.viewModel.text = newValue
            self.textLabel.text = self.text
            self.updateAccessibility()
        }
    }

    /// The current selection state of the checkbox.
    @Binding public var selectionState: CheckboxSelectionState {
        didSet {
            self.controlView.selectionState = self.selectionState
            self.updateAccessibility()
        }
    }

    /// The control state of the checkbox (e.g. `.enabled` or `.disabled`).
    public var state: SelectButtonState {
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
    /// Returns the theme of the checkbox.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    var colorsUseCase: CheckboxColorsUseCaseable {
        get {
            return self.viewModel.colorsUseCase
        }
        set {
            self.viewModel.colorsUseCase = newValue
        }
    }

    var viewModel: CheckboxViewModel

    var isPressed: Bool = false {
        didSet {
            self.controlView.isPressed = self.isPressed
        }
    }

    // MARK: - Initialization

    /// Not implemented. Please use another init.
    /// - Parameter coder: the coder.
    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - text: The checkbox text.
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    ///   - checkboxPosition: Positions the checkbox on the leading or trailing edge of the view.
    public convenience init(
        theme: Theme,
        text: String,
        checkedImage: UIImage,
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>,
        checkboxPosition: CheckboxPosition
    ) {
        self.init(
            theme: theme,
            text: text,
            checkedImage: checkedImage,
            colorsUseCase: CheckboxColorsUseCase(),
            state: state,
            selectionState: selectionState,
            checkboxPosition: checkboxPosition
        )
    }

    init(
        theme: Theme,
        text: String,
        checkedImage: UIImage,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled,
        selectionState: Binding<CheckboxSelectionState>,
        checkboxPosition: CheckboxPosition
    ) {
        self._selectionState = selectionState
        self.checkboxPosition = checkboxPosition
        self.viewModel = .init(text: text, checkedImage: checkedImage, theme: theme, colorsUseCase: colorsUseCase, state: state)

        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.isAccessibilityElement = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.controlView.selectionState = self.selectionState

        self.textLabel.text = self.text
        self.addSubview(self.textLabel)

        self.addSubview(self.controlView)

        let view = self
        let textLabel = self.textLabel
        let controlView = self.controlView

        let controlSize = self.checkboxSize

        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let padding = bodyFontMetrics.scaledValue(for: self.spacing.medium) - self.controlBorderWidth
        let wideSpacing = bodyFontMetrics.scaledValue(for: self.spacing.xxxLarge) - self.controlBorderWidth

        switch self.checkboxPosition {
        case .left:
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: padding)
            self.textLabelLeadingConstraint?.isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.controlViewWidthConstraint = controlView.widthAnchor.constraint(equalToConstant: controlSize)
            self.controlViewWidthConstraint?.isActive = true
            self.controlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: controlSize)
            self.controlViewHeightConstraint?.isActive = true
            self.controlViewLeadingConstraint = controlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -padding)
            self.controlViewLeadingConstraint?.isActive = true

        case .right:
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: -wideSpacing)
            self.textLabelTrailingConstraint?.isActive = true
            self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.controlViewWidthConstraint = controlView.widthAnchor.constraint(equalToConstant: controlSize)
            self.controlViewWidthConstraint?.isActive = true
            self.controlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: controlSize)
            self.controlViewHeightConstraint?.isActive = true
            self.controlViewTrailingConstraint = controlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: padding)
            self.controlViewTrailingConstraint?.isActive = true
        }
        let controlViewCenterConstraint = controlView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor)
        controlViewCenterConstraint.isActive = true

        self.button.addTarget(self, action: #selector(self.actionTapped(sender:)), for: .touchUpInside)
        self.button.addTarget(self, action: #selector(self.actionTouchDown(sender:)), for: .touchDown)
        self.button.addTarget(self, action: #selector(self.actionTouchUp(sender:)), for: .touchUpOutside)
        self.button.addTarget(self, action: #selector(self.actionTouchUp(sender:)), for: .touchCancel)

        self.button.translatesAutoresizingMaskIntoConstraints = true
        self.button.frame = self.bounds.insetBy(dx: -Constants.hitTestMargin, dy: -Constants.hitTestMargin)
        self.button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(self.button)

        self.updateTheme()
        self.updateState()
        self.updateViewConstraints()
        self.updateAccessibility()
        self.subscribe()
    }

    private func subscribe() {
        self.viewModel.$colors
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.updateTheme()
            }
            .store(in: &cancellables)

        self.subscribeTo(self.viewModel.$theme) { [weak self] _ in
            guard let self else { return }

            self.updateTheme()
            self.updateState()
            self.updateViewConstraints()
        }
    }

    private func subscribeTo<Value>(_ publisher: some Publisher<Value, Never>, action: @escaping (Value) -> Void) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { value in
                action(value)
            }
            .store(in: &self.cancellables)
    }

    // MARK: - Override
    /// The trait collection was updated causing the view to update its constraints (e.g. dynamic content size change).
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._checkboxSize.update(traitCollection: self.traitCollection)
        self._controlBorderWidth.update(traitCollection: self.traitCollection)

        self.updateViewConstraints()
    }

    // Tap area is bigger than the bounds of self.
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let convertedPoint = button.convert(point, from: self)
        return button.point(inside: convertedPoint, with: event)
    }

    // MARK: - Methods
    private func updateAccessibility() {
        if self.selectionState == .selected {
            self.accessibilityTraits.insert(.selected)
        } else {
            self.accessibilityTraits.remove(.selected)
        }

        if self.state == .disabled {
            self.accessibilityTraits.insert(.notEnabled)
        } else {
            self.accessibilityTraits.remove(.notEnabled)
        }

        self.accessibilityLabel = [self.viewModel.text, self.viewModel.supplementaryMessage].compactMap { $0 }.joined(separator: ". ")
    }

    private func updateViewConstraints() {
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let controlBorderWidth = self.controlBorderWidth
        let scaledSpacing = self.checkboxSize + 2 * controlBorderWidth

        self.controlViewWidthConstraint?.constant = scaledSpacing
        self.controlViewHeightConstraint?.constant = scaledSpacing

        let padding = bodyFontMetrics.scaledValue(for: self.spacing.medium) - controlBorderWidth
        let wideSpacing = bodyFontMetrics.scaledValue(for: self.spacing.xxxLarge) - controlBorderWidth

        self.controlViewLeadingConstraint?.constant = -controlBorderWidth
        self.controlViewTrailingConstraint?.constant = controlBorderWidth

        self.textLabelLeadingConstraint?.constant = padding
        self.textLabelTrailingConstraint?.constant = -wideSpacing

        if let supplementaryMessage = self.supplementaryMessage {
            self.supplementaryTextLabel.text = supplementaryMessage

            if self.supplementaryTextLabel.superview == nil {
                self.addSubview(self.supplementaryTextLabel)

                if let bottomConstraint = self.textLabelBottomConstraint {
                    NSLayoutConstraint.deactivate([bottomConstraint])
                }

                self.supplementaryTextLabel.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
                self.supplementaryTextLabel.leadingAnchor.constraint(equalTo: self.textLabel.leadingAnchor).isActive = true
                self.supplementaryTextLabel.trailingAnchor.constraint(equalTo: self.textLabel.trailingAnchor).isActive = true
                self.supplementaryTextLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
            }
        } else {
            if self.supplementaryTextLabel.superview != nil {
                self.supplementaryTextLabel.removeFromSuperview()
            }

            if let bottomConstraint = self.textLabelBottomConstraint {
                NSLayoutConstraint.deactivate([bottomConstraint])
            }
            self.textLabelBottomConstraint = self.textLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true
        }

        self.setNeedsLayout()
    }

    private var interactionEnabled: Bool {
        return self.viewModel.interactionEnabled
    }

    private var opacity: CGFloat {
        return self.viewModel.opacity
    }

    private var supplementaryMessage: String? {
        return self.viewModel.supplementaryMessage
    }

    private func updateTheme() {
        self.controlView.theme = self.theme
        self.controlView.colors = self.colors

        let font = self.theme.typography.body1.uiFont
        self.textLabel.font = font
        self.textLabel.adjustsFontForContentSizeCategory = true
        self.textLabel.textColor = self.colors.textColor.uiColor

        let captionFont = self.theme.typography.caption.uiFont
        self.supplementaryTextLabel.font = captionFont
        self.supplementaryTextLabel.adjustsFontForContentSizeCategory = true
        self.supplementaryTextLabel.textColor = self.colors.checkboxTintColor.uiColor
    }

    private func updateState() {
        let opacity = self.opacity
        self.textLabel.alpha = opacity
        self.controlView.alpha = opacity
        self.supplementaryTextLabel.alpha = opacity
    }

    @IBAction private func actionTapped(sender: UIButton) {
        self.isPressed = false

        guard self.interactionEnabled else { return }
        switch self.selectionState {
        case .selected:
            self.selectionState = .unselected
        case .unselected, .indeterminate:
            self.selectionState = .selected
        }
        self.delegate?.checkbox(self, didChangeSelection: self.selectionState)
    }

    @IBAction private func actionTouchDown(sender: UIButton) {
        guard self.interactionEnabled else { return }

        self.isPressed = true
    }

    @IBAction private func actionTouchUp(sender: UIButton) {
        self.isPressed = false
    }
}
