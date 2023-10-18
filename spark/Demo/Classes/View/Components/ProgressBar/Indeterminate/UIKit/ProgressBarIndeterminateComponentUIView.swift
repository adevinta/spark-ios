//
//  ProgressBarIndeterminateComponentUIView.swift
//  Spark
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class ProgressBarIndeterminateComponentUIView: ComponentUIView {

    // MARK: - Components

    private var componentView: ProgressBarIndeterminateUIView

    // MARK: - Properties

    private let viewModel: ProgressBarIndeterminateComponentUIViewModel
    private var subcriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(viewModel: ProgressBarIndeterminateComponentUIViewModel) {
        self.viewModel = viewModel

        self.componentView = .init(
            theme: self.viewModel.theme,
            intent: self.viewModel.intent,
            shape: self.viewModel.shape
        )

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
        self.viewModel.$theme.subscribe(in: &self.subcriptions) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.subcriptions) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$shape.subscribe(in: &self.subcriptions) { [weak self] shape in
            guard let self = self else { return }
            self.viewModel.shapeConfigurationItemViewModel.buttonTitle = shape.name
            self.componentView.shape = shape
        }

        self.viewModel.$isAnimating.subscribe(in: &self.subcriptions) { [weak self] isAnimating in
            guard let self = self else { return }
            if isAnimating {
                self.componentView.startAnimating()
            } else {
                self.componentView.stopAnimating()
            }
        }
    }
}
