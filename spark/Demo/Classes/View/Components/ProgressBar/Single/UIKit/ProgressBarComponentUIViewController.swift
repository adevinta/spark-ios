//
//  ProgressBarComponentUIViewController.swift
//  Spark
//
//  Created by robin.lemaire on 25/09/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI
import UIKit

final class ProgressBarComponentUIViewController: UIViewController {

    // MARK: - Published Properties

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties

    let componentView: ProgressBarComponentUIView
    let viewModel: ProgressBarComponentUIViewModel
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(viewModel: ProgressBarComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = ProgressBarComponentUIView(viewModel: viewModel)

        super.init(nibName: nil, bundle: nil)

        self.componentView.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = self.componentView
    }

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.viewModel.identifier
        self.addPublisher()
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
            .store(in: &self.subscriptions)

        self.viewModel.showThemeSheet.subscribe(in: &self.subscriptions) { intents in
            self.presentThemeActionSheet(intents)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.subscriptions) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showShapeSheet.subscribe(in: &self.subscriptions) { shapes in
            self.presentShapeActionSheet(shapes)
        }
    }
}

// MARK: - Builder
extension ProgressBarComponentUIViewController {

    static func build() -> ProgressBarComponentUIViewController {
        let viewModel = ProgressBarComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = ProgressBarComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension ProgressBarComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [ProgressBarIntent]) {
        let actionSheet = SparkActionSheet<ProgressBarIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentShapeActionSheet(_ shapes: [ProgressBarShape]) {
        let actionSheet = SparkActionSheet<ProgressBarShape>.init(
            values: shapes,
            texts: shapes.map { $0.name }) { shape in
                self.viewModel.shape = shape
            }
        self.present(actionSheet, isAnimated: true)
    }
}
