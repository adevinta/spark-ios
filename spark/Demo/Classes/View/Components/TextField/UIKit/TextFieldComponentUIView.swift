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

    private lazy var showLeadingAddOnCheckBox: CheckboxUIView = {
        let checkbox = CheckboxUIView(
            theme: viewModel.theme,
            text: "Display leading add-on",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        return checkbox
    }()

    private lazy var showTrailingAddOnCheckBox: CheckboxUIView = {
        let checkbox = CheckboxUIView(
            theme: viewModel.theme,
            text: "Display trailing add-on",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        return checkbox
    }()

    private lazy var rightViewModeLabel: UILabel = {
        let label = UILabel()
        label.text = "Mode for rightView:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var  rightViewModeButton: UIButton = {
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

    private lazy var  leftViewModeButton: UIButton = {
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

    private var leadingAddOn: UIView = {
        let container = UIView()
        let label = UILabel()
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "https://"
        container.addSubview(label)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 32),
            container.heightAnchor.constraint(equalToConstant: 44),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        label.textColor = .black
        return container
    }()

    private var trailingAddOn: UIView = {
        let container = UIView()
        let label = UILabel()
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ".com"
        container.addSubview(label)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width + 32),
            container.heightAnchor.constraint(equalToConstant: 44),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        label.textColor = .black
        return container
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
            leadingAddOn: leadingAddOn,
            trailingAddOn: trailingAddOn
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

        self.addSubview(self.textField)
        self.addSubview(self.configurationLabel)
        self.addSubview(self.configurationStackView)
        self.addSubview(self.withRightViewCheckBox)
        self.addSubview(self.withLeftViewCheckBox)
        self.addSubview(self.showLeadingAddOnCheckBox)
        self.addSubview(self.showTrailingAddOnCheckBox)
        self.addSubview(self.rightViewModeStackView)
        self.addSubview(self.leftViewModeStackView)
        self.addSubview(self.addOnTextField)
        self.addSubview(self.standaloneTextFieldLabel)
        self.addSubview(self.addOnTextFieldLabel)

        NSLayoutConstraint.activate([
            self.configurationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.configurationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            self.configurationStackView.topAnchor.constraint(equalTo: self.configurationLabel.bottomAnchor, constant: 16),
            self.configurationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.configurationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.withRightViewCheckBox.topAnchor.constraint(equalTo: self.configurationStackView.bottomAnchor, constant: 16),
            self.withRightViewCheckBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.withRightViewCheckBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.withLeftViewCheckBox.topAnchor.constraint(equalTo: self.withRightViewCheckBox.bottomAnchor, constant: 16),
            self.withLeftViewCheckBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.withLeftViewCheckBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.showLeadingAddOnCheckBox.topAnchor.constraint(equalTo: self.withLeftViewCheckBox.bottomAnchor, constant: 16),
            self.showLeadingAddOnCheckBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.showLeadingAddOnCheckBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.showTrailingAddOnCheckBox.topAnchor.constraint(equalTo: self.showLeadingAddOnCheckBox.bottomAnchor, constant: 16),
            self.showTrailingAddOnCheckBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.showTrailingAddOnCheckBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.rightViewModeStackView.topAnchor.constraint(equalTo: self.showTrailingAddOnCheckBox.bottomAnchor, constant: 16),
            self.rightViewModeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.rightViewModeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.leftViewModeStackView.topAnchor.constraint(equalTo: self.rightViewModeStackView.bottomAnchor, constant: 16),
            self.leftViewModeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.leftViewModeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.standaloneTextFieldLabel.topAnchor.constraint(equalTo: self.leftViewModeStackView.bottomAnchor, constant: 16),
            self.standaloneTextFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.standaloneTextFieldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.textField.topAnchor.constraint(equalTo: self.standaloneTextFieldLabel.bottomAnchor, constant: 16),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

            self.addOnTextFieldLabel.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16),
            self.addOnTextFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.addOnTextFieldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.addOnTextField.topAnchor.constraint(equalTo: self.addOnTextFieldLabel.bottomAnchor, constant: 16),
            self.addOnTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.addOnTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)

        ])
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

        self.showLeadingAddOnCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            if state == .selected {
                self.addOnTextField.leadingAddOn = self.leadingAddOn
            } else if state == .unselected {
                self.addOnTextField.leadingAddOn = nil
            }
        }

        self.showTrailingAddOnCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            if state == .selected {
                self.addOnTextField.trailingAddOn = self.trailingAddOn
            } else if state == .unselected {
                self.addOnTextField.trailingAddOn = nil
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
    }
}
