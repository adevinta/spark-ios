//
//  TextEditorUIView.swift
//  SparkCore
//
//  Created by alican.aycil on 23.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine

/// Spark TextEditorUIView, subclasses UITextView
public final class TextEditorUIView: UITextView {

    private let viewModel: TextEditorViewModel
    private var cancellables = Set<AnyCancellable>()

    @ScaledUIMetric private var minHeight: CGFloat = 44
    @ScaledUIMetric private var minWidth: CGFloat = 280
    @ScaledUIMetric private var defaultSystemVerticalPadding: CGFloat = 8
    @ScaledUIMetric private var horizontalSpacing: CGFloat
    @ScaledUIMetric private var borderWidth: CGFloat

    /// The textfield's current theme.
    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.theme = newValue
        }
    }

    /// The textfield's current intent.
    public var intent: TextEditorIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    /// The textfield's current intent.
    public var placeHolder: String? {
        get {
            return self.placeHolderLabel.text
        }
        set {
            self.placeHolderLabel.text = newValue
        }
    }

    /// The textfield's current intent.
    public var isEnabled: Bool {
        get {
            return self.viewModel.isEnabled
        }
        set {
            self.viewModel.isEnabled = newValue
        }
    }

    public var isReadOnly: Bool {
        get {
            return self.viewModel.isReadOnly
        }
        set {
            self.viewModel.isReadOnly = newValue
        }
    }

    private weak var _delegate: UITextViewDelegate?

    public override var delegate: UITextViewDelegate? {
            set {
                self._delegate = newValue
            }
            get {
                return self._delegate
            }
        }

    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /// TextEditorUIView initializer
    /// - Parameters:
    ///   - theme: The textfield's current theme
    ///   - intent: The textfield's current intent
    public init(
        theme: Theme,
        intent: TextEditorIntent
    ) {
        let viewModel = TextEditorViewModel(
            theme: theme,
            intent: intent
        )
        self.viewModel = viewModel
        self.horizontalSpacing = viewModel.horizontalSpacing
        self.borderWidth = viewModel.borderWidth

        super.init(
            frame: .zero,
            textContainer: nil
        )
        super.delegate = self

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.accessibilityIdentifier = TextEditorAccessibilityIdentifier.view
        self.adjustsFontForContentSizeCategory = true
        self.showsHorizontalScrollIndicator = false

        self.subscribeToViewModel()
        self.setupLayout()
    }

    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.textContainer.lineFragmentPadding = 0
        self.textContainerInset = UIEdgeInsets(
            top: self.defaultSystemVerticalPadding,
            left: self.horizontalSpacing,
            bottom: self.defaultSystemVerticalPadding,
            right: self.horizontalSpacing
        )

        
        self.addSubview(self.placeHolderLabel)
        self.hidePlaceHolder(!self.text.isEmpty)

        NSLayoutConstraint.activate([
            /// Self
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minHeight),
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.minWidth),

            /// Placeholder Label
            self.placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.defaultSystemVerticalPadding),
            self.placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.horizontalSpacing),
            self.placeHolderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.horizontalSpacing),
            self.placeHolderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.placeHolderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -2 * self.borderWidth),
            self.placeHolderLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
    }


    private func subscribeToViewModel() {
        self.viewModel.$textColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        }).subscribe(in: &self.cancellables) { [weak self] textColor in
            guard let self else { return }
            self.textColor = textColor.uiColor
            self.tintColor = textColor.uiColor
        }

        self.viewModel.$placeholderColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        }).subscribe(in: &self.cancellables) { [weak self] placeholderColor in
            guard let self else { return }
            self.placeHolderLabel.textColor = placeholderColor.uiColor
        }

        self.viewModel.$backgroundColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        }).subscribe(in: &self.cancellables) { [weak self] backgroundColor in
            guard let self else { return }
            self.backgroundColor = backgroundColor.uiColor
        }

        self.viewModel.$borderColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        }).subscribe(in: &self.cancellables) { [weak self] borderColor in
            guard let self else { return }
            self.setBorderColor(from: borderColor)
        }

        self.viewModel.$borderWidth.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] borderWidth in
            guard let self else { return }
            self.setBorderWidth(self.borderWidth)
        }

        self.viewModel.$borderRadius.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] borderRadius in
            guard let self else { return }
            self.setCornerRadius(borderRadius)
        }

        self.viewModel.$horizontalSpacing.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] spacing in
            guard let self else { return }
            self.horizontalSpacing = spacing
            self.setNeedsLayout()
        }

        self.viewModel.$font.subscribe(in: &self.cancellables) { [weak self] font in
            guard let self else { return }
            self.font = font.uiFont
            self.placeHolderLabel.font = font.uiFont
        }
    }

    public override func becomeFirstResponder() -> Bool {
        let bool = super.becomeFirstResponder()
        self.viewModel.isFocused = bool
        return bool
    }

    public override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.viewModel.isFocused = false
        return true
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard previousTraitCollection?.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory else { return }

        self._minHeight.update(traitCollection: self.traitCollection)
        self._minWidth.update(traitCollection: self.traitCollection)
        self._borderWidth.update(traitCollection: self.traitCollection)
        self._horizontalSpacing.update(traitCollection: self.traitCollection)
        self._defaultSystemVerticalPadding.update(traitCollection: self.traitCollection)
        self.setBorderWidth(self.borderWidth)
    }

    private func hidePlaceHolder(_ value: Bool) {
        self.placeHolderLabel.isHidden = value
    }
}

extension TextEditorUIView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        self.hidePlaceHolder(!textView.text.isEmpty)
        self._delegate?.textViewDidChange?(textView)
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        self._delegate?.textViewDidChangeSelection?(textView)
    }

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return self._delegate?.textViewShouldEndEditing?(textView) ?? true
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.hidePlaceHolder(true)
        self._delegate?.textViewDidBeginEditing?(textView)
    }

    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return self._delegate?.textViewShouldEndEditing?(textView) ?? true
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        self.hidePlaceHolder(!textView.text.isEmpty)
        self._delegate?.textViewDidEndEditing?(textView)
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn: NSRange, replacementText: String) -> Bool {
        self._delegate?.textView?(textView, shouldChangeTextIn: shouldChangeTextIn, replacementText: replacementText) ?? true
    }
}
