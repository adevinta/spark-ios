//
//  ButtonComponentUIView.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class ButtonComponentUIView: UIView {

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

    private lazy var variantLabel: UILabel = {
        let label = UILabel()
        label.text = "Format:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private lazy var variantButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentVariantSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var variantStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [variantLabel, variantButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Size:"
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

    private lazy var shapeLabel: UILabel = {
        let label = UILabel()
        label.text = "Shape:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var shapeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentShapeSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()


    private lazy var shapeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shapeLabel, shapeButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var alignmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Alignment:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var alignmentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentAlignmentSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var alignmentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [alignmentLabel, alignmentButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content:"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var contentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(self.viewModel.theme.colors.main.main.uiColor, for: .normal)
        button.addTarget(self.viewModel, action: #selector(viewModel.presentContentSheet), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentLabel, contentButton, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var borderCheckBox: CheckboxUIView = {
        CheckboxUIView(
            theme: viewModel.theme,
            text: "Is enabled",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected/*viewModel.isBorderVisible ? .selected : .unselected*/,
            checkboxPosition: .left
        )
    }()

    private lazy var configurationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                themeStackView,
                intentStackView,
                variantStackView,
                sizeStackView,
                shapeStackView,
                alignmentStackView,
                contentStackView
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

    private var buttonView: ButtonUIView!

    private var buttonViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Properties
    private let viewModel: ButtonComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: ButtonComponentUIViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        self.makeButtonComponent()
        self.setupView()
        self.addPublishers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeButtonComponent() {
        var button: ButtonUIView!

        switch viewModel.content {
        case .icon:
            button = ButtonUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                iconImage: viewModel.iconImage,
                isEnabled: viewModel.isEnabled
            )

        case .text:
            button = ButtonUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                text: viewModel.text,
                isEnabled: viewModel.isEnabled
            )

        case .attributedText:
            button = ButtonUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                attributedText: viewModel.attributedText,
                isEnabled: viewModel.isEnabled
            )

        case .iconAndText:
            button = ButtonUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                iconImage: viewModel.iconImage,
                text: viewModel.text,
                isEnabled: viewModel.isEnabled
            )

        case .iconAndAttributedText:
            button = ButtonUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                iconImage: viewModel.iconImage,
                attributedText: viewModel.attributedText,
                isEnabled: viewModel.isEnabled
            )
        }

        if !buttonViewContainer.arrangedSubviews.isEmpty {
            self.buttonViewContainer.removeArrangedSubview(buttonView)
        }
        self.buttonView = button
        self.buttonViewContainer.addArrangedSubview(buttonView)
    }

    // MARK: - Setup Views
    private func setupView() {
        backgroundColor = .white

        addSubview(configurationLabel)
        addSubview(configurationStackView)
        addSubview(lineView)
        addSubview(borderCheckBox)
        addSubview(integrationLabel)
        addSubview(buttonViewContainer)

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

            buttonViewContainer.topAnchor.constraint(equalTo: integrationLabel.bottomAnchor, constant: 16),
            buttonViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ])
    }

    // MARK: - Publishers
    private func addPublishers() {

        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let color = self.viewModel.theme.colors.main.main.uiColor
            let themeTitle: String? = theme is SparkTheme ? viewModel.themes.first?.title : viewModel.themes.last?.title
            self.buttonView.theme = theme
            self.themeButton.setTitle(themeTitle, for: .normal)
            self.themeButton.setTitleColor(color, for: .normal)
            self.intentButton.setTitleColor(color, for: .normal)
            self.sizeButton.setTitleColor(color, for: .normal)
            self.variantButton.setTitleColor(color, for: .normal)
            self.shapeButton.setTitleColor(color, for: .normal)
            self.alignmentButton.setTitleColor(color, for: .normal)
            self.contentButton.setTitleColor(color, for: .normal)
            self.borderCheckBox.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.intentButton.setTitle(intent.name, for: .normal)
            self.buttonView.intent = intent
        }

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.variantButton.setTitle(variant.name, for: .normal)
            self.buttonView.variant = variant
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.sizeButton.setTitle(size.name, for: .normal)
            self.buttonView.size = size
        }

        self.viewModel.$shape.subscribe(in: &self.cancellables) { [weak self] shape in
            guard let self = self else { return }
            self.shapeButton.setTitle(shape.name, for: .normal)
            self.buttonView.shape = shape
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.alignmentButton.setTitle(alignment.name, for: .normal)
            self.buttonView.alignment = alignment
        }

        self.viewModel.$content.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }
            self.contentButton.setTitle(content.name, for: .normal)
            self.makeButtonComponent()
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.buttonView.isEnabled = isEnabled
        }

        self.borderCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.viewModel.isEnabled = state == .selected
        }
    }
}
