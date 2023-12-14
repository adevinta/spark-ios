//
//  RatingInputComponentUIView.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 29.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

import UIKit
import Combine
import SparkCore
import Spark

final class RatingInputComponentUIView: ComponentUIView {

    private var componentView: RatingInputUIView!

    // MARK: - Properties
    private let viewModel: RatingInputComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var sizeConstraints = [NSLayoutConstraint]()

    // MARK: - Initializer
    init(viewModel: RatingInputComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeRatingInputView(viewModel: viewModel)

        super.init(viewModel: viewModel, componentView: componentView)

        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func makeRatingInputView(viewModel: RatingInputComponentUIViewModel) -> RatingInputUIView {
        let view = RatingInputUIView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            rating: viewModel.rating
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

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$rating.subscribe(in: &self.cancellables) { [weak self] rating in
            guard let self = self else { return }
            self.componentView.rating = rating
        }

        self.viewModel.$isDisabled.subscribe(in: &self.cancellables) { [weak self] disabled in
            self?.componentView.isEnabled = !disabled
        }
    }
}
