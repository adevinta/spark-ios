//
//  AddOnUIView.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 19.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import UIKit

public final class AddOnTextFieldUIView: UIView {

    // MARK: - Private enum

    fileprivate enum Side {
        case left
        case right
    }

    // MARK: - Public properties

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.setTheme(newValue)
            self.textField.theme = newValue
        }
    }

    public var intent: TextFieldIntent {
        get {
            return self.viewModel.intent
        }
        set {
            self.viewModel.setIntent(newValue)
            self.textField.intent = newValue
        }
    }
    
    // MARK: - Private properties

    private var leadingAddOn: UIView?
    private var trailingAddOn: UIView?
    private let textField: TextFieldUIView
    private let viewModel: AddOnTextFieldViewModel
    private var cancellable = Set<AnyCancellable>()

    private var textFieldLeadingConstraint: NSLayoutConstraint = .init()
    private var textFieldTrailingConstraint: NSLayoutConstraint = .init()

    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var leadingAddOnContainer: UIView = {
        return UIView()
    }()

    private lazy var textFieldContainer: UIView = {
        return UIView()
    }()

    private lazy var trailingAddOnContainer: UIView = {
        return UIView()
    }()

    // MARK: - Initializers

    public init(
        theme: Theme,
        intent: TextFieldIntent = .neutral,
        leadingAddOn: UIView? = nil,
        trailingAddOn: UIView? = nil
    ) {
        self.leadingAddOn = leadingAddOn
        self.trailingAddOn = trailingAddOn

        let textFieldViewModel = TextFieldUIViewModel(
            theme: theme,
            borderStyle: .none
        )
        self.textField = TextFieldUIView(viewModel: textFieldViewModel)
        
        self.viewModel = AddOnTextFieldViewModel(
            theme: theme,
            intent: intent
        )

        super.init(frame: .zero)
        self.setupView()
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.hStack.translatesAutoresizingMaskIntoConstraints = false
        self.textField.translatesAutoresizingMaskIntoConstraints = false

        self.hStack.addBorder(color: self.viewModel.borderColor, theme: self.theme)

        self.addSubviewSizedEqually(hStack)
        self.hStack.addArrangedSubviews([
            self.leadingAddOnContainer,
            self.textFieldContainer,
            self.trailingAddOnContainer
        ])

        if let leadingAddOn {
            leadingAddOn.translatesAutoresizingMaskIntoConstraints = false
            leadingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.leadingAddOn
            leadingAddOn.addSeparator(
                toThe: .right,
                color: self.viewModel.theme.colors.base.outline,
                theme: self.theme
            )
            self.leadingAddOnContainer.addSubviewSizedEqually(leadingAddOn)
        }

        self.textFieldContainer.addSubviewSizedEqually(self.textField)

        if let trailingAddOn {
            trailingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.trailingAddOn
            trailingAddOn.addSeparator(
                toThe: .left,
                color: self.viewModel.theme.colors.base.outline,
                theme: self.theme
            )
            self.trailingAddOnContainer.addSubviewSizedEqually(trailingAddOn)
        }
    }

    private func setupSubscriptions() {
        self.viewModel.$borderColor.subscribe(in: &self.cancellable) { [weak self] color in
            guard let self else { return }
            UIView.animate(withDuration: 0.1) {
                self.addBorder(color: color, theme: self.theme)
            }
        }
    }

    // MARK: - Public methods

    public func addTextFieldLeftView(_ leftView: UIView) {
        self.textField.leftView = leftView
    }

    public func addTextFieldRightView(_ rightView: UIView) {
        self.textField.rightView = rightView
    }

    public func addTextFieldPlaceholder(_ placeholder: String?) {
        self.textField.placeholder = placeholder
    }

    public func setTextFieldRightViewMode(_ viewMode: UITextField.ViewMode) {
        self.textField.rightViewMode = viewMode
    }

    public func setTextFieldLeftViewMode(_ viewMode: UITextField.ViewMode) {
        self.textField.leftViewMode = viewMode
    }

    public func addLeadingAddOn(_ addOn: UIView) {
        self.leadingAddOnContainer.isHidden = false
        self.leadingAddOn = addOn
        self.leadingAddOnContainer.addSubviewSizedEqually(addOn)
    }

    public func removeLeadingAddOn() {
        self.leadingAddOnContainer.isHidden = true
        self.leadingAddOn = nil
        self.leadingAddOnContainer.subviews.forEach { $0.removeFromSuperview() }
    }

    public func addTrailingAddOn(_ addOn: UIView) {
        self.trailingAddOnContainer.isHidden = false
        self.trailingAddOn = addOn
        self.trailingAddOnContainer.addSubviewSizedEqually(addOn)
    }

    public func removeTrailingAddOn() {
        self.trailingAddOnContainer.isHidden = true
        self.trailingAddOn = nil
        self.trailingAddOnContainer.subviews.forEach { $0.removeFromSuperview() }
    }

}

private extension UIView {
    func addBorder(color: any ColorToken, theme: Theme) {
        self.setBorderColor(from: color)
        self.setBorderWidth(theme.border.width.small)
        self.setCornerRadius(theme.border.radius.large)
        self.setMasksToBounds(true)
    }

    func addSeparator(
        toThe side: AddOnTextFieldUIView.Side,
        color: any ColorToken,
        theme: Theme
    ) {
        let border = UIView()
        let borderWidth = theme.border.width.small
        border.backgroundColor = color.uiColor

        switch side {
        case .left:
            border.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: borderWidth, height: frame.size.height)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        case .right:
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            border.frame = CGRect(x: self.frame.maxX - borderWidth, y: self.frame.minY, width: borderWidth, height: frame.size.height)
        }

        self.addSubview(border)
    }
}
