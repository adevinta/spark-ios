//
//  SliderComponentUIControl.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

// swiftlint:disable no_debugging_method
final class SliderComponentUIView: UIView {

    private let numberFormatter = NumberFormatter()

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
        button.addTarget(self.viewModel, action: #selector(self.viewModel.presentIntentSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var intentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.intentLabel, self.intentButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var shapeLabel: UILabel = {
        let label = UILabel()
        label.text = "Shape:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var shapeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(self.viewModel.presentSizeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var shapeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.shapeLabel, self.shapeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var isContinuousCheckbox: CheckboxUIView = {
        return CheckboxUIView(
            theme: self.viewModel.theme,
            text: "isContinuous",
            checkedImage: DemoIconography.shared.checkmark,
            selectionState: .selected,
            alignment: .left
        )
    }()

    private lazy var isEnabledCheckbox: CheckboxUIView = {
        return CheckboxUIView(
            theme: self.viewModel.theme,
            text: "isEnabled",
            checkedImage: DemoIconography.shared.checkmark,
            selectionState: .selected,
            alignment: .left
        )
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "Value:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var valueTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        textField.text = "0"
        textField.borderStyle = .roundedRect
        textField.addDoneButtonOnKeyboard()
        textField.delegate = self
        return textField
    }()

    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.valueLabel, self.valueTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Steps:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var stepsTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        textField.text = "0"
        textField.borderStyle = .roundedRect
        textField.addDoneButtonOnKeyboard()
        textField.delegate = self
        return textField
    }()

    private lazy var stepsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.stepsLabel, self.stepsTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var minimumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Minimum value:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var minimumValueTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        textField.text = "0.0"
        textField.borderStyle = .roundedRect
        textField.addDoneButtonOnKeyboard()
        textField.delegate = self
        return textField
    }()

    private lazy var minimumValueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.minimumValueLabel, self.minimumValueTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var maximumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Maximum value:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var maximumValueTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        textField.text = "1.0"
        textField.borderStyle = .roundedRect
        textField.addDoneButtonOnKeyboard()
        textField.delegate = self
        return textField
    }()

    private lazy var maximumValueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.maximumValueLabel, self.maximumValueTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var configurationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.themeStackView,
                self.shapeStackView,
                self.intentStackView,
                self.isContinuousCheckbox,
                self.isEnabledCheckbox,
                self.stepsStackView,
                self.valueStackView,
                self.minimumValueStackView,
                self.maximumValueStackView
            ]
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

    lazy var slider: SliderUIControl<Float> = {
        let slider = SliderUIControl<Float>(
            theme: self.viewModel.theme,
            shape: self.viewModel.shape,
            intent: self.viewModel.intent
        )
        slider.range = 0...1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    // MARK: - Properties
    private let viewModel: SliderComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: SliderComponentUIViewModel) {
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

        addSubview(self.configurationLabel)
        addSubview(self.configurationStackView)
        addSubview(self.lineView)
        addSubview(self.integrationLabel)
        addSubview(self.slider)

        NSLayoutConstraint.activate([
            self.configurationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            self.configurationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            self.configurationStackView.topAnchor.constraint(equalTo: self.configurationLabel.bottomAnchor, constant: 16),
            self.configurationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.configurationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            self.lineView.topAnchor.constraint(equalTo: self.configurationStackView.bottomAnchor, constant: 16),
            self.lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),

            self.integrationLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 16),
            self.integrationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            self.slider.topAnchor.constraint(equalTo: self.integrationLabel.bottomAnchor, constant: 16),
            self.slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.slider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }

    // MARK: - Publishers
    private func addPublishers() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let color = self.viewModel.theme.colors.main.main.uiColor
            let themeTitle: String? = theme is SparkTheme ? self.viewModel.themes.first?.title : self.viewModel.themes.last?.title
            self.themeButton.setTitle(themeTitle, for: .normal)
            self.themeButton.setTitleColor(color, for: .normal)
            self.intentButton.setTitleColor(color, for: .normal)
            self.shapeButton.setTitleColor(color, for: .normal)
            self.slider.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.intentButton.setTitle(intent.name, for: .normal)
            self.slider.intent = intent
        }

        self.viewModel.$shape.subscribe(in: &self.cancellables) { [weak self] shape in
            guard let self = self else { return }
            self.shapeButton.setTitle(shape.name, for: .normal)
            self.slider.shape = shape
        }

        self.isContinuousCheckbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.slider.isContinuous = state == .unselected ? false : true
        }

        self.isEnabledCheckbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.slider.isEnabled = state == .unselected ? false : true
        }

        self.slider.valuePublisher.subscribe(in: &self.cancellables) { [weak self] value in
            guard let self else { return }
            self.valueTextField.text = "\(value)"
        }

        self.slider.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            print("Slider.valuedChanged: \(self.slider.value)")
        }), for: .valueChanged)
    }
}

extension SliderComponentUIView: UITextFieldDelegate {
    private func setValue(_ value: Float) {
        self.slider.setValue(value)
        self.valueTextField.text = "\(self.slider.value)"
    }

    private func setStep(_ step: Float) {
        self.slider.step = step == .zero ? nil : step
        self.stepsTextField.text = "\(self.slider.step ?? 0)"
    }

    private func setMinimumValue(_ minimumValue: Float) {
        self.slider.range = minimumValue...self.slider.range.upperBound
        self.minimumValueTextField.text = "\(self.slider.range.lowerBound)"
    }

    private func setMaximumValue(_ maximumValue: Float) {
        self.slider.range = self.slider.range.lowerBound...maximumValue
        self.maximumValueTextField.text = "\(self.slider.range.upperBound)"

    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text,
              let number = self.numberFormatter.number(from: text) else { return }
        let float = Float(truncating: number)
        switch textField {
        case self.valueTextField:
            self.setValue(float)
        case self.stepsTextField:
            self.setStep(float)
        case self.minimumValueTextField:
            self.setMinimumValue(float)
        case self.maximumValueTextField:
            self.setMaximumValue(float)
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
