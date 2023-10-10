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
public final class CheckboxUIView: UIControl {

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
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var controlView: CheckboxControlUIView = {
        let controlView = CheckboxControlUIView(
            selectionIcon: self.checkedImage,
            colors: self.viewModel.colors,
            isEnabled: self.isEnabled,
            selectionState: self.selectionState,
            isPressed: self.isPressed
        )
        controlView.isAccessibilityElement = false
        return controlView
    }()

    private lazy var stackView: UIStackView = {
        let arrangedSubviews = self.alignment == .left ? [controlView, textLabel] : [textLabel, controlView]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.spacing = self.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        return stackView
    }()

    private var cancellables = Set<AnyCancellable>()
    private var checkboxSelectionStateSubject = PassthroughSubject<CheckboxSelectionState, Never>()

    private var stackViewSpacing: CGFloat {
        let spacing = self.alignment == .left ? self.theme.layout.spacing.medium : (self.theme.layout.spacing.medium * 3)
        return self.fontMetrics.scaledValue(for: spacing, compatibleWith: self.traitCollection)
    }
    private var fontMetrics = UIFontMetrics(forTextStyle: .body)
    @ScaledUIMetric private var checkboxSize: CGFloat = CheckboxControlUIView.Constants.size
    private var checkboxSizeConstraint: NSLayoutConstraint?

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

    /// The checkedImage displayed in the checkbox when status is selected.
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

    /// The current state of the checkbox.
    public override var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
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

    /// Returns the intent of the checkbox.
    public var intent: CheckboxIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    /// Returns the alignment of the checkbox.
    public var alignment: CheckboxAlignment {
        get {
            return self.viewModel.alignment
        }
        set {
            self.viewModel.alignment = newValue
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
    ///   - intent: The current Intent.
    ///   - text: The checkbox text.
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - isEnabled: IsEnabled describes whether the checkbox is enabled or disabled.
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
            isEnabled: isEnabled,
            selectionState: selectionState,
            checkboxAlignment: checkboxAlignment
        )
    }

    /// Initialize a new checkbox UIKit-view.
    /// - Parameters:
    ///   - theme: The current Spark-Theme.
    ///   - intent: The current Intent.
    ///   - attributedText: The checkbox attributeText.
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - isEnabled: IsEnabled describes whether the checkbox is enabled or disabled.
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
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        checkboxAlignment: CheckboxAlignment
    ) {
        self.viewModel = .init(
            text: content,
            checkedImage: checkedImage,
            theme: theme,
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
    
    // MARK: - Methods
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.stackView)
        self.addSubview(self.button)
        
        NSLayoutConstraint.stickEdges(from: self.button, to: self)
        NSLayoutConstraint.stickEdges(from: self.stackView, to: self)

        let checkboxWidthConstraint = self.controlView.widthAnchor.constraint(equalToConstant: self.checkboxSize)
        self.checkboxSizeConstraint = checkboxWidthConstraint

        NSLayoutConstraint.activate([
            checkboxWidthConstraint,
            self.controlView.heightAnchor.constraint(equalTo: self.controlView.widthAnchor),
            self.textLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: self.checkboxSize),
            self.heightAnchor.constraint(equalTo: textLabel.heightAnchor)
        ])
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory else { return }

        self._checkboxSize.update(traitCollection: self.traitCollection)
        self.checkboxSizeConstraint?.constant = self.checkboxSize
        self.stackView.spacing = self.stackViewSpacing
    }

    private func subscribe() {
        self.viewModel.$colors.subscribe(in: &self.cancellables) { [weak self] _ in
            guard let self else { return }
            self.updateTheme()
        }

        self.viewModel.$opacity.subscribe(in: &self.cancellables) { [weak self] opacity in
            guard let self else { return }
            self.layer.opacity = Float(opacity)
        }

        self.viewModel.$selectionState.subscribe(in: &self.cancellables) { [weak self] selectionState in
            guard let self else { return }
            self.controlView.selectionState = selectionState
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self else { return }
            self.updateAlignment()
        }

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] text in
            guard let self else { return }
            self.textLabel.isHidden = text.isEmpty
            self.textLabel.text = text
            self.textLabel.font = self.theme.typography.body1.uiFont
            self.textLabel.textColor = self.viewModel.colors.textColor.uiColor
        }

        self.viewModel.$attributedText.subscribe(in: &self.cancellables) { [weak self] attributedText in
            guard let self else { return }
            self.textLabel.attributedText = attributedText

            if let attributes = attributedText?.attributes(at: 0, effectiveRange: nil),
               let font = attributes[NSAttributedString.Key.font] as? UIFont {
                self.textLabel.font = self.fontMetrics.scaledFont(for: font, compatibleWith: self.traitCollection)
            }
        }

        self.viewModel.$checkedImage.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self else { return }
            self.controlView.selectionIcon = icon
        }
    }
}

// MARK: Updates
private extension CheckboxUIView {

    private func updateAccessibility() {
        if self.selectionState == .selected {
            self.accessibilityTraits.insert(.selected)
        } else {
            self.accessibilityTraits.remove(.selected)
        }

        if !isEnabled {
            self.accessibilityTraits.insert(.notEnabled)
        } else {
            self.accessibilityTraits.remove(.notEnabled)
        }

        self.accessibilityLabel = [self.viewModel.text].compactMap { $0 }.joined(separator: ". ")
    }

    private func updateTheme() {
        self.controlView.colors = self.viewModel.colors

        if self.attributedText == nil {
            self.textLabel.textColor = self.viewModel.colors.textColor.uiColor
        } else {
            self.textLabel.alpha = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
        }
    }

    private func updateAlignment() {
        self.stackView.spacing = self.stackViewSpacing
        self.stackView.insertArrangedSubview(self.alignment == .left ? self.controlView : self.textLabel, at: 0)
    }

    private func update(content: Either<NSAttributedString, String>) {
        self.viewModel.update(content: content)
    }
}

// MARK: Actions
private extension CheckboxUIView {

    @IBAction func actionTapped(sender: UIButton) {
        self.isPressed = false

        guard self.isEnabled else { return }

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
        guard self.isEnabled else { return }
        self.isPressed = true
    }

    @IBAction private func actionTouchUp(sender: UIButton) {
        self.isPressed = false
    }
}
