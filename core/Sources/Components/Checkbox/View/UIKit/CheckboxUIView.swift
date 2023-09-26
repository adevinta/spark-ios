//
//  CheckboxUIView.swift
//  SparkCore
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
        static var checkboxSize: CGFloat = 28
    }

    // MARK: - Private Properties.

    private lazy var button: UIButton = {
        let button = UIButton()
        button.isAccessibilityElement = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.actionTapped(sender:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(self.actionTouchDown(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.actionTouchUp(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(self.actionTouchUp(sender:)), for: .touchCancel)
        return button
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.isAccessibilityElement = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()

    private lazy var controlView: CheckboxControlUIView = {
        let controlView = CheckboxControlUIView(
            selectionIcon: self.viewModel.checkedImage,
            theme: self.theme,
            isEnabled: self.isEnabled
        )
        controlView.isAccessibilityElement = false
        return controlView
    }()

    private lazy var stackView: UIStackView = {
        let arrangedSubviews = self.alignment == .left ? [controlView, textLabel] : [textLabel, controlView]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.spacing = self.alignment == .left ? self.theme.layout.spacing.medium : (self.theme.layout.spacing.medium * 3)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        return stackView
    }()

    private var cancellables = Set<AnyCancellable>()
    private var checkboxSelectionStateSubject = PassthroughSubject<CheckboxSelectionState, Never>()

    // MARK: - Public properties.

    /// Changes to the checbox state are published to the publisher.
    public var publisher: some Publisher<CheckboxSelectionState, Never> {
        return self.viewModel.$selectionState
            .eraseToAnyPublisher()
    }

    /// Set a delegate to receive selection state change callbacks. Alternatively, you can use bindings.
    public weak var delegate: CheckboxUIViewDelegate?

    /// The text displayed in the checkbox.
    public var text: String? {
        get {
            return self.viewModel.text
        }
        set {
            self.update(content: .right(newValue ?? ""))
        }
    }

    /// The attributed text displayed in the checkbox.
    public var attributedText: NSAttributedString? {
        get {
            return self.viewModel.attributedText
        }
        set {
            if let attributedText = newValue {
                self.update(content: .left(attributedText))
            } else {
                self.update(content: .right(""))
            }
        }
    }

    public var checkedImage: UIImage {
        get {
            return self.viewModel.checkedImage
        }
        set {
            self.viewModel.checkedImage = newValue
        }
    }

    /// The current selection state of the checkbox.
    public var selectionState: CheckboxSelectionState {
        get {
            return self.viewModel.selectionState
        }
        set {
            self.viewModel.selectionState = newValue
        }
    }

    /// The control state of the checkbox (e.g. `.enabled` or `.disabled`).
    public var state: SelectButtonState {
        get {
            return self.viewModel.isEnabled ? .enabled : .disabled
        }
        set {
            let state: SelectButtonState = self.viewModel.isEnabled ? .enabled : .disabled
            guard newValue != state else { return }
            self.viewModel.isEnabled = newValue == .enabled
        }
    }

    public var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            guard newValue != self.viewModel.isEnabled else { return }
            self.viewModel.isEnabled = newValue
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

    public var intent: CheckboxIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    public var alignment: CheckboxAlignment {
        get {
            return self.viewModel.alignment
        }
        set {
            self.viewModel.alignment = newValue
        }
    }

    var colorsUseCase: CheckboxStateColorsUseCaseable {
        get {
            return self.viewModel.colorsUseCase
        }
        set {
            self.viewModel.colorsUseCase = newValue
        }
    }

    var isPressed: Bool = false {
        didSet {
            self.controlView.isPressed = self.isPressed
        }
    }

    var viewModel: CheckboxViewModel

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
    ///   - checkboxAlignment: Positions the checkbox on the leading or trailing edge of the view.
    public convenience init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        text: String,
        checkedImage: UIImage,
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        checkboxAlignment: CheckboxAlignment
    ) {
        self.init(
            theme: theme,
            intent: intent,
            content: .right(text),
            checkedImage: checkedImage,
            colorsUseCase: CheckboxStateColorsUseCase(),
            isEnabled: isEnabled,
            selectionState: selectionState,
            checkboxAlignment: checkboxAlignment
        )
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - text: The checkbox text.
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - state: The control state describes whether the checkbox is enabled or disabled as well as options for displaying success and error messages.
    ///   - selectionState: `CheckboxSelectionState` is either selected, unselected or indeterminate.
    ///   - checkboxAlignment: Positions the checkbox on the leading or trailing edge of the view.
    public convenience init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        attributedText: NSAttributedString,
        checkedImage: UIImage,
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        checkboxAlignment: CheckboxAlignment
    ) {
        self.init(
            theme: theme,
            intent: intent,
            content: .left(attributedText),
            checkedImage: checkedImage,
            colorsUseCase: CheckboxStateColorsUseCase(),
            isEnabled: isEnabled,
            selectionState: selectionState,
            checkboxAlignment: checkboxAlignment
        )
    }

    init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        content: Either<NSAttributedString, String>,
        checkedImage: UIImage,
        colorsUseCase: CheckboxStateColorsUseCaseable = CheckboxStateColorsUseCase(),
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        checkboxAlignment: CheckboxAlignment
    ) {
        self.viewModel = .init(
            text: content,
            checkedImage: checkedImage,
            theme: theme,
            colorsUseCase:colorsUseCase,
            isEnabled: isEnabled,
            alignment: checkboxAlignment,
            selectionState: selectionState
        )
        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.accessibilityIdentifier = CheckboxAccessibilityIdentifier.checkbox

        self.setupViews()
        self.subscribe()

        self.updateAccessibility()
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.stackView)
        self.addSubview(self.button)
        
        NSLayoutConstraint.stickEdges(from: self.button, to: self)
        NSLayoutConstraint.stickEdges(from: self.stackView, to: self)

        NSLayoutConstraint.activate([
            self.controlView.heightAnchor.constraint(equalToConstant: Constants.checkboxSize),
            self.controlView.widthAnchor.constraint(equalToConstant: Constants.checkboxSize),
            self.textLabel.heightAnchor.constraint(greaterThanOrEqualTo: controlView.heightAnchor)
        ])
    }

    private func subscribe() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] _ in
            guard let self else { return }
            self.updateTheme()
            self.updateState()
        }

        self.viewModel.$colors.subscribe(in: &self.cancellables) { [weak self] _ in
            guard let self else { return }
            self.updateTheme()
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] _ in
            guard let self else { return }
            self.updateState()
            self.updateAccessibility()
        }

        self.viewModel.$selectionState.subscribe(in: &self.cancellables) { [weak self] selectionState in
            guard let self else { return }
            self.controlView.selectionState = selectionState
            self.updateAccessibility()
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self else { return }
            self.updateAlignment(alignment)
        }

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] text in
            guard let self else { return }
            self.textLabel.text = text
            self.textLabel.font = self.theme.typography.body1.uiFont
            self.textLabel.textColor = self.viewModel.colors.enable.textColor.uiColor
        }

        self.viewModel.$attributedText.subscribe(in: &self.cancellables) { [weak self] attributedText in
            guard let self else { return }
            self.textLabel.attributedText = attributedText
        }

        self.viewModel.$checkedImage.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self else { return }
            self.controlView.selectionIcon = icon
        }
    }
}

