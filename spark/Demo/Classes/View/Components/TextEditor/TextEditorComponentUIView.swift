//
//  TextEditorComponentUIView.swift
//  SparkDemo
//
//  Created by alican.aycil on 12.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class TextEditorComponentUIView: ComponentUIView, UIGestureRecognizerDelegate {

    // MARK: - Components
    private let componentView: TextEditorUIView

    // MARK: - Properties

    private let viewModel: TextEditorComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: TextEditorComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeTextEditorView(viewModel)

        super.init(
            viewModel: viewModel,
            componentView: self.componentView
        )

        // Setup
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTapped))
        tap.delegate = self
        addGestureRecognizer(tap)
        self.componentView.translatesAutoresizingMaskIntoConstraints = false
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

        self.viewModel.$text.subscribe(in: &self.cancellables) { [weak self] type in
            guard let self = self else { return }
            self.viewModel.textConfigurationItemViewModel.buttonTitle = type.name
            switch type {
            case .none:
                self.componentView.text = ""
            case .short:
                self.componentView.text = "What is Lorem Ipsum?"
            case .medium:
                self.componentView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            case .long:
                self.componentView.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
            }
        }

        self.viewModel.$placeholder.subscribe(in: &self.cancellables) { [weak self] type in
            guard let self = self else { return }
            self.viewModel.placeholderConfigurationItemViewModel.buttonTitle = type.name
            switch type {
            case .none:
                self.componentView.placeHolder = ""
            case .short:
                self.componentView.placeHolder = "What is Lorem Ipsum?"
            case .medium:
                self.componentView.placeHolder = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            case .long:
                self.componentView.placeHolder = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
            }
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) {  [weak self] isEnabled in
            guard let self = self else { return }
            self.componentView.isEnabled = isEnabled
        }

        self.viewModel.$isReadonly.subscribe(in: &self.cancellables) {  [weak self] isReadonly in
            guard let self = self else { return }
            self.componentView.isReadOnly = isReadonly
        }

        self.viewModel.$isDynamicHeight.subscribe(in: &self.cancellables) {  [weak self] isDynamicHeight in
            guard let self = self else { return }
            self.componentView.isScrollEnabled = !isDynamicHeight
        }
    }

    static private func makeTextEditorView(_ viewModel: TextEditorComponentUIViewModel) -> TextEditorUIView {
        return  TextEditorUIView(
            theme: viewModel.theme,
            intent: viewModel.intent
        )
    }

    @objc private func viewDidTapped() {
        _ = self.componentView.resignFirstResponder()
    }
}
