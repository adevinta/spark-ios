//
//  CheckboxGroupComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 16.10.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class CheckboxGroupComponentUIView: ComponentUIView {

    // MARK: - Components
    private let componentView: CheckboxGroupUIView

    // MARK: - Properties

    private let viewModel: CheckboxGroupComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: CheckboxGroupComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeCheckboxGroupView(viewModel)
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

        self.viewModel.$icon.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self = self else { return }
            self.viewModel.iconConfigurationItemViewModel.buttonTitle = icon.map { $0.0 }.first
            self.componentView.checkedImage = icon.map { $0.1 }.first ?? UIImage()
        }

        self.viewModel.$isAlignmentLeft.subscribe(in: &self.cancellables) { [weak self] isAlignmentLeft in
            guard let self = self else { return }
            self.componentView.checkboxAlignment = isAlignmentLeft ? .left : .right
        }

        self.viewModel.$isLayoutVertical.subscribe(in: &self.cancellables) { [weak self] isLayoutVertical in
            guard let self = self else { return }
            self.componentView.layout = isLayoutVertical ? .vertical : .horizontal
        }

        self.viewModel.$showGroupTitle.subscribe(in: &self.cancellables) { [weak self] showGroupTitle in
            guard let self = self else { return }
            self.componentView.title = showGroupTitle ? viewModel.title : ""
        }
    }

    static func makeCheckboxGroupView(_ viewModel: CheckboxGroupComponentUIViewModel) -> CheckboxGroupUIView {

        CheckboxGroupUIView(
            checkedImage: viewModel.icon.map { $0.1 }.first ?? UIImage(),
            items: [
                CheckboxGroupItem(title: viewModel.text, id: "1", selectionState: .selected),
                CheckboxGroupItem(title: viewModel.multilineText, id: "2", selectionState: .unselected),
                CheckboxGroupItem(attributedTitle: viewModel.attributeText, id: "3", selectionState: .indeterminate),
                CheckboxGroupItem(title: viewModel.text, id: "4", selectionState: .indeterminate)
            ],
            checkboxAlignment: viewModel.isAlignmentLeft ? .left : .right,
            theme: viewModel.theme,
            intent: viewModel.intent,
            accessibilityIdentifierPrefix: "Entry"
        )
    }
}
