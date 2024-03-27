//
//  TextFieldAddonsComponentUIViewController.swift
//  SparkDemo
//
//  Created by louis.borlee on 14/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI
import SparkCore

final class TextFieldAddonsComponentUIViewController: UIViewController {

    // MARK: - Properties
    let componentView: TextFieldAddonsComponentUIView
    let viewModel: TextFieldAddonsComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Initializer
    init(viewModel: TextFieldAddonsComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = TextFieldAddonsComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.componentView.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = self.componentView
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "TextFieldAddons"
        self.setupSubscriptions()
    }

    private func setupSubscriptions() {
        self.themePublisher
            .$theme
            .sink { [weak self] theme in
                guard let self = self else { return }
                self.viewModel.theme = theme
                self.navigationController?.navigationBar.tintColor = theme.colors.main.main.uiColor
            }
            .store(in: &self.cancellables)

        self.viewModel.showThemeSheet.subscribe(in: &self.cancellables) { theme in
            self.presentThemeActionSheet(theme)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.cancellables) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showLeftViewContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentSideViewContentActionSheet(contents) { content in
                self.viewModel.leftViewContent = content
            }
        }

        self.viewModel.showRightViewContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentSideViewContentActionSheet(contents) { content in
                self.viewModel.rightViewContent = content
            }
        }

        self.viewModel.showLeftAddonContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentAddonContentActionSheet(contents) { content in
                self.viewModel.leftAddonContent = content
            }
        }

        self.viewModel.showRightAddonContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentAddonContentActionSheet(contents) { content in
                self.viewModel.rightAddonContent = content
            }
        }
    }

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [TextFieldIntent]) {
        let actionSheet = SparkActionSheet<TextFieldIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentSideViewContentActionSheet(_ contents: [TextFieldSideViewContent], completion: @escaping (TextFieldSideViewContent) -> Void) {
        let actionSheet = SparkActionSheet<TextFieldSideViewContent>.init(
            values: contents,
            texts: contents.map { $0.name },
            completion: completion)
        self.present(actionSheet, animated: true)
    }

    private func presentAddonContentActionSheet(_ contents: [TextFieldAddonContent], completion: @escaping (TextFieldAddonContent) -> Void) {
        let actionSheet = SparkActionSheet<TextFieldAddonContent>.init(
            values: contents,
            texts: contents.map { $0.name },
            completion: completion)
        self.present(actionSheet, animated: true)
    }
}

extension TextFieldAddonsComponentUIViewController {
    static func build() -> TextFieldAddonsComponentUIViewController {
        let viewModel = TextFieldAddonsComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = TextFieldAddonsComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}
