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
            isHighlighted: self.isHighlighted
        )
        controlView.isAccessibilityElement = false
        return controlView
    }()

    private lazy var stackView: UIStackView = {
        let arrangedSubviews = self.alignment == .left ? [controlView, textLabel] : [textLabel, controlView]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.isUserInteractionEnabled = false
        return stackView
    }()

    private var cancellables = Set<AnyCancellable>()
    private var checkboxSelectionStateSubject = PassthroughSubject<CheckboxSelectionState, Never>()
    @ScaledUIMetric private var checkboxSize: CGFloat = CheckboxControlUIView.Constants.size
    @ScaledUIMetric private var spacing: CGFloat
    
    private var checkboxSizeConstraint: NSLayoutConstraint?
    private var textObserver: NSKeyValueObservation?
    private var attributedTextObserver: NSKeyValueObservation?
    
    // MARK: - Public properties.

    /// Changes to the checbox state are published to the publisher.
    public var publisher: some Publisher<CheckboxSelectionState, Never> {
        return self.viewModel.$selectionState
            .dropFirst()
            .eraseToAnyPublisher()
    }

    /// Set a delegate to receive selection state change callbacks. Alternatively, you can use bindings.
    public weak var delegate: CheckboxUIViewDelegate?

    /// The text displayed in the checkbox.
    public var text: String? {
        get {
            return self.textLabel.text
        }
        set {
            self.viewModel.text = .left(newValue.map(NSAttributedString.init))
        }
    }

    /// The attributed text displayed in the checkbox.
    public var attributedText: NSAttributedString? {
        get {
            return self.textLabel.attributedText
        }
        set {
            self.viewModel.text = .left(newValue)
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

    /// The current state of the checkbox.
    public override var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.isEnabled = newValue
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            self.controlView.isHighlighted = self.isHighlighted
        }
    }

    public override var isSelected: Bool {
        get {
            return self.selectionState == .selected
        }
        set {
            if newValue == true {
                self.selectionState = .selected
            }
            else {
                self.selectionState = .unselected
            }
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
    ///   - alignment: Positions the checkbox on the leading or trailing edge of the view.
    public convenience init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        text: String,
        checkedImage: UIImage,
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        alignment: CheckboxAlignment
    ) {
        self.init(
            theme: theme,
            intent: intent,
            content: .left(NSAttributedString(string: text)),
            checkedImage: checkedImage,
            isEnabled: isEnabled,
            selectionState: selectionState,
            alignment: alignment
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
    ///   - alignment: Positions the checkbox on the leading or trailing edge of the view.
    public convenience init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        attributedText: NSAttributedString,
        checkedImage: UIImage,
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        alignment: CheckboxAlignment
    ) {
        self.init(
            theme: theme,
            intent: intent,
            content: .left(attributedText),
            checkedImage: checkedImage,
            isEnabled: isEnabled,
            selectionState: selectionState,
            alignment: alignment
        )
    }

    init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        content: Either<NSAttributedString?, String?>,
        checkedImage: UIImage,
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState,
        alignment: CheckboxAlignment
    ) {
        let viewModel = CheckboxViewModel(
            text: content,
            checkedImage: checkedImage,
            theme: theme,
            isEnabled: isEnabled,
            alignment: alignment,
            selectionState: selectionState
        )
        self.spacing = viewModel.spacing
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.accessibilityIdentifier = CheckboxAccessibilityIdentifier.checkbox
        
        self.setupViews()
        self.subscribe()
        self.updateAccessibility()
        self.addActions()
        self.addObservers()
    }
    
    // MARK: - Methods
    private func addActions() {
        let toggleAction = UIAction { [weak self] _ in
            guard let self else { return }
            if self.selectionState == .indeterminate {
                self.isSelected = true
            } else {
                self.isSelected.toggle()
            }
            self.delegate?.checkbox(self, didChangeSelection: self.selectionState)
            self.checkboxSelectionStateSubject.send(self.selectionState)
        }
        self.addAction(toggleAction, for: .touchUpInside)
    }

    private func addObservers() {
        self.textObserver = textLabel.observe(\UILabel.text, options: [.new, .old]) { [weak self] (label, observedChange) in
            if let newText = observedChange.newValue,
               let oldText = observedChange.oldValue,
               newText != oldText {
                self?.text = newText
            }
        }

        self.attributedTextObserver = textLabel.observe(\UILabel.attributedText, options: [.new, .old]) { [weak self] (label, observedChange) in
            if let newText = observedChange.newValue,
               let oldText = observedChange.oldValue,
               newText != oldText {
                self?.attributedText = newText
            }
        }
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.stackView)

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
        self._spacing.update(traitCollection: traitCollection)
        self.stackView.spacing = self.spacing
    }

    private func subscribe() {
        self.viewModel.$colors.subscribe(in: &self.cancellables) { [weak self] colors in
              guard let self else { return }
              self.updateTheme(colors: colors)
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
            self.updateAlignment(alignment: alignment)
        }

        self.viewModel.$text.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] text in
            guard let self else { return }
            self.textLabel.font = self.viewModel.font.uiFont
            self.textLabel.attributedText = text.leftValue
        }

        self.viewModel.$checkedImage.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self else { return }
            self.controlView.selectionIcon = icon
        }
        
        self.viewModel.$spacing.subscribe(in: &self.cancellables) { [weak self] spacing in
            guard let self = self else { return }
            self._spacing.wrappedValue = spacing
            self.stackView.spacing = self.spacing
        }
    }

    deinit {
        self.textObserver?.invalidate()
        self.attributedTextObserver?.invalidate()
    }
}

// MARK: Updates
private extension CheckboxUIView {

    private func updateAccessibility() {
        self.accessibilityLabel = self.textLabel.text
    }

    private func updateTheme(colors: CheckboxColors) {
        self.controlView.colors = colors
        self.textLabel.textColor = self.viewModel.colors.textColor.uiColor
        self.textLabel.alpha = self.viewModel.opacity
        self.textLabel.attributedText = self.viewModel.text.leftValue
    }

    private func updateAlignment(alignment: CheckboxAlignment) {
        self.stackView.spacing = self.spacing
        self.stackView.insertArrangedSubview(alignment == .left ? self.controlView : self.textLabel, at: 0)
    }
}
