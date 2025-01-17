//
//  DividerComponentUIView.swift
//  SparkDemo
//
//  Created by louis.borlee on 31/07/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import UIKit
@_spi(SI_SPI) import SparkCommon

final class DividerComponentUIView: ComponentUIView {

    // MARK: - Components
    private let componentView: DividerUIView

    // MARK: - Properties

    private let viewModel: DividerComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    private var heightConstraint = NSLayoutConstraint()

    // MARK: - Initializer
    init(viewModel: DividerComponentUIViewModel) {
        self.viewModel = viewModel

        let divider = DividerUIView(
            theme: self.viewModel.theme,
            intent: self.viewModel.intent
        )
        divider.label.text = self.viewModel.text
        divider.label.numberOfLines = 0
        divider.axis = self.viewModel.axis
        divider.alignment = self.viewModel.alignment

        self.componentView = divider

        super.init(
            viewModel: viewModel,
            integrationStackViewAlignment: .fill,
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

        self.viewModel.$axis.subscribe(in: &self.cancellables) { [weak self] axis in
            guard let self = self else { return }
            self.viewModel.axisConfigurationItemViewModel.buttonTitle = axis.name
            self.componentView.axis = axis
            if axis == .vertical {
                self.heightConstraint = self.componentView.heightAnchor.constraint(equalToConstant: 300)
                self.heightConstraint.isActive = true
            } else {
                self.heightConstraint.isActive = false
                self.componentView.removeConstraint(self.heightConstraint)
            }
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.componentView.alignment = alignment
        }

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] text in
            guard let self = self else { return }
            self.viewModel.textConfigurationItemViewModel.buttonTitle = text
            self.componentView.label.text = text
            if let text, text.isEmpty == false {
                self.componentView.showLabel = true
            } else {
                self.componentView.showLabel = false
            }
        }
    }
}
