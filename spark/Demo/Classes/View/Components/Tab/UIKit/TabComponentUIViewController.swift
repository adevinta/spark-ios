//
//  TabComponentUIViewController.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 06.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon

final class TabComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: TabComponentUIView
    let viewModel: TabComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: TabComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = TabComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = self.viewModel.identifier
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

        self.viewModel.showThemeSheet.subscribe(in: &self.cancellables) { themes in
            self.presentThemeActionSheet(themes)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.cancellables) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { variants in
            self.presentSizeActionSheet(variants)
        }

    }
}

// MARK: - Builder
extension TabComponentUIViewController {

    static func build() -> TabComponentUIViewController {
        let viewModel = TabComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = TabComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension TabComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [TabIntent]) {
        let actionSheet = SparkActionSheet<TabIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentSizeActionSheet(_ variants: [TabSize]) {
        let actionSheet = SparkActionSheet<TabSize>.init(
            values: variants,
            texts: variants.map { $0.name }) { size in
                self.viewModel.size = size
            }
        self.present(actionSheet, isAnimated: true)
    }
}
