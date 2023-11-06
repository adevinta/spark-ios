//
//  TextFieldComponentUIView.swift
//  Spark
//
//  Created by Quentin.richard on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class TextFieldComponentUIView: UIView {
    private var addOnTextField: AddOnTextFieldUIView
    private let textField: TextFieldUIView
    private let viewModel: TextFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    private lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        return stackView
    }()

    private lazy var configurationLabel: UILabel = {
        let label = UILabel()
        label.text = "Configuration"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Theme:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var themeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentThemeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [themeLabel, themeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var intentLabel: UILabel = {
        let label = UILabel()
        label.text = "Intent:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var intentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentIntentSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var intentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [intentLabel, intentButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var withRightViewCheckBox: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: viewModel.theme,
            text: "Display right view",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var withLeftViewCheckBox: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: viewModel.theme,
            text: "Display left view",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var showLeadingAddOnLabel: UILabel = {
        let label = UILabel()
        label.text = "Leading add-on:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var leadingAddOnButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentLeadingAddOnSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var leadingAddOnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [showLeadingAddOnLabel, leadingAddOnButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var showTrailingAddOnLabel: UILabel = {
        let label = UILabel()
        label.text = "Trailing add-on:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var trailingAddOnButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentTrailingAddOnSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var trailingAddOnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [showTrailingAddOnLabel, trailingAddOnButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var rightViewModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode for rightView:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var rightViewModeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentRightViewModeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var rightViewModeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rightViewModeLabel, rightViewModeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var clearButtonModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear button mode:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var clearButtonModeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presetClearButtonModeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var clearButtonModeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [clearButtonModeLabel, clearButtonModeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var configurationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                themeStackView,
                intentStackView,
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var leftViewModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode for leftView:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var leftViewModeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentLeftViewModeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var leftViewModeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftViewModeLabel, leftViewModeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var standaloneTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Standalone text field:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addOnTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "Add-on text field:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(viewModel: TextFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.textField = TextFieldUIView(theme: viewModel.theme)
        self.addOnTextField = AddOnTextFieldUIView(
            theme: viewModel.theme,
            intent: .neutral,
            leadingAddOn: nil,
            trailingAddOn: nil
        )
        super.init(frame: .zero)
        self.setupView()
        self.addPublishers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white

        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.addOnTextField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.addDoneButtonOnKeyboard()
        self.addOnTextField.textField.addDoneButtonOnKeyboard()

        self.addSubview(self.vStack)
        NSLayoutConstraint.activate([
            self.vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            self.vStack.topAnchor.constraint(equalTo: self.topAnchor)
        ])

        self.vStack.addArrangedSubview(self.configurationLabel)
        self.vStack.addArrangedSubview(self.configurationStackView)
        self.vStack.addArrangedSubview(self.withRightViewCheckBox)
        self.vStack.addArrangedSubview(self.withLeftViewCheckBox)
        self.vStack.addArrangedSubview(self.leadingAddOnStackView)
        self.vStack.addArrangedSubview(self.trailingAddOnStackView)
        self.vStack.addArrangedSubview(self.rightViewModeStackView)
        self.vStack.addArrangedSubview(self.leftViewModeStackView)
        self.vStack.addArrangedSubview(self.clearButtonModeStackView)
        self.vStack.addArrangedSubview(self.standaloneTextFieldLabel)
//        self.vStack.addArrangedSubview(self.textField)
        self.vStack.addArrangedSubview(self.addOnTextFieldLabel)
        self.vStack.addArrangedSubview(self.addOnTextField)

        self.textField.rightView = self.createRightView()
        self.textField.leftView = self.createLeftView()

        self.addOnTextField.textField.rightView = self.createRightView()
        self.addOnTextField.textField.leftView = self.createLeftView()
    }

    private func createRightView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = UIImage(systemName: "square.and.pencil.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func createLeftView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = UIImage(systemName: "square.and.pencil.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func createButtonAddOn() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.image = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(scale: .small)
        )
        button.configuration = buttonConfig
        button.addTarget(self.viewModel, action: #selector(self.viewModel.buttonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: button.intrinsicContentSize.width).isActive = true
        return button
    }

    private func createShortTextAddOn() -> UIView {
        let container = UIView()
        let label = UILabel()
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "short"
        container.addSubview(label)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 32),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        label.textColor = .black
        return container
    }

    private func createLongTextAddOn() -> UIView {
        let container = UIView()
        let label = UILabel()
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "a very long text"
        container.addSubview(label)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 32),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        label.textColor = .black
        return container
    }

    private func addPublishers() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let color = self.viewModel.theme.colors.main.main.uiColor
            let themeTitle: String? = theme is SparkTheme ? viewModel.themes.first?.title : viewModel.themes.last?.title
            self.themeButton.setTitle(themeTitle, for: .normal)
            self.themeButton.setTitleColor(color, for: .normal)
            self.intentButton.setTitleColor(color, for: .normal)
            self.rightViewModeButton.setTitleColor(color, for: .normal)
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.intentButton.setTitle(intent.name, for: .normal)
            self.textField.intent = intent
            self.addOnTextField.intent = intent
        }

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] label in
            guard let self = self else { return }
            self.textField.placeholder = label
            self.addOnTextField.textField.placeholder = label
        }

        self.withRightViewCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            if state != .unselected {
                self.textField.rightView = self.createRightView()
                self.addOnTextField.textField.rightView = self.createRightView()
            }
        }

        self.withLeftViewCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.textField.leftView = state == .unselected ? nil : self.createLeftView()
            if state != .unselected {
                self.textField.leftView = self.createLeftView()
                self.addOnTextField.textField.leftView = self.createLeftView()
            }
        }

        self.viewModel.$leadingAddOnOption.subscribe(in: &self.cancellables) { [weak self] addOnOption in
            guard let self else { return }
            self.leadingAddOnButton.setTitle(addOnOption.name, for: .normal)
            switch addOnOption {
            case .none:
                self.addOnTextField.leadingAddOn = nil
            case .button:
                self.addOnTextField.leadingAddOn = self.createButtonAddOn()
            case .shortText:
                self.addOnTextField.leadingAddOn = self.createShortTextAddOn()
            case .longText:
                self.addOnTextField.leadingAddOn = self.createLongTextAddOn()
            }
        }

        self.viewModel.$trailingAddOnOption.subscribe(in: &self.cancellables) { [weak self] addOnOption in
            guard let self else { return }
            self.trailingAddOnButton.setTitle(addOnOption.name, for: .normal)
            switch addOnOption {
            case .none:
                self.addOnTextField.trailingAddOn = nil
            case .button:
                self.addOnTextField.trailingAddOn = self.createButtonAddOn()
            case .shortText:
                self.addOnTextField.trailingAddOn = self.createShortTextAddOn()
            case .longText:
                self.addOnTextField.trailingAddOn = self.createLongTextAddOn()
            }
        }

        self.viewModel.$rightViewMode.subscribe(in: &self.cancellables) { [weak self] viewMode in
            guard let self = self else { return }
            self.rightViewModeButton.setTitle(viewMode.name, for: .normal)
            self.textField.rightViewMode = .init(rawValue: viewMode.rawValue) ?? .never
            self.addOnTextField.textField.rightViewMode = .init(rawValue: viewMode.rawValue) ?? .never
        }

        self.viewModel.$leftViewMode.subscribe(in: &self.cancellables) { [weak self] viewMode in
            guard let self = self else { return }
            self.leftViewModeButton.setTitle(viewMode.name, for: .normal)
            self.textField.leftViewMode = .init(rawValue: viewMode.rawValue) ?? .never
            self.addOnTextField.textField.leftViewMode = .init(rawValue: viewMode.rawValue) ?? .never
        }

        self.viewModel.$clearButtonMode.subscribe(in: &self.cancellables) { [weak self] viewMode in
            guard let self else { return }
            self.clearButtonModeButton.setTitle(viewMode.name, for: .normal)
            self.textField.clearButtonMode = .init(rawValue: viewMode.rawValue) ?? .never
            self.addOnTextField.textField.clearButtonMode = .init(rawValue: viewMode.rawValue) ?? .never
        }
    }
}
