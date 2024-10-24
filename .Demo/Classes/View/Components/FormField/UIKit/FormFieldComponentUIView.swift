//
//  FormFieldComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import UIKit
@_spi(SI_SPI) import SparkCommon

final class FormFieldComponentUIView<S: UIView>: ComponentUIView {

    // MARK: - Components
    private let componentView: FormFieldUIView<S>

    // MARK: - Properties

    private let viewModel: FormFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    private var textCounter: String?

    // MARK: - Initializer
    init(
        viewModel: FormFieldComponentUIViewModel,
        component: FormFieldUIView<S>
    ) {
        self.viewModel = viewModel
        self.componentView = component

        super.init(
            viewModel: viewModel,
            componentView: self.componentView
        )

        // Setup
        self.setupSubscriptions()
        self.setupTextFieldActions()
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

        self.viewModel.$feedbackState.subscribe(in: &self.cancellables) { [weak self] feedbackState in
            guard let self = self else { return }
            self.viewModel.feedbackStateConfigurationItemViewModel.buttonTitle = feedbackState.name
            self.componentView.feedbackState = feedbackState
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

        self.viewModel.$helperStyle.subscribe(in: &self.cancellables) { [weak self] textStyle in
            guard let self = self else { return }
            self.viewModel.helperStyleConfigurationItemViewModel.buttonTitle = textStyle.name
            switch textStyle {
            case .text:
                self.componentView.helperString = self.viewModel.helperText
            case .multilineText:
                self.componentView.helperString = self.viewModel.multilineText
            case .attributeText:
                self.componentView.attributedHelper = self.viewModel.attributeText
            case .none:
                self.componentView.helperString = nil
            }
        }

        self.viewModel.$isTitleRequired.subscribe(in: &self.cancellables) {  [weak self] isTitleRequired in
            guard let self = self else { return }
            self.componentView.isTitleRequired = isTitleRequired
        }

        self.viewModel.$isSecondaryHelper.subscribe(in: &self.cancellables) {  [weak self] isSecondaryHelper in
            guard let self = self else { return }
            self.componentView.setCounterIfPossible(
                on: self.textCounter,
                limit: isSecondaryHelper ? 100 : nil
            )
        }

        self.viewModel.$containerViewAlignment.subscribe(in: &self.cancellables) { [weak self] containerViewAlignment in
            guard let self = self else { return }
            self.integrationStackViewAlignment = containerViewAlignment ? .fill : .leading
        }
    }

    private func setupTextFieldActions() {
        if let textField = self.componentView.component as? TextFieldUIView {
            textField.addAction(.init(handler: { [weak self] _ in
                guard let self else { return }
                self.textCounter = textField.text
                self.componentView.setCounterIfPossible(
                    on: self.textCounter,
                    limit: self.viewModel.isSecondaryHelper ? 100 : nil
                )
            }), for: .editingChanged)
        }
    }
}

// MARK: - Extension

extension FormFieldUIView {

    func setCounterIfPossible(on text: String?, limit: Int?) {
        if let view = self as? FormFieldUIView<TextFieldUIView> {
            view.setCounter(on: text, limit: limit)
            guard let limit else { return }

            view.secondaryHelperLabel.accessibilityLabel = "\(text?.count ?? 0) caractères sur \(limit)"
        }
    }
}
