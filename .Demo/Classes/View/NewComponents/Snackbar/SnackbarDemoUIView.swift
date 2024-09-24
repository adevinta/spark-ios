//
//  SnackbarDemoUIView.swift
//  SparkDemo
//
//  Created by louis.borlee on 20/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit
import Combine
@_spi(SI_SPI) import SparkCommon
import SparkCore

final class SnackbarDemoUIView: UIViewController {

    private let scrollView = UIScrollView()
    private let verticalStackView = UIStackView()
    private lazy var horizontalStackView = UIStackView(arrangedSubviews: [self.leftPaddingView, self.rightPaddingView])

    private var theme: any Theme { self.themes.current }
    private var themes: Themes = .spark {
        didSet {
            self.snackbar.theme = self.theme
        }
    }
    private var intent: SnackbarIntent = .main {
        didSet {
            self.snackbar.intent = self.intent
        }
    }
    private var variant: SnackbarVariant? {
        didSet {
            guard self.variant != oldValue else { return }
            if let variant {
                self.snackbar.variant = variant
            } else {
                self.reload()
            }
        }
    }
    private var type: SnackbarType? {
        didSet {
            guard self.type != oldValue else { return }
            if let type {
                self.snackbar.type = type
            } else {
                self.reload()
            }
        }
    }
    private var image: UIImage? {
        didSet {
            self.snackbar.setImage(self.image)
        }
    }
    private var showButtonCheckbox: CheckboxUIView?
    private var showButton: Bool = false {
        didSet {
            if self.showButton == false {
                self.snackbar.removeButton()
            } else {
                self.addButton()
            }
        }
    }

    private lazy var labelTextField: TextFieldUIView = {
        let textField = TextFieldUIView(theme: self.theme, intent: .neutral)
        textField.placeholder = "Label Placeholder"
        textField.text = "Default text"
        return textField
    }()

    private lazy var buttonTextField: TextFieldUIView = {
        let textField = TextFieldUIView(theme: self.theme, intent: .neutral)
        textField.placeholder = "Button Placeholder"
        textField.text = "Tap"
        return textField
    }()

    private var leftPaddingView = UIView()
    private var rightPaddingView = UIView()

    private lazy var snackbar = SnackbarUIView(
        theme: self.theme,
        intent: self.intent
    )

    private var snackbarWidthConstraint = NSLayoutConstraint()

    private var cancellables = Set<AnyCancellable>()

    deinit {
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupView()
    }

    private func setupConfiguration() {
        self.setupThemeConfiguration()
        self.setupIntentConfiguration()
        self.setupVariantConfiguration()
        self.setupTypeConfiguration()
        self.setupImageConfiguration()
        self.setupShowButtonConfiguration()
        self.setupLeftPaddingConfiguration()
        self.setupRightPaddingConfiguration()
        self.setupLabelLineNumberConfiguration()
        self.setupLabelTextFieldConfiguration()
        self.setupButtonTextFieldConfiguration()
    }
}

// MARK: - Setup view
extension SnackbarDemoUIView {
    private func setupView() {
        self.setupScrollView()
        self.setupConfiguration()
        self.setupHorizontalStackView()
        self.setupComponent()
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

    private func setupHorizontalStackView() {
        self.horizontalStackView.spacing = 12
        NSLayoutConstraint.activate([
            self.leftPaddingView.widthAnchor.constraint(equalToConstant: 75),
            self.rightPaddingView.widthAnchor.constraint(equalToConstant: 75)
        ])

        self.leftPaddingView.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        self.leftPaddingView.setCornerRadius(8)
        self.rightPaddingView.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        self.rightPaddingView.setCornerRadius(8)

        self.leftPaddingView.isHidden = true
        self.rightPaddingView.isHidden = true

        self.verticalStackView.addArrangedSubview(self.horizontalStackView)
    }

    private func setupComponent() {
        self.snackbar = .init(
            theme: self.theme,
            intent: self.intent
        )
        if let variant {
            self.snackbar.variant = variant
        }
        if let type {
            self.snackbar.type = type
        }
        self.snackbar.setImage(self.image)
        self.snackbar.label.text = self.labelTextField.text

        if self.showButtonCheckbox?.selectionState == .selected {
            self.addButton()
        }

        let container = UIView()
        container.addSubview(self.snackbar)
        self.snackbar.translatesAutoresizingMaskIntoConstraints = false

        let topAnchorConstraint = self.snackbar.topAnchor.constraint(equalTo: container.topAnchor)
        let leadingAnchorConstraint = self.snackbar.leadingAnchor.constraint(equalTo: container.leadingAnchor)

        topAnchorConstraint.priority = .required - 1
        leadingAnchorConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            topAnchorConstraint,
            leadingAnchorConstraint,
            self.snackbar.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            self.snackbar.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        self.horizontalStackView.insertArrangedSubview(container, at: 1)

        self.snackbarWidthConstraint = self.snackbar.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor)
        self.snackbarWidthConstraint.priority = .defaultHigh
    }

