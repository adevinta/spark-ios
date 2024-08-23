//
//  ComponentsConfigurationItemUIViewModelView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import UIKit
@_spi(SI_SPI) import SparkCommon

final class ComponentsConfigurationItemUIViewModelView: UIView {

    // MARK: - Components

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.label,
            self.valueLabel,
            self.button,
            self.toggle,
            self.checkbox,
            self.numberRange,
            self.input,
            UIView()
        ].compactMap { $0 })
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "\(self.viewModel.name):"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.accessibilityIdentifier = self.viewModel.identifier + "Label"
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.accessibilityIdentifier = self.viewModel.identifier + "ValueLabel"
        label.numberOfLines = 0
        return label
    }()

    private lazy var button: UIButton? = {
        guard self.viewModel.type == .button else {
            return nil
        }

        let button = UIButton()
        button.setTitleColor(self.viewModel.color, for: .normal)
        button.addTarget(self.viewModel.target.source, action: self.viewModel.target.action, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.accessibilityIdentifier = self.viewModel.identifier + "Button"
        return button
    }()

    private lazy var toggle: UISwitch? = {
        switch self.viewModel.type {
        case .toggle(let isOn):
            let toggle = UISwitch()
            toggle.isOn = isOn
            toggle.onTintColor = self.viewModel.color
            toggle.addTarget(self.viewModel.target.source, action: self.viewModel.target.action, for: .touchUpInside)
            toggle.accessibilityIdentifier = self.viewModel.identifier + "Toggle"
            return toggle

        default:
            return nil
        }
    }()

    private lazy var checkbox: CheckboxUIView? = {
        switch self.viewModel.type {
        case let .checkbox(title: title, isOn: isOn):
            let checkbox = CheckboxUIView(
                theme: viewModel.theme,
                text: title,
                checkedImage: DemoIconography.shared.checkmark.uiImage,
                selectionState: isOn ? .selected : .unselected,
                alignment: .left)
            checkbox.accessibilityIdentifier = self.viewModel.identifier + "Checkbox"

            checkbox.publisher.subscribe(in: &self.subscriptions) { [weak self] isChecked in
                guard let self else { return }
                RunLoop.main.perform(
                    self.viewModel.target.action,
                    target: self.viewModel.target.source,
                    argument: isChecked == .selected,
                    order: 0,
                    modes: [.default]
                )
            }

            self.viewModel.$theme.subscribe(in: &self.subscriptions) { theme in
                checkbox.theme = theme
            }
            return checkbox

        default:
            return nil
        }
    }()

    private lazy var numberRange: NumberSelector? = {
        var selector: NumberSelector?

        switch self.viewModel.type {
        case let .rangeSelector(selectedValue, range):
            selector = NumberSelector(
                range: range,
                selectedValue: selectedValue
            )

        case let .rangeSelectorWithConfig(selectedValue, range, stepper, numberFormatter):
            selector = NumberSelector(
                range: range,
                selectedValue: selectedValue,
                stepper: stepper,
                numberFormatter: numberFormatter
            )
        default:
            break
        }

        guard let selector else {
            return nil
        }

        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.accessibilityIdentifier = self.viewModel.identifier + "NumberSelector"

        selector.addTarget(self.viewModel.target.source, action: self.viewModel.target.action, for: .valueChanged)

        return selector
    }()

    private lazy var input: UITextField? = {

        switch self.viewModel.type {
        case let .input(text):
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.accessibilityIdentifier = self.viewModel.identifier + "Input"
            field.addTarget(self.viewModel.target.source, action: self.viewModel.target.action, for: .editingChanged)
            field.text = text
            field.placeholder = "Enter text here"
            field.borderStyle = UITextField.BorderStyle.roundedRect
            field.autocorrectionType = UITextAutocorrectionType.no
            field.keyboardType = UIKeyboardType.default
            field.returnKeyType = UIReturnKeyType.done
            return field
        default:
            return nil
        }
    }()

    // MARK: - Properties

    private let viewModel: ComponentsConfigurationItemUIViewModel

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initialization

    init(viewModel: ComponentsConfigurationItemUIViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        // Subviews
        self.addSubview(self.contentStackView)

        // Setup View
        self.setupView()

        // Setup constraints
        self.setupConstraints()

        // Setup publisher subcriptions
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupView() {
        self.backgroundColor = .clear
        self.accessibilityIdentifier = self.viewModel.identifier
    }

    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self
        )
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        // Colors
        self.viewModel.$color
            .receive(on: RunLoop.main)
            .sink { [weak self] color in
                self?.button?.setTitleColor(color, for: .normal)
                self?.toggle?.onTintColor = color
            }
            .store(in: &self.subscriptions)

        // Button Title
        self.viewModel.$buttonTitle
            .receive(on: RunLoop.main)
            .sink { [weak self] buttonTitle in
                self?.button?.setTitle(buttonTitle, for: .normal)
            }
            .store(in: &self.subscriptions)

        // Toggle isOn
        self.viewModel.$isOn
            .receive(on: RunLoop.main)
            .sink { [weak self] isOn in
                guard let isOn = isOn else { return }
                self?.toggle?.isOn = isOn
            }
            .store(in: &self.subscriptions)

        // Label Text
        self.viewModel.$labelText
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                self?.valueLabel.text = text
            }
            .store(in: &self.subscriptions)
    }
}
