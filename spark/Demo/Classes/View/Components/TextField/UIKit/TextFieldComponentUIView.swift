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

    init(viewModel: TextFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.textField = TextFieldUIView(theme: viewModel.theme)
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
        self.textField.addDoneButtonOnKeyboard()

        self.addSubview(self.textField)
        self.addSubview(self.configurationLabel)
        self.addSubview(self.configurationStackView)
        self.addSubview(self.withRightViewCheckBox)
        self.addSubview(self.withLeftViewCheckBox)
        self.addSubview(self.rightViewModeStackView)
        self.addSubview(self.leftViewModeStackView)

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

            self.rightViewModeStackView.topAnchor.constraint(equalTo: self.withLeftViewCheckBox.bottomAnchor, constant: 16),
            self.rightViewModeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.rightViewModeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.leftViewModeStackView.topAnchor.constraint(equalTo: self.rightViewModeStackView.bottomAnchor, constant: 16),
            self.leftViewModeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.leftViewModeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.textField.topAnchor.constraint(equalTo: self.leftViewModeStackView.bottomAnchor, constant: 16),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

        ])
        self.textField.rightView = self.createRightView()
        self.textField.leftView = self.createLeftView()
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
        }

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] label in
            guard let self = self else { return }
            self.textField.placeholder = label
        }

        self.withRightViewCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.textField.rightView = state == .unselected ? nil : self.createRightView()
        }

        self.withLeftViewCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.textField.leftView = state == .unselected ? nil : self.createLeftView()
        }

        self.viewModel.$rightViewMode.subscribe(in: &self.cancellables) { [weak self] viewMode in
            guard let self = self else { return }
            self.rightViewModeButton.setTitle(viewMode.name, for: .normal)
            self.textField.rightViewMode = .init(rawValue: viewMode.rawValue) ?? .never
        }

        self.viewModel.$leftViewMode.subscribe(in: &self.cancellables) { [weak self] viewMode in
            guard let self = self else { return }
            self.leftViewModeButton.setTitle(viewMode.name, for: .normal)
            self.textField.leftViewMode = .init(rawValue: viewMode.rawValue) ?? .never
        }
    }
}
