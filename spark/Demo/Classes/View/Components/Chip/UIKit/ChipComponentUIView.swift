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

final class ChipComponentUIView: ComponentUIView {

    private var componentView: ChipUIView!

    // MARK: - Properties
    private let viewModel: ChipComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: ChipComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeChipView(viewModel: viewModel)

        super.init(viewModel: viewModel, componentView: componentView)

        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeChipView(viewModel: ChipComponentUIViewModel) -> ChipUIView {
        let chipView = ChipUIView(theme: viewModel.theme,
                                  intent: viewModel.intent,
                                  variant: viewModel.variant,
                                  label: viewModel.title ?? "No Title")
        return chipView

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


        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.componentView.variant = variant
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent

            if intent == .surface {
                self.componentStackView.backgroundColor = .darkGray
            } else {
                self.componentStackView.backgroundColor = .clear
            }
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            self?.componentView.alignment = alignment
        }

        self.viewModel.$title.subscribe(in: &self.cancellables) { [weak self] title in
            guard let self = self else { return }

            self.componentView.text = title
        }

        self.viewModel.$icon.subscribe(in: &self.cancellables) { [weak self] icon in
            guard let self = self else { return }

            self.componentView.icon = icon
        }

        self.viewModel.$badge.subscribe(in: &self.cancellables) { [weak self] badge in
            guard let self = self else { return }

            if let _ = badge as? UIButton {
                self.componentView.enableComponentUserInteraction(true)
            } else {
                self.componentView.enableComponentUserInteraction(false)
            }
            self.componentView.component = badge
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) {  [weak self] isEnabled in
            guard let self = self else { return }
            self.componentView.isEnabled = isEnabled
        }

        self.viewModel.$isSelected.subscribe(in: &self.cancellables) { [weak self] isSelected in
            guard let self = self else { return }

            self.componentView.isSelected = isSelected
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.componentView.isEnabled = isEnabled
        }

        self.viewModel.$action.subscribe(in: &self.cancellables) { [weak self] action in
            guard let self = self else { return }

            self.componentView.action = action.map{ [weak self] _ in { self?.showAlert() } }
        }
    }

    func showAlert() {
        let alertController = UIAlertController(
            title: "Chip tap",
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Ok", style: .default))
        self.viewController?.present(alertController, animated: true)
    }
}
