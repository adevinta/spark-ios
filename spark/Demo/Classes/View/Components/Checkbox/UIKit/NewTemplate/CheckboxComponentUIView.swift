//
//  CheckboxComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 14.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class CheckboxComponentUIView: ComponentUIView {

    // MARK: - Components
    private let componentView: CheckboxUIView

    // MARK: - Properties

    private let viewModel: CheckboxComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: CheckboxComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeCheckboxView(viewModel)

        super.init(
            viewModel: viewModel,
            componentView: self.componentView
        )

        // Setup
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subscribe
    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.viewModel.isEnableConfigurationItemViewModel.isOn = isEnabled
            self.componentView.isEnabled = isEnabled
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.componentView.alignment = alignment
        }

        self.viewModel.$textStyle.subscribe(in: &self.cancellables) { [weak self] textStyle in
            guard let self = self else { return }
            self.viewModel.textStyleConfigurationItemViewModel.buttonTitle = textStyle.name
            switch textStyle {
            case .text:
                self.componentView.text = self.viewModel.text
            case .multilineText:
                self.componentView.text = self.viewModel.multilineText
            case .attributeText:
                self.componentView.attributedText = self.viewModel.attributeText
            case .none:
                self.componentView.text = nil
            }
        }

        self.viewModel.$icon.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self = self else { return }
            self.viewModel.iconConfigurationItemViewModel.buttonTitle = icon.map { $0.0 }.first
            self.componentView.checkedImage = icon.map { $0.1 }.first ?? UIImage()
        }

        self.viewModel.$isIndeterminate.subscribe(in: &self.cancellables) { [weak self] isIndeterminate in
            guard let self = self else { return }
            self.componentView.selectionState = isIndeterminate ? .indeterminate : .selected
        }
    }

    static func makeCheckboxView(_ viewModel: CheckboxComponentUIViewModel) -> CheckboxUIView {

        switch viewModel.textStyle {
        case .attributeText:
            return CheckboxUIView(
                theme: viewModel.theme,
                attributedText: viewModel.attributeText,
                checkedImage: viewModel.icon.map { $0.1 }.first ?? UIImage(),
                isEnabled: viewModel.isEnabled,
                selectionState: viewModel.selectionState,
                checkboxAlignment: viewModel.alignment
            )
        case .text, .multilineText:
            return CheckboxUIView(
                theme: viewModel.theme,
                text: viewModel.textStyle == .multilineText ? viewModel.multilineText : viewModel.text,
                checkedImage: viewModel.icon.map { $0.1 }.first ?? UIImage(),
                isEnabled: viewModel.isEnabled,
                selectionState: viewModel.selectionState,
                checkboxAlignment: viewModel.alignment
            )
        case .none:
            return CheckboxUIView(
                theme: viewModel.theme,
                text: "",
                checkedImage: viewModel.icon.map { $0.1 }.first ?? UIImage(),
                isEnabled: viewModel.isEnabled,
                selectionState: viewModel.selectionState,
                checkboxAlignment: viewModel.alignment
            )
        }
    }
}