// MARK: Updates
private extension CheckboxUIView {

    private func updateState() {
        self.textLabel.alpha = self.viewModel.opacity
        self.controlView.alpha = self.viewModel.opacity
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

        self.accessibilityLabel = [self.viewModel.text].compactMap { $0 }.joined(separator: ". ")
    }

    private func updateTheme() {
        self.controlView.theme = self.theme
        self.controlView.colors = self.viewModel.colors

        if self.attributedText == nil {
            self.textLabel.font = self.theme.typography.body1.uiFont
            self.textLabel.textColor = self.viewModel.colors.enable.textColor.uiColor
        }
    }

    private func updateAlignment(_ alignment: CheckboxAlignment) {
        let isAlignmentLeft = alignment == .left
        self.stackView.spacing = isAlignmentLeft ? self.theme.layout.spacing.medium : (self.theme.layout.spacing.medium * 3)
        self.stackView.insertArrangedSubview(isAlignmentLeft ? self.controlView : self.textLabel, at: 0)
    }

    private func update(content: Either<NSAttributedString, String>) {
        self.viewModel.update(content: content)
    }
}

// MARK: Actions
private extension CheckboxUIView {

    @IBAction func actionTapped(sender: UIButton) {
        self.isPressed = false

        guard self.viewModel.interactionEnabled else { return }
        switch self.selectionState {
        case .selected:
            self.selectionState = .unselected
        case .unselected, .indeterminate:
            self.selectionState = .selected
        }
        self.delegate?.checkbox(self, didChangeSelection: self.selectionState)
        self.checkboxSelectionStateSubject.send(self.selectionState)
    }

    @IBAction private func actionTouchDown(sender: UIButton) {
        guard self.viewModel.interactionEnabled else { return }
        self.isPressed = true
    }

    @IBAction private func actionTouchUp(sender: UIButton) {
        self.isPressed = false
    }
}
