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
            self.textFieldViewModel.setIntent(newValue)
        }
    }

    public var leadingAddOn: UIView? {
        didSet {
            if let addOn = leadingAddOn {
                self.addLeadingAddOn(addOn)
            } else {
                self.removeLeadingAddOn()
            }
        }
    }
    public var trailingAddOn: UIView? {
        didSet {
            if let addOn = trailingAddOn {
                self.addTrailingAddOn(addOn)
            } else {
                self.removeTrailingAddOn()
            }
        }
    }
    public let textField: TextFieldUIView
    
    // MARK: - Private properties

    private let viewModel: AddOnTextFieldViewModel
    private let textFieldViewModel: TextFieldUIViewModel
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

    public convenience init(
        theme: Theme,
        intent: TextFieldIntent = .neutral,
        leadingAddOn: UIView? = nil,
        trailingAddOn: UIView? = nil
    ) {
        self.init(
            theme: theme,
            intent: intent,
            leadingAddOn: leadingAddOn,
            trailingAddOn: trailingAddOn,
            getColorsUseCase: TextFieldGetColorsUseCase()
        )
    }

    internal init(
        theme: Theme,
        intent: TextFieldIntent = .neutral,
        leadingAddOn: UIView? = nil,
        trailingAddOn: UIView? = nil,
        getColorsUseCase: TextFieldGetColorsUseCasable
    ) {
        self.leadingAddOn = leadingAddOn
        self.trailingAddOn = trailingAddOn

        self.textFieldViewModel = TextFieldUIViewModel(
            theme: theme,
            borderStyle: .none,
            getColorsUseCase: getColorsUseCase
        )
        self.textField = TextFieldUIView(viewModel: textFieldViewModel)
        
        self.viewModel = AddOnTextFieldViewModel(
            theme: theme,
            intent: intent,
            getColorUseCase: getColorsUseCase
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

        self.hStack.setBorderColor(from: self.textFieldViewModel.colors.border)
        self.hStack.setBorderWidth(self.theme.border.width.small)
        self.hStack.setCornerRadius(self.theme.border.radius.large)

        self.addSubviewSizedEqually(hStack)
        self.hStack.addArrangedSubviews([
            self.leadingAddOnStackView,
            self.textField,
            self.trailingAddOnStackView
        ])

        if let leadingAddOn {
            self.addLeadingAddOn(leadingAddOn)
        }

        if let trailingAddOn {
            self.addTrailingAddOn(trailingAddOn)
        }
    }

    private func setupSubscriptions() {
        self.viewModel.$textFieldColors.subscribe(in: &self.cancellable) { [weak self] textFieldColors in
            guard let self else { return }
            UIView.animate(withDuration: 0.1) {
                self.setBorderColor(from: textFieldColors.border)
                self.setCornerRadius(self.theme.border.radius.large)
            }
        }

        self.textFieldViewModel.$textFieldIsActive.subscribe(in: &self.cancellable) { [weak self] isActive in
            guard let self else { return }
            let isActive = isActive ?? false

            self.setBorderWidth(isActive ? self.theme.border.width.medium : self.theme.border.width.small)
            self.setCornerRadius(self.theme.border.radius.large)
        }
    }

    private func separatorView() -> UIView {
        let separator = UIView()
        let separatorWidth = self.theme.border.width.small
        separator.backgroundColor = self.viewModel.theme.colors.base.outline.uiColor
        separator.widthAnchor.constraint(equalToConstant: separatorWidth).isActive = true
        separator.translatesAutoresizingMaskIntoConstraints = false

        return separator
    }

    private func addLeadingAddOn(_ addOn: UIView) {
        self.removeLeadingAddOn()
        addOn.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAddOnStackView.isHidden = false
        self.leadingAddOnStackView.addArrangedSubviews([
            addOn,
            separatorView()
        ])
    }

    private func removeLeadingAddOn() {
        self.leadingAddOnStackView.isHidden = true
        self.leadingAddOnStackView.removeArrangedSubviews()
    }

    private func addTrailingAddOn(_ addOn: UIView) {
        self.removeTrailingAddOn()
        addOn.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAddOnStackView.isHidden = false
        self.trailingAddOnStackView.addArrangedSubviews([
            separatorView(),
            addOn
        ])
    }

    private func removeTrailingAddOn() {
        self.trailingAddOnStackView.isHidden = true
        self.trailingAddOnStackView.removeArrangedSubviews()
    }

}
