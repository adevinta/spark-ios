//
//  ProgressBarDoubleComponentUIViewController.swift
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

final class ProgressBarDoubleComponentUIViewController: UIViewController {

    // MARK: - Published Properties

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties

    let componentView: ProgressBarDoubleComponentUIView
    let viewModel: ProgressBarDoubleComponentUIViewModel
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(viewModel: ProgressBarDoubleComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = ProgressBarDoubleComponentUIView(viewModel: viewModel)

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
extension ProgressBarDoubleComponentUIViewController {

    static func build() -> ProgressBarDoubleComponentUIViewController {
        let viewModel = ProgressBarDoubleComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = ProgressBarDoubleComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension ProgressBarDoubleComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [ProgressBarDoubleIntent]) {
        let actionSheet = SparkActionSheet<ProgressBarDoubleIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentShapeActionSheet(_ shapes: [ProgressBarShape]) {
        let actionSheet = SparkActionSheet<ProgressBarShape>.init(
            values: shapes,
            texts: shapes.map { $0.name }) { shape in
                self.viewModel.shape = shape
            }
        self.present(actionSheet, animated: true)
    }
}
