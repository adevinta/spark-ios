//
//  BadgeComponentUIView.swift
//  SparkDemo
//
//  Created by alican.aycil on 16.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class BadgeComponentUIView: UIView {

    // MARK: - UIViews
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

    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Badge Size:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var sizeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentSizeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var sizeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sizeLabel, sizeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var formatLabel: UILabel = {
        let label = UILabel()
        label.text = "Format:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var formatButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentFormatSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var formatStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [formatLabel, formatButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "Value:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var valueTextField: UITextField = {
        let textField = UITextField()
        textField.bounds.size.width = 100
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.text = String(viewModel.value)
        textField.keyboardType = .numberPad
        textField.tintColor = viewModel.theme.colors.main.main.uiColor
        textField.addDoneButtonOnKeyboard()
        textField.delegate = self
        return textField
    }()

    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, valueTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var borderCheckBox: CheckboxUIView = {
        CheckboxUIView(
            theme: viewModel.theme,
            text: "With Border",
            checkedImage: DemoIconography.shared.checkmark,
            isEnabled: true,
            selectionState: viewModel.isBorderVisible ? .selected : .unselected,
            checkboxAlignment: .left
        )
    }()

    private lazy var configurationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                themeStackView,
                intentStackView,
                sizeStackView,
                formatStackView,
                valueStackView            ]
        )
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var integrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Integration"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var badgeView: BadgeUIView = {
        let view = BadgeUIView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            size: viewModel.size,
            value: viewModel.value,
            format: viewModel.format,
            isBorderVisible: viewModel.isBorderVisible
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties
    private let viewModel: BadgeComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: BadgeComponentUIViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        self.setupView()
        self.addPublishers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupView() {
        self.backgroundColor = UIColor.systemBackground

        addSubview(configurationLabel)
        addSubview(configurationStackView)
        addSubview(lineView)
        addSubview(borderCheckBox)
        addSubview(integrationLabel)
        addSubview(badgeView)

        NSLayoutConstraint.activate([
            configurationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            configurationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            configurationStackView.topAnchor.constraint(equalTo: configurationLabel.bottomAnchor, constant: 16),
            configurationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            configurationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            borderCheckBox.topAnchor.constraint(equalTo: configurationStackView.bottomAnchor, constant: 10),
            borderCheckBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            lineView.topAnchor.constraint(equalTo: borderCheckBox.bottomAnchor, constant: 16),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1),

            integrationLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            integrationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            badgeView.topAnchor.constraint(equalTo: integrationLabel.bottomAnchor, constant: 16),
            badgeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }

    // MARK: - Publishers
    private func addPublishers() {

        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let color = self.viewModel.theme.colors.main.main.uiColor
            let themeTitle: String? = theme is SparkTheme ? self.viewModel.themes.first?.title : self.viewModel.themes.last?.title
            self.badgeView.theme = theme
            self.themeButton.setTitle(themeTitle, for: .normal)
            self.themeButton.setTitleColor(color, for: .normal)
            self.intentButton.setTitleColor(color, for: .normal)
            self.sizeButton.setTitleColor(color, for: .normal)
            self.formatButton.setTitleColor(color, for: .normal)
            self.valueTextField.tintColor = color
            self.borderCheckBox.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.intentButton.setTitle(intent.name, for: .normal)
            self.badgeView.intent = intent
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.sizeButton.setTitle(size.name, for: .normal)
            self.badgeView.size = size
        }

        self.viewModel.$format.subscribe(in: &self.cancellables) { [weak self] format in
            guard let self = self else { return }
            self.formatButton.setTitle(format.name, for: .normal)
            self.badgeView.format = format
        }

        self.borderCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.badgeView.isBorderVisible = state == .selected
        }
    }
}

// MARK: - Textfield Delegates
extension BadgeComponentUIView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let number = Int(textField.text ?? "") else { return }
        self.badgeView.value = number
    }
}
