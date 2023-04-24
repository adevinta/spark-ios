//
//  CheckboxUIView.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public final class CheckboxUIView: UIView {

    // MARK: - Private properties.

    private let button = UIButton()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    private var supplementaryTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    private lazy var controlView: CheckboxControlUIView = {
        let controlView = CheckboxControlUIView(selectionIcon: theming.theme.iconography.checkmark.uiImage)
        controlView.translatesAutoresizingMaskIntoConstraints = false
        return controlView
    }()

    private var controlViewWidthConstraint: NSLayoutConstraint?
    private var controlViewHeightConstraint: NSLayoutConstraint?
    private var textLabelBottomConstraint: NSLayoutConstraint?

    private var checkboxPosition: CheckboxPosition = .left

    // MARK: - Public properties.

    public weak var delegate: CheckboxUIViewDelegate?
    public var selectionStateHandler: ((_ state: CheckboxSelectionState) -> Void)?

    public var text: String {
        get {
            viewModel.text
        }
        set {
            viewModel.text = newValue
            textLabel.text = text
        }
    }

    public var selectionState: CheckboxSelectionState = .unselected {
        didSet {
            controlView.selectionState = selectionState
        }
    }

    public var state: SelectButtonState {
        didSet {
            viewModel.state = state
            colors = colorsUseCase.execute(from: theming, state: state)

            updateState()
            updateViewConstraints()
        }
    }
    public var theming: CheckboxTheming

    var colors: CheckboxColorables {
        get {
            viewModel.colors
        }
        set {
            viewModel.colors = newValue
            updateTheme()
        }
    }
    var colorsUseCase: CheckboxColorsUseCaseable {
        didSet {
            colors = colorsUseCase.execute(from: theming, state: state)
        }
    }

    var viewModel: CheckboxViewModel

    var isPressed: Bool = false {
        didSet {
            controlView.isPressed = isPressed
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    public convenience init(
        theming: CheckboxTheming,
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
        theming: CheckboxTheming,
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
        translatesAutoresizingMaskIntoConstraints = false
        controlView.selectionState = selectionState

        textLabel.text = text
        addSubview(textLabel)

        addSubview(controlView)

        let view = self
        switch checkboxPosition {
        case .left:
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: 4).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            textLabelBottomConstraint?.isActive = true

            controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4).isActive = true
            controlViewWidthConstraint = controlView.widthAnchor.constraint(equalToConstant: 28)
            controlViewWidthConstraint?.isActive = true
            controlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: 28)
            controlViewHeightConstraint?.isActive = true
            controlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -4).isActive = true

        case .right:
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: -4).isActive = true
            textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            textLabelBottomConstraint?.isActive = true

            controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -4).isActive = true
            controlViewWidthConstraint = controlView.widthAnchor.constraint(equalToConstant: 28)
            controlViewWidthConstraint?.isActive = true
            controlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: 28)
            controlViewHeightConstraint?.isActive = true
            controlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 4).isActive = true
        }

        button.addTarget(self, action: #selector(actionTapped(sender:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(actionTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(actionTouchUp(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(actionTouchUp(sender:)), for: .touchCancel)

        button.translatesAutoresizingMaskIntoConstraints = true
        button.frame = self.bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(button)

        updateTheme()
        updateState()
        updateViewConstraints()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateViewConstraints()
    }


    private func updateViewConstraints() {
        let bodyFontMetrics = UIFontMetrics(forTextStyle: .body)
        let scaledSpacing = bodyFontMetrics.scaledValue(for: 20.0, compatibleWith: traitCollection) + 8

        controlViewWidthConstraint?.constant = scaledSpacing
        controlViewHeightConstraint?.constant = scaledSpacing

        if let supplementaryMessage = supplementaryMessage {
            supplementaryTextLabel.text = supplementaryMessage

            if supplementaryTextLabel.superview == nil {
                addSubview(supplementaryTextLabel)

                if let bottomConstraint = textLabelBottomConstraint {
                    NSLayoutConstraint.deactivate([bottomConstraint])
                }

                supplementaryTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
                supplementaryTextLabel.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor).isActive = true
                supplementaryTextLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor).isActive = true
                supplementaryTextLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            }
        } else {
            if supplementaryTextLabel.superview != nil {
                supplementaryTextLabel.removeFromSuperview()
            }

            if let bottomConstraint = textLabelBottomConstraint {
                NSLayoutConstraint.deactivate([bottomConstraint])
            }
            textLabelBottomConstraint = textLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
            textLabelBottomConstraint?.isActive = true
        }

        setNeedsLayout()
    }

    var interactionEnabled: Bool {
        viewModel.interactionEnabled
    }

    var opacity: CGFloat {
        viewModel.opacity
    }

    var supplementaryMessage: String? {
        viewModel.supplementaryMessage
    }

    private func updateTheme() {
        controlView.colors = colors

        let font = theming.theme.typography.body1.uiFont
        textLabel.font = font
        textLabel.adjustsFontForContentSizeCategory = true
        textLabel.textColor = colors.textColor.uiColor

        let captionFont = theming.theme.typography.caption.uiFont
        supplementaryTextLabel.font = captionFont
        supplementaryTextLabel.adjustsFontForContentSizeCategory = true
        supplementaryTextLabel.textColor = colors.checkboxTintColor.uiColor
    }

    private func updateState() {
        let opacity = self.opacity
        textLabel.alpha = opacity
        controlView.alpha = opacity
        supplementaryTextLabel.alpha = opacity
    }

    @IBAction func actionTapped(sender: UIButton) {
        isPressed = false

        guard interactionEnabled else { return }
        switch selectionState {
        case .selected:
            selectionState = .unselected
        case .unselected:
            selectionState = .selected
        case .indeterminate:
            break
        }
        selectionStateHandler?(selectionState)
        delegate?.checkbox(self, didChangeSelection: selectionState)
    }

    @IBAction func actionTouchDown(sender: UIButton) {
        isPressed = true
    }

    @IBAction func actionTouchUp(sender: UIButton) {
        isPressed = false
    }

    public override var bounds: CGRect {
        didSet {
            print("new bounds", bounds)
        }
    }
}
