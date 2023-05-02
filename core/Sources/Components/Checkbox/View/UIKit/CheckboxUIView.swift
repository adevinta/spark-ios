//
//  CheckboxUIView.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// The `CheckboxUIView`renders a single checkbox using UIKit.
public final class CheckboxUIView: UIView {

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
            selectionIcon: self.theming.iconography.checkmark.uiImage,
            theming: self.theming
        )
        controlView.isAccessibilityElement = false
        controlView.translatesAutoresizingMaskIntoConstraints = false
        return controlView
    }()

    private var controlViewWidthConstraint: NSLayoutConstraint?
    private var controlViewHeightConstraint: NSLayoutConstraint?
    private var textLabelBottomConstraint: NSLayoutConstraint?

    private var checkboxPosition: CheckboxPosition = .left

    // MARK: - Public properties.

    /// Set a delegate to receive selection state change callbacks. Alternatively, you can set a `selectionStateHandler`.
    public weak var delegate: CheckboxUIViewDelegate?
    /// Set the `selectionStateHandler` to receive selection state change callbacks. Alternatively, you can set a delegate.
    public var selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)?

    /// The text displayed in the checkbox.
    public var text: String {
        get {
            self.viewModel.text
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
        didSet {
            self.viewModel.state = self.state
            self.colors = self.colorsUseCase.execute(from: self.theming, state: self.state)

            self.updateState()
            self.updateViewConstraints()

            self.updateAccessibility()
        }
    }
    /// Sets the theme of the checkbox.
    public var theming: Theme

    var colors: CheckboxColorables {
        get {
            self.viewModel.colors
        }
        set {
            self.viewModel.colors = newValue
            self.updateTheme()
        }
    }
    var colorsUseCase: CheckboxColorsUseCaseable {
        didSet {
            self.colors = self.colorsUseCase.execute(from: self.theming, state: self.state)
        }
    }

    var viewModel: CheckboxViewModel

    var isPressed: Bool = false {
        didSet {
            self.controlView.isPressed = self.isPressed
        }
    }

    /// Not implemented. Please use another init.
    /// - Parameter coder: the coder.
    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theming: The current Spark-Theme.
    ///   - text: The checkbox text.
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    ///   - checkboxPosition: Positions the checkbox on the leading or trailing edge of the view.
    ///   - selectionStateHandler: The handler which is called when the checkbox state is changed.
    public convenience init(
        theming: Theme,
        text: String,
        state: SelectButtonState = .enabled,
        selectionState: CheckboxSelectionState = .unselected,
        checkboxPosition: CheckboxPosition,
        selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)? = nil
    ) {
        self.init(
            theming: theming,
            text: text,
            colorsUseCase: CheckboxColorsUseCase(),
            state: state,
            selectionState: selectionState,
            checkboxPosition: checkboxPosition,
            selectionStateHandler: selectionStateHandler
        )
    }

    init(
        theming: Theme,
        text: String,
        colorsUseCase: CheckboxColorsUseCaseable = CheckboxColorsUseCase(),
        state: SelectButtonState = .enabled,
        selectionState: CheckboxSelectionState = .unselected,
        checkboxPosition: CheckboxPosition,
        selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)? = nil
    ) {
        self.theming = theming
        self.colorsUseCase = colorsUseCase
        self.state = state
        self.selectionState = selectionState
        self.checkboxPosition = checkboxPosition
        self.selectionStateHandler = selectionStateHandler
        self.viewModel = .init(text: text, theming: theming, colorsUseCase: colorsUseCase, state: state)

        super.init(frame: .zero)
        self.colors = colorsUseCase.execute(from: theming, state: state)
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
        switch self.checkboxPosition {
        case .left:
            self.textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.textLabel.leadingAnchor.constraint(equalTo: self.controlView.trailingAnchor, constant: 4).isActive = true
            self.textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.textLabelBottomConstraint = self.textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4).isActive = true
            self.controlViewWidthConstraint = self.controlView.widthAnchor.constraint(equalToConstant: 28)
            self.controlViewWidthConstraint?.isActive = true
            self.controlViewHeightConstraint = self.controlView.heightAnchor.constraint(equalToConstant: 28)
            self.controlViewHeightConstraint?.isActive = true
            self.controlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -4).isActive = true

        case .right:
            self.textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            self.textLabel.trailingAnchor.constraint(equalTo: self.controlView.leadingAnchor, constant: -4).isActive = true
            self.textLabelBottomConstraint = self.textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            self.textLabelBottomConstraint?.isActive = true

            self.controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4).isActive = true
            self.controlViewWidthConstraint = self.controlView.widthAnchor.constraint(equalToConstant: 28)
            self.controlViewWidthConstraint?.isActive = true
            self.controlViewHeightConstraint = self.controlView.heightAnchor.constraint(equalToConstant: 28)
            self.controlViewHeightConstraint?.isActive = true
            self.controlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 4).isActive = true
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
        let scaledSpacing = bodyFontMetrics.scaledValue(for: 20.0, compatibleWith: traitCollection) + 8

        self.controlViewWidthConstraint?.constant = scaledSpacing
        self.controlViewHeightConstraint?.constant = scaledSpacing

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

    var interactionEnabled: Bool {
        self.viewModel.interactionEnabled
    }

    var opacity: CGFloat {
        self.viewModel.opacity
    }

    var supplementaryMessage: String? {
        self.viewModel.supplementaryMessage
    }

    private func updateTheme() {
        self.controlView.colors = self.colors

        let font = self.theming.typography.body1.uiFont
        self.textLabel.font = font
        self.textLabel.adjustsFontForContentSizeCategory = true
        self.textLabel.textColor = self.colors.textColor.uiColor

        let captionFont = self.theming.typography.caption.uiFont
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

    @IBAction func actionTapped(sender: UIButton) {
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

    @IBAction func actionTouchDown(sender: UIButton) {
        self.isPressed = true
    }

    @IBAction func actionTouchUp(sender: UIButton) {
        self.isPressed = false
    }
}
