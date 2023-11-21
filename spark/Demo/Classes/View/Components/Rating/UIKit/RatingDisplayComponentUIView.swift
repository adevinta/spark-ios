//
//  RatingDisplayUIView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

import UIKit
import Combine
import SparkCore
import Spark

final class RatingDisplayComponentUIView: ComponentUIView {

    private var componentView: RatingDisplayUIView!

    // MARK: - Properties
    private let viewModel: RatingDisplayComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var sizeConstraints = [NSLayoutConstraint]()

    // MARK: - Initializer
    init(viewModel: RatingDisplayComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeRatingDisplayView(viewModel: viewModel)

        super.init(viewModel: viewModel, componentView: componentView)

        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeRatingDisplayView(viewModel: RatingDisplayComponentUIViewModel) -> RatingDisplayUIView {
        let view = RatingDisplayUIView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            count: viewModel.count,
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

        self.viewModel.$count.subscribe(in: &self.cancellables) { [weak self] count in
            guard let self = self else { return }
            self.viewModel.countConfigurationItemViewModel.buttonTitle = count.name
            self.componentView.count = count
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$rating.subscribe(in: &self.cancellables) { [weak self] rating in
            guard let self = self else { return }
            self.componentView.rating = rating
        }
    }
}
