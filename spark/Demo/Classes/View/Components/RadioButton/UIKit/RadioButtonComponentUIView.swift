//
//  RadioButtonComponentUIView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 23.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import SparkCore
import UIKit

final class RadioButtonComponentUIView: ComponentUIView {
    // MARK: - Components
    private let componentView: RadioButtonUIGroupView<Int>

    // MARK: - Properties

    private let viewModel: RadioButtonComponentUIViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(viewModel: RadioButtonComponentUIViewModel) {
        self.viewModel = viewModel
        let componentView = Self.makeRadioButtonView(viewModel)
        self.componentView = componentView

        super.init(
            viewModel: viewModel,
            componentView: componentView
        )

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

        self.viewModel.$labelAlignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.componentView.labelAlignment = alignment
        }

        self.viewModel.$axis.subscribe(in: &self.cancellables) { [weak self] axis in
            guard let self = self else { return }
            self.componentView.groupLayout = axis
        }

        self.viewModel.$showLongLabel.subscribe(in: &self.cancellables) { [weak self] showLongLabel in
            guard let self = self else { return }

            let index = self.componentView.items.count > 1 ? 1 : 0

            self.componentView.setTitle(self.viewModel.label(at: index), forItemAt: index)

            if self.viewModel.showAttributedLabel {
                if showLongLabel {
                    self.componentView.setTitle(self.viewModel.longTitleAttributed(at: index), forItemAt: index)
                } else {
                    self.componentView.setTitle(self.viewModel.shortTitleAttributed(at: index), forItemAt: index)
                }
            } else {
                if showLongLabel {
                    self.componentView.setTitle(self.viewModel.longTitle(at: index), forItemAt: index)
                } else {
                    self.componentView.setTitle(self.viewModel.shortTitle(at: index), forItemAt: index)
                }
            }
        }

        self.viewModel.$showAttributedLabel.subscribe(in: &self.cancellables) { [weak self] showAttributedLabel in
            guard let self = self else { return }

            let index = self.componentView.items.count > 1 ? 1 : 0

            if showAttributedLabel {
                self.componentView.setTitle(self.viewModel.attributedLabel(at: index), forItemAt: index)
            } else {
                self.componentView.setTitle(self.viewModel.label(at: index), forItemAt: index)
            }
        }

        self.viewModel.$isDisabled.subscribe(in: &self.cancellables) { [weak self] disabled in
            self?.componentView.isEnabled = !disabled
        }

        self.viewModel.$numberOfRadioButtons.subscribe(in: &self.cancellables) { [weak self] numberOfRadioButtons in
            guard let self = self else { return }

            if numberOfRadioButtons < self.componentView.numberOfItems {
                self.componentView.removeRadioButton(
                    at: self.componentView.numberOfItems - 1,
                    animated: true)
            } else {
                let index = numberOfRadioButtons - 1
                let content = self.viewModel.content[index]
                self.componentView.addRadioButton(content)
            }
        }
    }

    // MARK: - Private construction helper
    static private func makeRadioButtonView(_ viewModel: RadioButtonComponentUIViewModel) -> RadioButtonUIGroupView<Int> {
        let component = RadioButtonUIGroupView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            selectedID: viewModel.selectedRadioButton,
            items: viewModel.content,
            labelAlignment: viewModel.labelAlignment,
            groupLayout: viewModel.axis
        )

        component.title = "Radio Button Group (UIKit)"
        component.supplementaryText = "Radio Button Group Supplementary Text"

        return component
    }
}