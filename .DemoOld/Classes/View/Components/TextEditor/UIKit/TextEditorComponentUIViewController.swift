//
//  TextEditorComponentUIViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 29.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon

final class TextEditorComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: TextEditorComponentUIView
    let viewModel: TextEditorComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: TextEditorComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = TextEditorComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)

        self.componentView.viewController = self
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
        self.navigationItem.title = "TextEditor"
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

        self.viewModel.showTextSheet.subscribe(in: &self.cancellables) { types in
            self.presentTextActionSheet(types)
        }

        self.viewModel.showPlaceholderSheet.subscribe(in: &self.cancellables) { types in
            self.presentPlaceholdderActionSheet(types)
        }
    }
}

// MARK: - Builder
extension TextEditorComponentUIViewController {

    static func build() -> TextEditorComponentUIViewController {
        let viewModel = TextEditorComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return TextEditorComponentUIViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension TextEditorComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [TextEditorIntent]) {
        let actionSheet = SparkActionSheet<TextEditorIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentTextActionSheet(_ types: [TextEditorContent]) {
        let actionSheet = SparkActionSheet<TextEditorContent>.init(
            values: types,
            texts: types.map{ $0.name }) { text in
                self.viewModel.text = text
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentPlaceholdderActionSheet(_ types: [TextEditorContent]) {
        let actionSheet = SparkActionSheet<TextEditorContent>.init(
            values: types,
            texts: types.map{ $0.name }) { text in
                self.viewModel.placeholder = text
            }
            self.present(actionSheet, isAnimated: true)
    }
}
