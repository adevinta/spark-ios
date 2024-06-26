//
//  TextFieldUIView.swift
//  SparkCore
//
//  Created by louis.borlee on 05/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine

/// Spark TextField, subclasses UITextField
public final class TextFieldUIView: UITextField {

    private let viewModel: TextFieldViewModel
    private var cancellables = Set<AnyCancellable>()

    @ScaledUIMetric private var height: CGFloat = 44
    @ScaledUIMetric private var scaleFactor: CGFloat = 1.0

    private let defaultClearButtonRightSpacing = 5.0

    public override var placeholder: String? {
        didSet {
            self.setPlaceholder(self.placeholder, foregroundColor: self.viewModel.placeholderColor, font: self.viewModel.font)
        }
    }

    public override var isEnabled: Bool {
        didSet {
            self.viewModel.isEnabled = self.isEnabled
        }
    }

    public override var isUserInteractionEnabled: Bool {
        didSet {
            self.viewModel.isUserInteractionEnabled = self.isUserInteractionEnabled
        }
    }

    public override var borderStyle: UITextField.BorderStyle {
        @available(*, unavailable)
        set {}
        get { return .init(self.viewModel.borderStyle) }
    }

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
    public var intent: TextFieldIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.intent = newValue
        }
    }

    internal init(viewModel: TextFieldViewModel) {
        self.viewModel = viewModel
        super.init(frame: .init(origin: .zero, size: .init(width: 0, height: 44)))
        self.adjustsFontForContentSizeCategory = true
        self.adjustsFontSizeToFitWidth = false
        self.setupView()
    }

    internal convenience init(
        theme: Theme,
        intent: TextFieldIntent,
        borderStyle: TextFieldBorderStyle
    ) {
        self.init(
            viewModel: .init(
                theme: theme,
                intent: intent,
                borderStyle: borderStyle
            )
        )
    }

    /// TextFieldUIView initializer
    /// - Parameters:
    ///   - theme: The textfield's current theme
    ///   - intent: The textfield's current intent
    public convenience init(
        theme: Theme,
        intent: TextFieldIntent
    ) {
        self.init(
            theme: theme,
            intent: intent,
            borderStyle: .roundedRect
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.subscribeToViewModel()
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.accessibilityIdentifier = TextFieldAccessibilityIdentifier.view
    }

    private func subscribeToViewModel() {
        self.viewModel.$textColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        })
        .subscribe(in: &self.cancellables) { [weak self] textColor in
            guard let self else { return }
            self.textColor = textColor.uiColor
            self.tintColor = textColor.uiColor
        }

        self.viewModel.$backgroundColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        })
        .subscribe(in: &self.cancellables) { [weak self] backgroundColor in
            guard let self else { return }
            self.backgroundColor = backgroundColor.uiColor
        }

        self.viewModel.$borderColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        })
        .subscribe(in: &self.cancellables) { [weak self] borderColor in
            guard let self else { return }
            self.setBorderColor(from: borderColor)
        }

        self.viewModel.$placeholderColor.removeDuplicates(by: { lhs, rhs in
            lhs.equals(rhs)
        })
        .subscribe(in: &self.cancellables) { [weak self] placeholderColor in
            guard let self else { return }
            self.setPlaceholder(self.placeholder, foregroundColor: placeholderColor, font: self.viewModel.font)
        }

        self.viewModel.$borderWidth.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] borderWidth in
            guard let self else { return }
            self.setBorderWidth(borderWidth * self.scaleFactor)
        }

        self.viewModel.$borderRadius.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] borderRadius in
            guard let self else { return }
            self.setCornerRadius(borderRadius * self.scaleFactor)
        }

        self.viewModel.$leftSpacing.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] dim in
            guard let self else { return }
            self.setNeedsLayout()
        }

        self.viewModel.$rightSpacing.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] dim in
            guard let self else { return }
            self.setNeedsLayout()
        }

        self.viewModel.$contentSpacing.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] dim in
            guard let self else { return }
            self.setNeedsLayout()
        }

        self.viewModel.$dim.removeDuplicates().subscribe(in: &self.cancellables) { [weak self] dim in
            guard let self else { return }
            self.alpha = dim
        }

        self.viewModel.$font.subscribe(in: &self.cancellables) { [weak self] font in
            guard let self else { return }
            self.font = font.uiFont
            self.setPlaceholder(self.placeholder, foregroundColor: self.viewModel.placeholderColor, font: font)
        }
    }

    private func setAttributedPlaceholder(string: String, foregroundColor: UIColor, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [
                NSAttributedString.Key.foregroundColor: foregroundColor,
                NSAttributedString.Key.font: font
            ]
        )
    }

    private func setPlaceholder(_ placeholder: String?, foregroundColor: any ColorToken, font: TypographyFontToken) {
        if let placeholder {
            self.setAttributedPlaceholder(string: placeholder, foregroundColor: foregroundColor.uiColor, font: font.uiFont)
        } else {
            self.attributedPlaceholder = nil
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

    // MARK: - Rects
    private func setInsets(forBounds bounds: CGRect) -> CGRect {
        var totalInsets = UIEdgeInsets(
            top: 0,
            left: self.viewModel.leftSpacing,
            bottom: 0,
            right: self.viewModel.rightSpacing
        )
        let contentSpacing = self.viewModel.contentSpacing
        if let leftView,
           leftView.isDescendant(of: self) {
            totalInsets.left += leftView.bounds.size.width + contentSpacing
        }
        if let rightView,
           rightView.isDescendant(of: self) {
            totalInsets.right += rightView.bounds.size.width + contentSpacing
        }
        if let clearButton = self.value(forKeyPath: "_clearButton") as? UIButton,
           clearButton.isDescendant(of: self) {
            totalInsets.right += clearButton.bounds.size.width + contentSpacing
        }
        return bounds.inset(by: totalInsets)
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.setInsets(forBounds: bounds)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.setInsets(forBounds: bounds)
    }
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.setInsets(forBounds: bounds)
    }

    private func getClearButtonXOffset() -> CGFloat {
        return -self.viewModel.rightSpacing + self.defaultClearButtonRightSpacing
    }

    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return super.clearButtonRect(forBounds: bounds)
            .offsetBy(dx: self.getClearButtonXOffset(), dy: 0)
    }

    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return super.leftViewRect(forBounds: bounds)
            .offsetBy(dx: self.viewModel.leftSpacing, dy: 0)
    }

    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return super.rightViewRect(forBounds: bounds)
            .offsetBy(dx: -self.viewModel.rightSpacing, dy: 0)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.setBorderColor(from: self.viewModel.borderColor)
        }

        guard previousTraitCollection?.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory else { return }

        self._height.update(traitCollection: self.traitCollection)
        self._scaleFactor.update(traitCollection: self.traitCollection)
        self.setCornerRadius(self.viewModel.borderRadius * self.scaleFactor)
        self.setBorderWidth(self.viewModel.borderWidth * self.scaleFactor)
        self.invalidateIntrinsicContentSize()
    }

    public override var intrinsicContentSize: CGSize {
        return .init(
            width: super.intrinsicContentSize.width,
            height: self.height
        )
    }
}