    func reload() {
        if let superview = self.snackbar.superview, superview.isDescendant(of: self.horizontalStackView) {
            self.horizontalStackView.removeArrangedSubview(superview)
            superview.removeFromSuperview()
        }
        self.setupComponent()
    }

    private func addButton() {
        let button = self.snackbar.addButton()
        button.setTitle(self.buttonTextField.text, for: .normal)
        button.addAction(.init(handler: { [weak self] _ in
            guard let self else { return }
            self.snackbarWidthConstraint.isActive.toggle()
        }), for: .touchUpInside)
    }
}

// MARK: - Setup configuration
extension SnackbarDemoUIView {
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

    private func setupIntentConfiguration() {
        let intentConfiguration = EnumSelectorView(
            title: "Intent:",
            currentCase: self.intent,
            presenter: self
        )
        intentConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newIntent in
                guard let self else { return }
                self.intent = newIntent
            }
        self.verticalStackView.addArrangedSubview(intentConfiguration)
        self.verticalStackView.setCustomSpacing(0, after: intentConfiguration)
    }

    private func setupVariantConfiguration() {
        let variantConfiguration = OptionalEnumSelectorView(
            title: "Variant:",
            currentCase: self.variant,
            presenter: self
        )
        variantConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newVariant in
                guard let self else { return }
                self.variant = newVariant
            }
        self.verticalStackView.addArrangedSubview(variantConfiguration)
        self.verticalStackView.setCustomSpacing(0, after: variantConfiguration)
    }

    private func setupTypeConfiguration() {
        let typeConfiguration = OptionalEnumSelectorView(
            title: "Type:",
            currentCase: self.type,
            presenter: self
        )
        typeConfiguration.$currentCase.dropFirst().subscribe(
            in: &self.cancellables) { [weak self] newType in
                guard let self else { return }
                self.type = newType
            }
        self.verticalStackView.addArrangedSubview(typeConfiguration)
    }

    private func setupImageConfiguration() {
        let checkbox = CheckboxUIView(
            theme: self.theme,
            intent: .basic,
            text: "With image",
            checkedImage: .init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
            selectionState: .unselected,
            alignment: .left
        )
        checkbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            switch state {
            case .selected:
                self.image = .init(systemName: "externaldrive.fill.badge.minus")
            default:
                self.image = nil
            }
        }
        self.verticalStackView.addArrangedSubview(checkbox)
    }

    private func setupShowButtonConfiguration() {
        let checkbox = CheckboxUIView(
            theme: self.theme,
            intent: .basic,
            text: "With button",
            checkedImage: .init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
            selectionState: .unselected,
            alignment: .left
        )
        checkbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            self.showButton = state == .selected ? true : false
        }
        self.showButtonCheckbox = checkbox
        self.verticalStackView.addArrangedSubview(checkbox)
    }

    private func setupLeftPaddingConfiguration() {
        let checkbox = CheckboxUIView(
            theme: self.theme,
            intent: .basic,
            text: "With left padding",
            checkedImage: .init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
            selectionState: .unselected,
            alignment: .left
        )
        checkbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            self.leftPaddingView.isHidden = state == .selected ? false : true
        }
        self.verticalStackView.addArrangedSubview(checkbox)
    }

    private func setupRightPaddingConfiguration() {
        let checkbox = CheckboxUIView(
            theme: self.theme,
            intent: .basic,
            text: "With right padding",
            checkedImage: .init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
            selectionState: .unselected,
            alignment: .left
        )
        checkbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            self.rightPaddingView.isHidden = state == .selected ? false : true
        }
        self.verticalStackView.addArrangedSubview(checkbox)
    }

    private func setupLabelLineNumberConfiguration() {
        let checkbox = CheckboxUIView(
            theme: self.theme,
            intent: .basic,
            text: "Is multiline",
            checkedImage: .init(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage(),
            selectionState: .unselected,
            alignment: .left
        )
        checkbox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self else { return }
            self.snackbar.label.numberOfLines = state == .selected ? 0 : 1
        }
        self.verticalStackView.addArrangedSubview(checkbox)
    }

    private func setupLabelTextFieldConfiguration() {
        self.labelTextField.addAction(.init(handler: { _ in
            self.snackbar.label.text = self.labelTextField.text
        }), for: .editingChanged)
        self.verticalStackView.addArrangedSubview(self.labelTextField)
        NSLayoutConstraint.activate([
            self.labelTextField.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor)
        ])
    }

    private func setupButtonTextFieldConfiguration() {
        self.buttonTextField.addAction(.init(handler: { _ in
            self.snackbar.buttonView?.setTitle(self.buttonTextField.text, for: .normal)
        }), for: .editingChanged)
        self.verticalStackView.addArrangedSubview(self.buttonTextField)
        NSLayoutConstraint.activate([
            self.buttonTextField.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor)
        ])
        self.verticalStackView.setCustomSpacing(20, after: self.buttonTextField)
    }
}
