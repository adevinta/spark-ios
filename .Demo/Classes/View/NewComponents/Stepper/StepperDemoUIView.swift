//
//  StepperDemoUIView.swift
//  SparkDemo
//
//  Created by louis.borlee on 26/12/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkTextInput
@_spi(SI_SPI) import SparkCommon

// swiftlint:disable no_debugging_method
final class StepperDemoUIView: UIViewController {

    private let scrollView = UIScrollView()
    private let verticalStackView = UIStackView()

    private lazy var valueTextField: TextFieldUIView = {
        let textField = TextFieldUIView(theme: self.theme, intent: .neutral)
        textField.placeholder = "Value"
        textField.keyboardType = .decimalPad
        return textField
    }()

    private lazy var stepTextField: TextFieldUIView = {
        let textField = TextFieldUIView(theme: self.theme, intent: .neutral)
        textField.placeholder = "Step"
        textField.keyboardType = .decimalPad
        return textField
    }()

    private lazy var lowerBoundTextField: TextFieldUIView = {
        let textField = TextFieldUIView(theme: self.theme, intent: .neutral)
        textField.placeholder = "Min value"
        textField.keyboardType = .decimalPad
        return textField
    }()

    private lazy var upperBoundTextField: TextFieldUIView = {
        let textField = TextFieldUIView(theme: self.theme, intent: .neutral)
        textField.placeholder = "Max value"
        textField.keyboardType = .decimalPad
        return textField
    }()

    private var theme: any Theme { self.themes.current }
    private var themes: Themes = .spark {
        didSet {
            self.stepper.theme = self.theme
        }
    }

    private var format: Format? {
        didSet {
            if let format {
                self.setFormat(format)
            } else {
                self.stepper.removeFormat()
            }
        }
    }

    private var buttonIntent: ButtonIntent? {
        didSet {
            guard self.buttonIntent != oldValue else { return }
            if let buttonIntent {
                self.setButtonIntent(buttonIntent)
            } else {
                self.reload()
            }
        }
    }

    private var buttonVariant: ButtonVariant? {
        didSet {
            guard self.buttonVariant != oldValue else { return }
            if let buttonVariant {
                self.setButtonVariant(buttonVariant)
            } else {
                self.reload()
            }
        }
    }

    private lazy var stepper = StepperUIControl<Float>(theme: self.theme)

    private var cancellables = Set<AnyCancellable>()

