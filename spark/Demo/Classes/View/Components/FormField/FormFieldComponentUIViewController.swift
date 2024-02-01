//
//  FormFieldComponentUIViewController.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI
import UIKit

final class FormFieldComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: FormFieldComponentUIView
    let viewModel: FormFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: FormFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = FormFieldComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = componentView
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FormField"
        addPublisher()
    }

    // MARK: - Add Publishers
    private func addPublisher() {

        self.themePublisher
            .$theme
            .sink { [weak self] theme in
                guard let self = self else { return }
                self.viewModel.theme = theme
                self.navigationController?.navigationBar.tintColor = theme.colors.main.main.uiColor
            }
            .store(in: &self.cancellables)

        self.viewModel.showThemeSheet.subscribe(in: &self.cancellables) { intents in
            self.presentThemeActionSheet(intents)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.cancellables) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showTitleSheet.subscribe(in: &self.cancellables) { titles in
            self.presentTitleStyleActionSheet(titles)
        }

        self.viewModel.showDescriptionSheet.subscribe(in: &self.cancellables) { descriptions in
            self.presentDescriptionStyleActionSheet(descriptions)
        }

        self.viewModel.showComponentSheet.subscribe(in: &self.cancellables) { components in
            self.presentComponentStyleActionSheet(components)
        }
    }
}

// MARK: - Builder
extension FormFieldComponentUIViewController {

    static func build() -> FormFieldComponentUIViewController {
        let viewModel = FormFieldComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = FormFieldComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension FormFieldComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [FormFieldIntent]) {
        let actionSheet = SparkActionSheet<FormFieldIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentTitleStyleActionSheet(_ textStyles: [FormFieldTextStyle]) {
        let actionSheet = SparkActionSheet<FormFieldTextStyle>.init(
            values: textStyles,
            texts: textStyles.map { $0.name }) { textStyle in
                self.viewModel.titleStyle = textStyle
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentDescriptionStyleActionSheet(_ textStyles: [FormFieldTextStyle]) {
        let actionSheet = SparkActionSheet<FormFieldTextStyle>.init(
            values: textStyles,
            texts: textStyles.map { $0.name }) { textStyle in
                self.viewModel.descriptionStyle = textStyle
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentComponentStyleActionSheet(_ componentStyles: [FormFieldComponentStyle]) {
        let actionSheet = SparkActionSheet<FormFieldComponentStyle>.init(
            values: componentStyles,
            texts: componentStyles.map { $0.name }) { componentStyle in
                self.viewModel.componentStyle = componentStyle
            }
        self.present(actionSheet, isAnimated: true)
    }
}
