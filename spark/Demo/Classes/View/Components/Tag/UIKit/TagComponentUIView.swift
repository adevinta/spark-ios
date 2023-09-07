//
//  TagComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 01.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class TagComponentUIView: ComponentUIView {

    // MARK: - Components
    private let componentView: TagUIView

    // MARK: - Properties

    private let viewModel: TagComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: TagComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeTagView(viewModel)

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

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.componentView.variant = variant
        }

        self.viewModel.$content.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentConfigurationItemViewModel.buttonTitle = content.name

            switch content {
            case .text:
                self.componentView.iconImage = nil
                self.componentView.text = viewModel.text
            case .icon:
                self.componentView.text = nil
                self.componentView.iconImage = viewModel.image

            case .all:
                self.componentView.text = viewModel.text
                self.componentView.iconImage = viewModel.image
            }
        }
    }

    static private func makeTagView(_ viewModel: TagComponentUIViewModel) -> TagUIView {
        var tagView: TagUIView

        switch viewModel.content {
        case .icon:
            tagView = TagUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                iconImage: viewModel.image
            )

        case .text:
            tagView = TagUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                text: viewModel.text
            )

        case .all:
            tagView = TagUIView(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                iconImage: viewModel.image,
                text: viewModel.text
            )
        }
        return tagView
    }
}
