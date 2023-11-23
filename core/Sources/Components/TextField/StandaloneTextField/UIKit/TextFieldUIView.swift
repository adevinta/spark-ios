//
//  TextFieldUIView.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

public final class TextFieldUIView: UITextField {

    // MARK: - Private properties

    private let viewModel: TextFieldUIViewModel
    private var cancellable = Set<AnyCancellable>()
    private var heightConstraint = NSLayoutConstraint()
    private var rightViewHeightConstraint = NSLayoutConstraint()
    private var rightViewWidthConstraint = NSLayoutConstraint()
    private var leftViewColor: UIColor?
    private var rightViewColor: UIColor?

    @ScaledUIMetric private var height: CGFloat = 44
    @ScaledUIMetric private var leftViewSize: CGFloat = 16
    @ScaledUIMetric private var rightViewSize: CGFloat = 16

    private let rightViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userDefinedRightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let statusIconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()

    // MARK: - Public properties

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.setTheme(newValue)
        }
    }

    public var intent: TextFieldIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.setIntent(newValue)
        }
    }

    // MARK: - Overridden properties

    public override var borderStyle: UITextField.BorderStyle {
        @available(*, unavailable)
        set {}
        get { return .init(self.viewModel.borderStyle) }
    }

    public override var leftView: UIView? {
        get {
            super.leftView
        }
        set {
            self.leftViewColor = newValue?.tintColor
            super.leftView = newValue
        }
    }

    public override var rightView: UIView? {
        get {
            return self.rightViewContainer
        }
        set {
            self.rightViewColor = newValue?.tintColor
            if let newValue {
                self.userDefinedRightView.subviews.forEach { $0.removeFromSuperview() }
                self.userDefinedRightView.addSubviewSizedEqually(newValue)
            }
        }
    }

    public override var isEnabled: Bool {
        didSet {
            self.updateStateColors()
            self.viewModel.textFieldIsEnabled = isEnabled
        }
    }

    public override var placeholder: String? {
        get {
            super.placeholder
        } 
        set {
            self.attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: [
                    NSAttributedString.Key.foregroundColor : self.getTextColor().uiColor
                ]
            )
        }
    }

    // MARK: - Initializers

    internal init(viewModel: TextFieldUIViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupView()
        self.setupSubscriptions()
    }
    
    /// Initialize a text field.
    /// - Parameters:
    ///   - theme: The Spark theme.
    ///   - errorIcon: Icon to be shown on error intent.
    ///   - alertIcon: Icon to be shown on alert intent.
    ///   - successIcon: Icon to be shown on success intent.
    ///   - intent: The intent of the text field.
    public convenience init(
        theme: Theme,
        errorIcon: UIImage,
        alertIcon: UIImage,
        successIcon: UIImage,
        intent: TextFieldIntent = .neutral
    ) {
        let viewModel = TextFieldUIViewModel(
            theme: theme,
            borderStyle: .roundedRect,
            errorIcon: errorIcon,
            alertIcon: alertIcon,
            successIcon: successIcon,
            intent: intent
        )
        self.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        self.adjustsFontForContentSizeCategory = true
        self.font = self.theme.typography.body1.uiFont
        self.tintColor = self.theme.colors.base.outlineHigh.uiColor
        self.updateStateColors()
        self.setupRightView()
        self.updateSizes()
    }

    private func updateStateColors() {
        self.backgroundColor = self.getBackgroundColor().uiColor
        self.textColor = self.getTextColor().uiColor
        self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [
                NSAttributedString.Key.foregroundColor : self.getTextColor().uiColor
            ]
        )
    }

    private func setupRightView() {
        super.rightView = self.rightViewContainer
        self.rightViewContainer.addSubviewSizedEqually(self.userDefinedRightView)
        self.rightViewContainer.addSubviewSizedEqually(self.statusIconImageView)
    }

    private func updateSizes() {
        NSLayoutConstraint.deactivate([
            self.heightConstraint,
            self.rightViewWidthConstraint,
            self.rightViewHeightConstraint
        ])

        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: self.height)
        self.rightViewWidthConstraint = self.rightViewContainer.widthAnchor.constraint(equalToConstant: self.rightViewSize)
        self.rightViewHeightConstraint = self.rightViewContainer.heightAnchor.constraint(equalToConstant: self.rightViewSize)

        NSLayoutConstraint.activate([
            self.heightConstraint,
            self.rightViewWidthConstraint,
            self.rightViewHeightConstraint
        ])
    }

    private func setupSubscriptions() {
        self.viewModel.$colors.subscribe(in: &self.cancellable) { [weak self] colors in
            UIView.animate(withDuration: 0.1, animations: { self?.setupColors(colors) })
            self?.updateStatusIconColor(colors.statusIcon)
        }
        self.viewModel.$borders.subscribe(in: &self.cancellable) { [weak self] borders in
            UIView.animate(withDuration: 0.1, animations: { self?.setupBorders(borders) })
        }
        self.viewModel.$spacings.subscribe(in: &self.cancellable) { [weak self] spacings in
            UIView.animate(withDuration: 0.1, animations: { self?.setNeedsLayout() })
        }
        self.viewModel.$statusIcon.subscribe(in: &self.cancellable) { [weak self] statusIcon in
            self?.statusIconImageView.image = statusIcon
            self?.updateRightView()
        }
    }

    private func setupColors(_ colors: TextFieldColors) {
        self.setBorderColor(from: colors.border)
    }

    private func updateStatusIconColor(_ color: any ColorToken) {
        self.statusIconImageView.tintColor = color.uiColor
    }

    private func setupBorders(_ borders: TextFieldBorders) {
        self.setBorderWidth(borders.width)
        self.setCornerRadius(borders.radius)
    }

    private func updateRightView() {
        if self.statusIconImageView.image == nil {
            self.rightViewContainer.subviews.first { $0 == self.statusIconImageView }?.isHidden = true
            self.rightViewContainer.subviews.first { $0 == self.userDefinedRightView }?.isHidden = false
        } else {
            self.rightViewContainer.subviews.first { $0 == self.statusIconImageView }?.isHidden = false
            self.rightViewContainer.subviews.first { $0 == self.userDefinedRightView }?.isHidden = true
        }
    }

    private func setInsets(forBounds bounds: CGRect) -> CGRect {
        var totalInsets = UIEdgeInsets(
            top: .zero,
            left: self.viewModel.spacings.left,
            bottom: .zero,
            right: self.viewModel.spacings.right
        )
        let contentSpacing = self.viewModel.spacings.content
        if let leftView = self.leftView, leftView.frame.origin.x > 0 { totalInsets.left += leftView.bounds.size.width + (0.5 * contentSpacing) }
        if let rightView = self.rightView, rightView.frame.origin.x > 0 { totalInsets.right += rightView.bounds.size.width + (0.75 * contentSpacing) }
        if let button = self.value(forKeyPath: "_clearButton") as? UIButton,
           button.frame.origin.x > 0 && !((rightView?.frame.origin.x) ?? 0 > 0) {
            totalInsets.right += button.bounds.size.width + (0.75 * contentSpacing)
        }
        return bounds.inset(by: totalInsets)
    }

    private func getBackgroundColor() -> any ColorToken {
        let opacity: CGFloat = isEnabled ? 0 : self.theme.dims.dim5
        return self.theme.colors.base.onSurface.opacity(opacity)
    }

    private func getTextColor() -> any ColorToken {
        let opacity: CGFloat = self.isEnabled ? self.theme.dims.none : self.theme.dims.dim3
        return self.theme.colors.base.onSurface.opacity(opacity)
    }

    // MARK: - Rects

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.setInsets(forBounds: bounds)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.setInsets(forBounds: bounds)
    }
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.setInsets(forBounds: bounds)
    }

    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.x -= self.viewModel.spacings.right
        return rect
    }

    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x = (rect.maxX - self.viewModel.spacings.right - self.rightViewSize)
        rect.origin.y = bounds.size.height / 2 - self.rightViewSize / 2
        rect.size.width = self.rightViewSize
        rect.size.height = self.rightViewSize
        return rect
    }

    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += self.viewModel.spacings.left
        rect.origin.y = bounds.size.height / 2 - self.leftViewSize / 2
        rect.size.width = self.leftViewSize
        rect.size.height = self.leftViewSize
        return rect
    }

    // MARK: - Trait collection

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.invalidateIntrinsicContentSize()
        self._height.update(traitCollection: traitCollection)
        self._rightViewSize.update(traitCollection: traitCollection)
        self._leftViewSize.update(traitCollection: traitCollection)
        self.updateSizes()
    }

    // MARK: - Instance methods

    public override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.setBorderColor(from: self.theme.colors.base.outlineHigh)
        return result
    }

    public override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        self.setBorderColor(from: self.viewModel.colors.border)
        return result
    }

    // This is a workaround to make sure that leftView and rightView retain their original color
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        self.leftView?.tintColor = self.leftViewColor
        self.rightView?.tintColor = self.rightViewColor
    }
}
