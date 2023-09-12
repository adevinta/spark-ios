//
//  ChipComponentUIView.swift
//  SparkDemo
//
//  Created by alican.aycil on 24.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class ChipComponentUIView: UIView {

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
        label.text = "Chip Variant:"
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

    private lazy var withLabelCheckBox: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: viewModel.theme,
            text: "With Label",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var withIconCheckBox: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: viewModel.theme,
            text: "With Icon",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var withActionCheckBox: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: viewModel.theme,
            text: "With Action",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var withComponentCheckBox: CheckboxUIView = {
        let view = CheckboxUIView(
            theme: viewModel.theme,
            text: "With Extra Component",
            checkedImage: DemoIconography.shared.checkmark,
            state: .enabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var configurationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                themeStackView,
                intentStackView,
                variantStackView
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

    private var chipView: ChipUIView!

    // MARK: - Properties
    private let viewModel: ChipComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: ChipComponentUIViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        self.setupView()
        self.setCheckboxStates()
        self.addPublishers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeChipView() {

        if let label = self.viewModel.text, let icon = self.viewModel.icon {
            self.chipView = ChipUIView(
                theme: self.viewModel.theme,
                intent: self.viewModel.intent,
                variant: self.viewModel.variant,
                label: label,
                iconImage: icon
            )
        } else if let icon = self.viewModel.icon {
            self.chipView = ChipUIView(
                theme: self.viewModel.theme,
                intent: self.viewModel.intent,
                variant: self.viewModel.variant,
                iconImage: icon
            )
            self.withIconCheckBox.selectionState = .selected

        } else {
            self.chipView = ChipUIView(
                theme: self.viewModel.theme,
                intent: self.viewModel.intent,
                variant: self.viewModel.variant,
                label: ""
            )
        }
        self.chipView.translatesAutoresizingMaskIntoConstraints = false
        self.chipView.action = self.viewModel.action
        self.chipView.component = self.viewModel.component
    }

    private func setCheckboxStates() {
        self.withLabelCheckBox.selectionState = self.viewModel.text == nil ? .unselected : .selected
        self.withIconCheckBox.selectionState = self.viewModel.icon == nil ? .unselected : .selected
        self.withComponentCheckBox.selectionState = self.viewModel.component == nil ? .unselected : .selected
        self.withActionCheckBox.selectionState = self.viewModel.action == nil ? .unselected : .selected
    }

    // MARK: - Setup Views
    private func setupView() {
        self.backgroundColor = UIColor.systemBackground

        self.makeChipView()
        addSubview(configurationLabel)
        addSubview(configurationStackView)
        addSubview(withLabelCheckBox)
        addSubview(withIconCheckBox)
        addSubview(withActionCheckBox)
        addSubview(withComponentCheckBox)
        addSubview(lineView)
        addSubview(integrationLabel)
        addSubview(chipView)

        NSLayoutConstraint.activate([
            configurationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            configurationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            configurationStackView.topAnchor.constraint(equalTo: configurationLabel.bottomAnchor, constant: 16),
            configurationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            configurationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            withLabelCheckBox.topAnchor.constraint(equalTo: configurationStackView.bottomAnchor, constant: 10),
            withLabelCheckBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            withIconCheckBox.topAnchor.constraint(equalTo: withLabelCheckBox.bottomAnchor, constant: 10),
            withIconCheckBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            withActionCheckBox.topAnchor.constraint(equalTo: withIconCheckBox.bottomAnchor, constant: 10),
            withActionCheckBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            withComponentCheckBox.topAnchor.constraint(equalTo: withActionCheckBox.bottomAnchor, constant: 10),
            withComponentCheckBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            lineView.topAnchor.constraint(equalTo: withComponentCheckBox.bottomAnchor, constant: 16),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1),

            integrationLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            integrationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            chipView.topAnchor.constraint(equalTo: integrationLabel.bottomAnchor, constant: 16),
            chipView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }

    // MARK: - Publishers
    private func addPublishers() {

        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let color = self.viewModel.theme.colors.main.main.uiColor
            let themeTitle: String? = theme is SparkTheme ? viewModel.themes.first?.title : viewModel.themes.last?.title
            self.chipView.theme = theme
            self.themeButton.setTitle(themeTitle, for: .normal)
            self.themeButton.setTitleColor(color, for: .normal)
            self.intentButton.setTitleColor(color, for: .normal)
            self.variantButton.setTitleColor(color, for: .normal)
            self.withLabelCheckBox.theme = theme
            self.withIconCheckBox.theme = theme
            self.withActionCheckBox.theme = theme
            self.withComponentCheckBox.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.intentButton.setTitle(intent.name, for: .normal)
            self.chipView.intent = intent
        }

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.variantButton.setTitle(variant.name, for: .normal)
            self.chipView.variant = variant
        }

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] label in
            guard let self = self else { return }
            self.chipView.text = label
        }

        self.viewModel.$icon.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self = self else { return }
            self.chipView.icon = icon
        }

        self.viewModel.$component.subscribe(in: &self.cancellables) { [weak self] component in
            guard let self = self else { return }
            self.chipView.component = component
        }

        self.viewModel.$action.subscribe(in: &self.cancellables) { [weak self] action in
            guard let self = self else { return }
            self.chipView.action = action
        }

        self.withLabelCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.viewModel.text = state == .selected ? "Label" : nil
        }

        self.withIconCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.viewModel.icon = state == .selected ? UIImage(imageLiteralResourceName: "alert") : nil
        }

        self.withActionCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            let action = {
                let alertController = UIAlertController(title: "", message: "Chip Pressed", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                UIApplication.shared.topController?.present(alertController, animated: true)
            }
            self.viewModel.action = state == .selected ? action : nil

        }

        self.withComponentCheckBox.publisher.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            let component: UIView = UIImageView(image: UIImage.strokedCheckmark)
            self.viewModel.component = state == .selected ? component : nil
        }
    }
}
