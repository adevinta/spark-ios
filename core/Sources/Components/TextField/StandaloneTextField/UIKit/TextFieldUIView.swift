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
    private var heightConstraint: NSLayoutConstraint?

    @ScaledUIMetric private var height: CGFloat = 44
    @ScaledUIMetric private var leftViewSize: CGFloat = .zero
    @ScaledUIMetric private var rightViewSize: CGFloat = .zero

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
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 16),
            view.heightAnchor.constraint(equalToConstant: 16)
        ])
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

    public override var borderStyle: UITextField.BorderStyle {
        @available(*, unavailable)
        set {}
        get { return .init(self.viewModel.borderStyle) }
    }

    public override var rightView: UIView? {
        get {
            return self.rightViewContainer
        }
        set {
            if let newValue {
                self.userDefinedRightView.subviews.forEach { $0.removeFromSuperview() }
                self.userDefinedRightView.addSubview(newValue)
            }
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
        self.font = .preferredFont(forTextStyle: .body)
        self.updateHeight()
        self.setupRightView()
    }

    private func updateHeight() {
        self.heightConstraint?.isActive = false
        self.heightConstraint = self.heightAnchor.constraint(equalToConstant: self.height)
        self.heightConstraint?.isActive = true
    }

    private func setupRightView() {
        super.rightView = self.rightViewContainer
        self.rightViewContainer.addSubviewSizedEqually(self.userDefinedRightView)
        self.rightViewContainer.addSubviewSizedEqually(self.statusIconImageView)
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
        self.rightViewSize = rect.width
        rect.origin.x = (rect.maxX - self.viewModel.spacings.right - self.rightViewSize)
        rect.origin.y = bounds.size.height / 2 - self.rightViewSize / 2
        rect.size.width = self.rightViewSize
        rect.size.height = self.rightViewSize
        return rect
    }

    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        self.leftViewSize = rect.width
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
        self.updateHeight()
    }
}
