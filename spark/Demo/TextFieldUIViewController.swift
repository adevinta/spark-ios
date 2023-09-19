//
//  TextFieldUIViewController.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SwiftUI
import UIKit
import SparkCore

class TextFieldUIViewController: UIViewController {

    let textFieldComponentUIView: TextFieldComponentUIView
    let viewModel: TextFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Initializer
    init(viewModel: TextFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.textFieldComponentUIView = TextFieldComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
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

        self.viewModel.showVariantSheet.subscribe(in: &self.cancellables) { variants in
            self.presentVariantActionSheet(variants)
        }

        self.viewModel.showViewModeSheet.subscribe(in: &self.cancellables) { viewMode in
            self.presentViewModeActionSheet(viewMode)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = textFieldComponentUIView
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TextField"
        self.addPublisher()
    }

}

extension TextFieldUIViewController {

    static func build() -> TextFieldUIViewController {
        let viewModel = TextFieldComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = TextFieldUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension TextFieldUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [ChipIntent]) {
        let actionSheet = SparkActionSheet<ChipIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentVariantActionSheet(_ variants: [ChipVariant]) {
        let actionSheet = SparkActionSheet<ChipVariant>.init(
            values: variants,
            texts: variants.map{ $0.name }) { variant in
                self.viewModel.variant = variant
            }
            self.present(actionSheet, animated: true)
    }

    private func presentViewModeActionSheet(_ viewModes: [ViewMode]) {
        let actionSheet = SparkActionSheet<ViewMode>.init(values: viewModes,
                                                          texts: viewModes.map{ $0.name }) { viewMode in
            self.viewModel.viewMode = viewMode
        }
        self.present(actionSheet, animated: true)
    }
}
