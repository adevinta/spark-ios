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

    public var leadingAddOn: UIView? {
        didSet {
            if let addOn = leadingAddOn {
                self.removeLeadingAddOn()
                self.addLeadingAddOn(addOn)
            } else {
                self.removeLeadingAddOn()
            }
        }
    }
    public var trailingAddOn: UIView? {
        didSet {
            if let addOn = trailingAddOn {
                self.removeTrailingAddOn()
                self.addTrailingAddOn(addOn)
            } else {
                self.removeTrailingAddOn()
            }
        }
    }
    public let textField: TextFieldUIView
    
    // MARK: - Private properties

    private let viewModel: AddOnTextFieldViewModel
    private var cancellable = Set<AnyCancellable>()

    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var leadingAddOnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var trailingAddOnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
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
            self.leadingAddOnStackView,
            self.textField,
            self.trailingAddOnStackView
        ])

        if let leadingAddOn {
            leadingAddOn.translatesAutoresizingMaskIntoConstraints = false
            leadingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.leadingAddOn
            leadingAddOnStackView.addArrangedSubviews([
                leadingAddOn,
                separatorView(color: self.viewModel.theme.colors.base.outline, theme: self.theme)
            ])
        }

        if let trailingAddOn {
            trailingAddOn.translatesAutoresizingMaskIntoConstraints = false
            trailingAddOn.accessibilityIdentifier = TextFieldAccessibilityIdentifier.trailingAddOn
            trailingAddOnStackView.addArrangedSubviews([
                separatorView(color: self.viewModel.theme.colors.base.outline, theme: self.theme),
                trailingAddOn
            ])
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

    private func separatorView(
        color: any ColorToken,
        theme: Theme
    ) -> UIView {
        let separator = UIView()
        let separatorWidth = theme.border.width.small
        separator.backgroundColor = color.uiColor
        separator.widthAnchor.constraint(equalToConstant: separatorWidth).isActive = true

        return separator
    }

    private func addLeadingAddOn(_ addOn: UIView) {
        self.leadingAddOnStackView.isHidden = false
        self.leadingAddOnStackView.addArrangedSubviews([
            addOn,
            separatorView(color: self.viewModel.theme.colors.base.outline, theme: self.theme)
        ])
    }

    private func removeLeadingAddOn() {
        self.leadingAddOnStackView.isHidden = true
        self.leadingAddOnStackView.removeArrangedSubviews()
    }

    private func addTrailingAddOn(_ addOn: UIView) {
        self.trailingAddOnStackView.isHidden = false
        self.trailingAddOnStackView.addArrangedSubviews([
            separatorView(color: self.viewModel.theme.colors.base.outline, theme: self.theme),
            addOn
        ])
    }

    private func removeTrailingAddOn() {
        self.trailingAddOnStackView.isHidden = true
        self.trailingAddOnStackView.removeArrangedSubviews()
    }

}

private extension UIView {
    func addBorder(color: any ColorToken, theme: Theme) {
        self.setBorderColor(from: color)
        self.setBorderWidth(theme.border.width.small)
        self.setCornerRadius(theme.border.radius.large)
        self.setMasksToBounds(true)
    }
}
