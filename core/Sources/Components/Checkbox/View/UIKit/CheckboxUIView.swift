//
//  CheckboxUIView.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

/// The `CheckboxUIView`renders a single checkbox using UIKit.
public final class CheckboxUIView: UIView {

    // MARK: - Constants

    private enum Constants {
        @ScaledUIMetric static var checkboxSize: CGFloat = 20
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
            selectionIcon: self.theme.iconography.checkmark.uiImage,
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
    private var controlViewTopConstraint: NSLayoutConstraint?
    private var controlViewLeadingConstraint: NSLayoutConstraint?
    private var controlViewTrailingConstraint: NSLayoutConstraint?

    private var checkboxPosition: CheckboxPosition = .left

    private var spacing: LayoutSpacing {
        return self.theme.layout.spacing
    }

    private var colors: CheckboxColorables {
        return self.viewModel.colors
    }

    // MARK: - Public properties.

    /// Set a delegate to receive selection state change callbacks. Alternatively, you can set a `selectionStateHandler`.
    public weak var delegate: CheckboxUIViewDelegate?
    /// Set the `selectionStateHandler` to receive selection state change callbacks. Alternatively, you can set a delegate.
    public var selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)?

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
    public var selectionState: CheckboxSelectionState = .unselected {
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
            self.viewModel.state = newValue

            self.updateState()
            self.updateViewConstraints()

            self.updateAccessibility()
        }
    }
    /// Returns the theme of the checkbox.
    var theme: Theme {
        return self.viewModel.theme
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
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    ///   - checkboxPosition: Positions the checkbox on the leading or trailing edge of the view.
    ///   - selectionStateHandler: The handler which is called when the checkbox state is changed.
    public convenience init(
        theme: Theme,
        text: String,
        state: SelectButtonState = .enabled,
        selectionState: CheckboxSelectionState = .unselected,
        checkboxPosition: CheckboxPosition,
        selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)? = nil
    ) {
        self.init(
            theme: theme,
            text: text,
            colorsUseCase: CheckboxColorsUseCase(),
            state: state,
            selectionState: selectionState,
            checkboxPosition: checkboxPosition,
            selectionStateHandler: selectionStateHandler
        )
    }

    init(
        theme: Theme,
        text: String,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled,
        selectionState: CheckboxSelectionState = .unselected,
        checkboxPosition: CheckboxPosition,
        selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)? = nil
    ) {
        self.selectionState = selectionState
        self.checkboxPosition = checkboxPosition
        self.selectionStateHandler = selectionStateHandler
        self.viewModel = .init(text: text, theme: theme, colorsUseCase: colorsUseCase, state: state)

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

        let controlSize = Constants.checkboxSize
        let padding = self.spacing.medium / 2
        switch checkboxPosition {
        case .left:
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.textLabelLeadingConstraint = textLabel.leadingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: padding)
            self.textLabelLeadingConstraint?.isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.controlViewTopConstraint = controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -padding)
            self.controlViewTopConstraint?.isActive = true
            self.controlViewWidthConstraint = controlView.widthAnchor.constraint(equalToConstant: controlSize)
            self.controlViewWidthConstraint?.isActive = true
            self.controlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: controlSize)
            self.controlViewHeightConstraint?.isActive = true
            self.controlViewLeadingConstraint = controlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -padding)
            self.controlViewLeadingConstraint?.isActive = true

        case .right:
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            self.textLabelTrailingConstraint = textLabel.trailingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: -padding)
            self.textLabelTrailingConstraint?.isActive = true
            self.textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.controlViewTopConstraint = controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -padding)
            self.controlViewTopConstraint?.isActive = true
            self.controlViewWidthConstraint = controlView.widthAnchor.constraint(equalToConstant: controlSize)
            self.controlViewWidthConstraint?.isActive = true
            self.controlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: controlSize)
            self.controlViewHeightConstraint?.isActive = true
            self.controlViewTrailingConstraint = controlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: padding)
            self.controlViewTrailingConstraint?.isActive = true
        }

        self.button.addTarget(self, action: #selector(self.actionTapped(sender:)), for: .touchUpInside)
        self.button.addTarget(self, action: #selector(self.actionTouchDown(sender:)), for: .touchDown)
        self.button.addTarget(self, action: #selector(self.actionTouchUp(sender:)), for: .touchUpOutside)
        self.button.addTarget(self, action: #selector(self.actionTouchUp(sender:)), for: .touchCancel)

        self.button.translatesAutoresizingMaskIntoConstraints = true
        self.button.frame = self.bounds
        self.button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(self.button)

        self.updateTheme()
        self.updateState()
        self.updateViewConstraints()
        self.updateAccessibility()
    }

    // MARK: - Methods

    /// The trait collection was updated causing the view to update its constraints (e.g. dynamic content size change).
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateViewConstraints()
    }

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
        let scaledSpacing = Constants.checkboxSize + bodyFontMetrics.scaledValue(for: self.spacing.medium, compatibleWith: traitCollection)

        self.controlViewWidthConstraint?.constant = scaledSpacing
        self.controlViewHeightConstraint?.constant = scaledSpacing

        let padding = bodyFontMetrics.scaledValue(for: self.spacing.medium / 2, compatibleWith: traitCollection)

        self.controlViewTopConstraint?.constant = -padding
        self.controlViewLeadingConstraint?.constant = -padding
        self.controlViewTrailingConstraint?.constant = padding

        self.textLabelLeadingConstraint?.constant = padding
        self.textLabelTrailingConstraint?.constant = -padding

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
        self.selectionStateHandler?(self.selectionState)
        self.delegate?.checkbox(self, didChangeSelection: self.selectionState)
    }

    @IBAction private func actionTouchDown(sender: UIButton) {
        self.isPressed = true
    }

    @IBAction private func actionTouchUp(sender: UIButton) {
        self.isPressed = false
    }
}
