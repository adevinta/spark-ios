//
//  FormFieldComponentUIViewController.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon

final class FormFieldComponentUIViewController<S: UIView>: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: FormFieldComponentUIView<S>
    let viewModel: FormFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(
        view: FormFieldComponentUIView<S>,
        viewModel: FormFieldComponentUIViewModel
    ) {
        self.viewModel = viewModel
        self.componentView = view
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

        self.viewModel.showFeedbackStateSheet.subscribe(in: &self.cancellables) { feedbackStates in
            self.presentIntentActionSheet(feedbackStates)
        }

        self.viewModel.showTitleSheet.subscribe(in: &self.cancellables) { titles in
            self.presentTitleStyleActionSheet(titles)
        }

        self.viewModel.showHelperSheet.subscribe(in: &self.cancellables) { helpers in
            self.presentHelperStyleActionSheet(helpers)
        }
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

    private func presentIntentActionSheet(_ intents: [FormFieldFeedbackState]) {
        let actionSheet = SparkActionSheet<FormFieldFeedbackState>.init(
            values: intents,
            texts: intents.map { $0.name }) { feedbackState in
                self.viewModel.feedbackState = feedbackState
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

    private func presentHelperStyleActionSheet(_ textStyles: [FormFieldTextStyle]) {
        let actionSheet = SparkActionSheet<FormFieldTextStyle>.init(
            values: textStyles,
            texts: textStyles.map { $0.name }) { textStyle in
                self.viewModel.helperStyle = textStyle
            }
        self.present(actionSheet, isAnimated: true)
    }
}