    private let numberFormatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupView()
    }

    private func setupView() {
        self.setupScrollView()
        self.setupThemeConfiguration()
        self.setupFormatConfiguration()
        self.setupButtonIntentConfiguration()
        self.setupButtonVariantConfiguration()
        self.setupIsContinuousConfiguration()
        self.setupAutorepeatConfiguration()
        self.setupValueTextFieldConfiguration()
        self.setupStepTextFieldConfiguration()
        self.setupBoundsTextFieldsConfiguration()
        self.setupStepper()
    }

    private func setupScrollView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.verticalStackView.axis = .vertical
        self.verticalStackView.alignment = .leading
        self.verticalStackView.spacing = 12

        self.scrollView.addSubview(self.verticalStackView)
        self.view.addSubview(self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 12),
            self.verticalStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 12),
            self.verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.scrollView.bottomAnchor, constant: -20),
            self.verticalStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.verticalStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24)
        ])
    }

    private func setupThemeConfiguration() {
        let themeConfiguration = EnumSelectorView(
            title: "Theme:",
            currentCase: self.themes,
            presenter: self
        )
        themeConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newTheme in
                guard let self else { return }
                self.themes = newTheme
            }
        self.verticalStackView.addArrangedSubview(themeConfiguration)
        self.verticalStackView.setCustomSpacing(0, after: themeConfiguration)
    }

    private func setupFormatConfiguration() {
        let formatConfiguration = OptionalEnumSelectorView(
            title: "Format:",
            currentCase: self.format,
            presenter: self
        )
        formatConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newFormat in
                guard let self else { return }
                self.format = newFormat
            }
        self.verticalStackView.addArrangedSubview(formatConfiguration)
        self.verticalStackView.setCustomSpacing(0, after: formatConfiguration)
    }

    private func setupButtonIntentConfiguration() {
        let buttonIntentConfiguration = OptionalEnumSelectorView(
            title: "ButtonIntent:",
            currentCase: self.buttonIntent,
            presenter: self
        )
        buttonIntentConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newButtonIntent in
                guard let self else { return }
                self.buttonIntent = newButtonIntent
            }
        self.verticalStackView.addArrangedSubview(buttonIntentConfiguration)
        self.verticalStackView.setCustomSpacing(0, after: buttonIntentConfiguration)
    }

    private func setupButtonVariantConfiguration() {
        let buttonVariantConfiguration = OptionalEnumSelectorView(
            title: "ButtonVariant:",
            currentCase: self.buttonVariant,
            presenter: self
        )
        buttonVariantConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newButtonVariant in
                guard let self else { return }
                self.buttonVariant = newButtonVariant
            }
        self.verticalStackView.addArrangedSubview(buttonVariantConfiguration)
    }

    private func setupIsContinuousConfiguration() {
        let isContinuousSwitchConfiguration = SwitchUIView(
            theme: self.theme,
            isOn: true,
            alignment: .left,
            intent: .basic,
            isEnabled: true,
            text: "Is continuous"
        )
        isContinuousSwitchConfiguration.isOnChangedPublisher.subscribe(in: &self.cancellables) { isOn in
            self.stepper.isContinuous = isOn
        }
        self.verticalStackView.addArrangedSubview(isContinuousSwitchConfiguration)
        self.verticalStackView.setCustomSpacing(20, after: isContinuousSwitchConfiguration)
    }

    private func setupAutorepeatConfiguration() {
        let autorepeatSwitchConfiguration = SwitchUIView(
            theme: self.theme,
            isOn: true,
            alignment: .left,
            intent: .basic,
            isEnabled: true,
            text: "Autorepeat"
        )
        autorepeatSwitchConfiguration.isOnChangedPublisher.subscribe(in: &self.cancellables) { isOn in
            self.stepper.autoRepeat = isOn
        }
        self.verticalStackView.addArrangedSubview(autorepeatSwitchConfiguration)
        self.verticalStackView.setCustomSpacing(20, after: autorepeatSwitchConfiguration)
    }

    private func setupValueTextFieldConfiguration() {
        self.valueTextField.addAction(.init(handler: { _ in
            self.setValue()
        }), for: .editingChanged)
        self.verticalStackView.addArrangedSubview(self.valueTextField)
        NSLayoutConstraint.activate([
            self.valueTextField.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor)
        ])
    }

    private func setupStepTextFieldConfiguration() {
        self.stepTextField.addAction(.init(handler: { _ in
            self.setStep()
        }), for: .editingChanged)
        self.verticalStackView.addArrangedSubview(self.stepTextField)
        NSLayoutConstraint.activate([
            self.stepTextField.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor)
        ])
    }

    private func setupBoundsTextFieldsConfiguration() {
        let stack = UIStackView(arrangedSubviews: [self.lowerBoundTextField, self.upperBoundTextField])
        stack.spacing = 12
        stack.distribution = .fillEqually
        self.lowerBoundTextField.addAction(.init(handler: { _ in
            self.setLowerBound()
        }), for: .editingChanged)
        self.upperBoundTextField.addAction(.init(handler: { _ in
            self.setUpperBound()
        }), for: .editingChanged)
        self.verticalStackView.addArrangedSubview(stack)
        NSLayoutConstraint.activate([
            stack.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor)
        ])
    }

    private func setupStepper() {
        self.verticalStackView.addArrangedSubview(self.stepper)

        self.stepper.valuePublisher.subscribe(in: &self.cancellables) { newValue in
            print("New value: \(newValue)")
        }
    }

    private func setValue() {
        if let text = self.valueTextField.text,
            let newValue = self.numberFormatter.number(from: text)?.floatValue {
            self.stepper.value = newValue
        } else if (self.valueTextField.text ?? "").isEmpty {
            self.stepper.value = 0
        }
    }

    private func setStep() {
        if let text = self.stepTextField.text,
            let newStep = self.numberFormatter.number(from: text)?.floatValue {
            self.stepper.step = newStep
        } else if (self.stepTextField.text ?? "").isEmpty {
            self.stepper.step = 1.0
        }
    }

    private func setLowerBound() {
        if let text = self.lowerBoundTextField.text,
            let newLowerBound = self.numberFormatter.number(from: text)?.floatValue {
            guard newLowerBound <= self.stepper.range.upperBound else { return }
            self.stepper.range = (newLowerBound...self.stepper.range.upperBound)
        } else if (self.lowerBoundTextField.text ?? "").isEmpty {
            self.stepper.range = (0...self.stepper.range.upperBound)
        }
    }

    private func setUpperBound() {
        if let text = self.upperBoundTextField.text,
            let newUpperBound = self.numberFormatter.number(from: text)?.floatValue {
            guard newUpperBound >= self.stepper.range.lowerBound else { return }
            self.stepper.range = (self.stepper.range.lowerBound...newUpperBound)
        } else if (self.upperBoundTextField.text ?? "").isEmpty {
            self.stepper.range = (self.stepper.range.lowerBound...100)
        }
    }

    private func setFormat(_ format: Format) {
        switch format {
        case .percent: self.stepper.setFormat(.percent)
        case .usd: self.stepper.setFormat(.currency(code: "USD"))
        }
    }

    private func setButtonIntent(_ intent: ButtonIntent) {
        self.stepper.decrementButton.intent = intent
        self.stepper.incrementButton.intent = intent
    }

    private func setButtonVariant(_ variant: ButtonVariant) {
        self.stepper.decrementButton.variant = variant
        self.stepper.incrementButton.variant = variant
    }

    private func reload() {
        self.stepper.removeFromSuperview()
        self.stepper = StepperUIControl<Float>(theme: self.theme)
        self.setValue()
        self.setStep()
        self.setLowerBound()
        self.setUpperBound()
        if let format {
            self.setFormat(format)
        }
        if let buttonIntent {
            self.setButtonIntent(buttonIntent)
        }
        if let buttonVariant {
            self.setButtonVariant(buttonVariant)
        }
        self.setupStepper()
    }
}

fileprivate enum Format: CaseIterable & Hashable {
    case usd
    case percent
}
