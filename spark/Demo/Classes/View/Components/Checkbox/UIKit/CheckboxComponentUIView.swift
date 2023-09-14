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

        self.viewModel.$state.subscribe(in: &self.cancellables) { [weak self] state in
            guard let self = self else { return }
            self.viewModel.stateConfigurationItemViewModel.buttonTitle = state.name
            self.componentView.state = state
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.componentView.alignment = alignment
        }

        self.viewModel.$isMultilineText.subscribe(in: &self.cancellables) { [weak self] isMultilineText in
            guard let self = self else { return }
            self.viewModel.isMultilineConfigurationItemViewModel.isOn = isMultilineText
            self.componentView.text = isMultilineText ? viewModel.multilineText : viewModel.text
        }
    }

    static func makeCheckboxView(_ viewModel: CheckboxComponentUIViewModel) -> CheckboxUIView {

        return CheckboxUIView(
            theme: viewModel.theme,
            text: viewModel.isMultilineText ? viewModel.multilineText : viewModel.text,
            checkedImage: viewModel.image,
            state: viewModel.state,
            selectionState: viewModel.selectionState,
            checkboxPosition: viewModel.alignment
        )
    }
}
