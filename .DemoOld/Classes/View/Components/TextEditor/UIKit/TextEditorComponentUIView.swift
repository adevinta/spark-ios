//
//  TextEditorComponentUIView.swift
//  SparkDemo
//
//  Created by alican.aycil on 12.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import UIKit
@_spi(SI_SPI) import SparkCommon

final class TextEditorComponentUIView: ComponentUIView, UIGestureRecognizerDelegate {

    // MARK: - Components

    private var componentView: TextEditorUIView

    // MARK: - Properties

    private let viewModel: TextEditorComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    private var widthLayoutConstraint: NSLayoutConstraint
    private var heightLayoutConstraint: NSLayoutConstraint

    // MARK: - Initializer

    init(viewModel: TextEditorComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeTextEditorView(viewModel)

        // Constraints
        self.widthLayoutConstraint = self.componentView.widthAnchor.constraint(equalToConstant: 300)
        self.heightLayoutConstraint = self.componentView.heightAnchor.constraint(equalToConstant: 100)

        super.init(
            viewModel: viewModel,
            componentView: self.componentView
        )

        // Setup
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTapped))
        tap.delegate = self
        addGestureRecognizer(tap)

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
            self.componentView.text = Self.setText(type: type)
        }

        self.viewModel.$placeholder.subscribe(in: &self.cancellables) { [weak self] type in
            guard let self = self else { return }
            self.viewModel.placeholderConfigurationItemViewModel.buttonTitle = type.name
            self.componentView.placeholder = Self.setText(type: type)
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) {  [weak self] isEnabled in
            guard let self = self else { return }
            self.componentView.isEnabled = isEnabled
        }

        self.viewModel.$isEditable.subscribe(in: &self.cancellables) {  [weak self] isEditable in
            guard let self = self else { return }
            self.componentView.isEditable = isEditable
        }

        self.viewModel.$isStaticSizes.subscribe(in: &self.cancellables) {  [weak self] isStaticSizes in
            guard let self = self else { return }
            self.widthLayoutConstraint.isActive = isStaticSizes
            self.heightLayoutConstraint.isActive = isStaticSizes
            self.componentView.isScrollEnabled = isStaticSizes
        }
    }

    static private func makeTextEditorView(_ viewModel: TextEditorComponentUIViewModel) -> TextEditorUIView {
        let view = TextEditorUIView(
            theme: viewModel.theme,
            intent: viewModel.intent
        )
        view.text = TextEditorComponentUIView.setText(type: viewModel.text)
        view.placeholder = TextEditorComponentUIView.setText(type: viewModel.placeholder)
        view.isEnabled = viewModel.isEnabled
        view.isEditable = viewModel.isEditable
        view.isScrollEnabled = viewModel.isStaticSizes
        return view
    }

    static private func setText(type: TextEditorContent) -> String {
        switch type {
        case .none:
            return ""
        case .short:
            return "What is Lorem Ipsum?"
        case .medium:
            return "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        case .long:
            return "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
        }
    }

    @objc private func viewDidTapped() {
        _ = self.componentView.resignFirstResponder()
    }
}
