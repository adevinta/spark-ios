//
//  ProgressTrackerComponentUIView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 26.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class ProgressTrackerComponentUIView: ComponentUIView {

    private var componentView: ProgressTrackerUIControl!

    // MARK: - Properties
    private let viewModel: ProgressTrackerComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var sizeConstraints = [NSLayoutConstraint]()

    // MARK: - Initializer
    init(viewModel: ProgressTrackerComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeProgressTrackerView(viewModel: viewModel)

        super.init(viewModel: viewModel, componentView: componentView)

        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeProgressTrackerView(viewModel: ProgressTrackerComponentUIViewModel) -> ProgressTrackerUIControl {
        let view = ProgressTrackerUIControl(
            theme: viewModel.theme,
            intent: viewModel.intent,
            variant: viewModel.variant,
            size: viewModel.size
        )
        return view
    }

    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.viewModel.sizeConfigurationItemViewModel.buttonTitle = size.name
            self.componentView.size = size
        }

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.componentView.variant = variant
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$content.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }
            self.viewModel.contentConfigurationItemViewModel.buttonTitle = content.name

//            self.componentView.content = content.content
        }

        self.viewModel.$isDisabled.subscribe(in: &self.cancellables) { [weak self] isDisabled in
            guard let self else { return }
            self.componentView.isEnabled = !isDisabled
        }

        self.viewModel.$isSelected.subscribe(in: &self.cancellables) { [weak self] isSelected in
            guard let self else { return }
            self.componentView.isSelected = isSelected
        }

        self.viewModel.$isTouchable.subscribe(in: &self.cancellables) { [weak self] isTouchable in
            guard let self else { return }
            self.componentView.isUserInteractionEnabled = isTouchable
        }
    }
}
