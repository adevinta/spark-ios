//
//  FormFieldComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class FormFieldComponentUIView: ComponentUIView {

    // MARK: - Components
    private let componentView: FormFieldUIView

    // MARK: - Properties

    private let viewModel: FormFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: FormFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeFormField(viewModel)

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
            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$titleStyle.subscribe(in: &self.cancellables) { [weak self] textStyle in
            guard let self = self else { return }
            self.viewModel.titleStyleConfigurationItemViewModel.buttonTitle = textStyle.name
            switch textStyle {
            case .text:
                self.componentView.title = self.viewModel.text
            case .multilineText:
                self.componentView.title = self.viewModel.multilineText
            case .attributeText:
                self.componentView.attributedTitle = self.viewModel.attributeText
            case .none:
                self.componentView.title = nil
            }
        }

        self.viewModel.$descriptionStyle.subscribe(in: &self.cancellables) { [weak self] textStyle in
            guard let self = self else { return }
            self.viewModel.descriptionStyleConfigurationItemViewModel.buttonTitle = textStyle.name
            switch textStyle {
            case .text:
                self.componentView.descriptionString = self.viewModel.descriptionText
            case .multilineText:
                self.componentView.descriptionString = self.viewModel.multilineText
            case .attributeText:
                self.componentView.attributedDescription = self.viewModel.attributeText
            case .none:
                self.componentView.descriptionString = nil
            }
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) {  [weak self] isEnabled in
            guard let self = self else { return }
            self.componentView.isEnabled = isEnabled
        }
    }

    // MARK: - Create View
    static func makeFormField(_ viewModel: FormFieldComponentUIViewModel) -> FormFieldUIView {
        return .init(
            theme: viewModel.theme,
            intent: .support,
            title: "Agreement",
            description: "Your agreement is important to us.",
            component: Self.makeBasicView()
        )
    }

    static func makeBasicView() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.lightGray
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }


}
