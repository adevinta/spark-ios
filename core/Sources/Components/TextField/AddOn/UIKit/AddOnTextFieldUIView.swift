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

    private let leadingAddOn: UIView?
    private let trailingAddOn: UIView?
    private let textField: TextFieldUIView
    private let viewModel: AddOnTextFieldViewModel
    private var cancellable = Set<AnyCancellable>()

    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var textFieldContainer: UIView = {
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
            borderStyle: leadingAddOn != nil || trailingAddOn != nil ? .none : .roundedRect
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
        self.hStack.addBorder(color: self.viewModel.borderColor)

        self.addSubviewSizedEqually(hStack)

        if let leadingAddOn {
            leadingAddOn.translatesAutoresizingMaskIntoConstraints = false
            leadingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.leadingAddOn
            leadingAddOn.setContentHuggingPriority(.required, for: .horizontal)
            leadingAddOn.setContentHuggingPriority(.required, for: .vertical)
            leadingAddOn.addSeparator(
                toThe: .right,
                color: self.viewModel.theme.colors.base.outline
            )
            self.hStack.addArrangedSubview(leadingAddOn)
        }

        self.hStack.addArrangedSubview(self.textFieldContainer)
        self.textFieldContainer.addSubview(self.textField)

        if let trailingAddOn {
            trailingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.trailingAddOn
            trailingAddOn.setContentHuggingPriority(.required, for: .horizontal)
            trailingAddOn.setContentHuggingPriority(.required, for: .horizontal)
            trailingAddOn.addSeparator(
                toThe: .left,
                color: self.viewModel.theme.colors.base.outline
            )
            self.hStack.addArrangedSubview(trailingAddOn)
        }

        self.setupSpacing()
    }

    private func setupSpacing() {
        var constraints = [
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor)
        ]

        if leadingAddOn != nil, trailingAddOn != nil {
            constraints.append(self.textField.leadingAnchor.constraint(equalTo: self.textFieldContainer.leadingAnchor, constant: 8))
            constraints.append(self.textField.trailingAnchor.constraint(equalTo: self.textFieldContainer.trailingAnchor, constant: -8))
        } else if leadingAddOn != nil, trailingAddOn == nil {
            constraints.append(self.textField.leadingAnchor.constraint(equalTo: self.textFieldContainer.leadingAnchor, constant: 8))
            constraints.append(self.textField.trailingAnchor.constraint(equalTo: self.textFieldContainer.trailingAnchor, constant: -16))
        } else if leadingAddOn == nil, trailingAddOn != nil {
            constraints.append(self.textField.leadingAnchor.constraint(equalTo: self.textFieldContainer.leadingAnchor, constant: 16))
            constraints.append(self.textField.trailingAnchor.constraint(equalTo: self.textFieldContainer.trailingAnchor, constant: -8))
        }

        NSLayoutConstraint.activate(constraints)
    }

    private func setupSubscriptions() {
        self.viewModel.$borderColor.subscribe(in: &self.cancellable) { [weak self] color in
            UIView.animate(withDuration: 0.1) {
                self?.addBorder(color: color)
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

}

private extension UIView {
    func addBorder(color: any ColorToken) {
        self.layer.borderColor = color.uiColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }

    func addSeparator(
        toThe side: AddOnTextFieldUIView.Side,
        color: any ColorToken
    ) {
        let border = UIView()
        border.backgroundColor = color.uiColor

        switch side {
        case .left:
            border.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: 1, height: frame.size.height)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        case .right:
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            border.frame = CGRect(x: self.frame.maxX - 1, y: self.frame.minY, width: 1, height: frame.size.height)
        }

        self.addSubview(border)
    }
}
