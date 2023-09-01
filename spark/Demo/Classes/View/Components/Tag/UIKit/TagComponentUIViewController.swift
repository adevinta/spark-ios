//
//  TagComponentUIViewController.swift
//  Spark
//
//  Created by alican.aycil on 01.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI
import UIKit

final class TagComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: TagComponentUIView
    let viewModel: TagComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: TagComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = TagComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Tag"
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

        self.viewModel.showVariantSheet.subscribe(in: &self.cancellables) { variants in
            self.presentVariantActionSheet(variants)
        }

        self.viewModel.showContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentContentActionSheet(contents)
        }
    }
}

// MARK: - Builder
extension TagComponentUIViewController {

    static func build() -> TagComponentUIViewController {
        let viewModel = TagComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = TagComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension TagComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [TagIntent]) {
        let actionSheet = SparkActionSheet<TagIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentVariantActionSheet(_ variants: [TagVariant]) {
        let actionSheet = SparkActionSheet<TagVariant>.init(
            values: variants,
            texts: variants.map { $0.name }) { variant in
                self.viewModel.variant = variant
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentActionSheet(_ contents: [TagContent]) {
        let actionSheet = SparkActionSheet<TagContent>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.content = content
            }
        self.present(actionSheet, animated: true)
    }
}
