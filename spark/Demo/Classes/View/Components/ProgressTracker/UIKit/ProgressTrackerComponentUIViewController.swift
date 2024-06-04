//
//  ProgressTrackerComponentUIViewController.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 26.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//


import Combine
import Spark
import SwiftUI
import UIKit
@testable import Spark
@_spi(SI_SPI) import SparkCommon

final class ProgressTrackerComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: ProgressTrackerComponentUIView
    let viewModel: ProgressTrackerComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: ProgressTrackerComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = ProgressTrackerComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Progress Tracker"
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

        self.viewModel.showOrientationSheet.subscribe(in: &self.cancellables) { variants in
            self.presentOrientationActionSheet(variants)
        }

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { sizes in
            self.presentSizeActionSheet(sizes)
        }

        self.viewModel.showInteractionSheet.subscribe(in: &self.cancellables) { variants in
            self.presentInteractionActionSheet(variants)
        }

        self.viewModel.showVariantSheet.subscribe(in: &self.cancellables) { variant in
            self.presentVariantActionSheet(variant)
        }

        self.viewModel.showContentSheet.subscribe(in: &self.cancellables) { content in
            self.presentContentActionSheet(content)
        }
    }
}

// MARK: - Builder
extension ProgressTrackerComponentUIViewController {

    static func build() -> ProgressTrackerComponentUIViewController {
        let viewModel = ProgressTrackerComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = ProgressTrackerComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension ProgressTrackerComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [ProgressTrackerIntent]) {
        let actionSheet = SparkActionSheet<ProgressTrackerIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentOrientationActionSheet(_ variants: [ProgressTrackerOrientation]) {
        let actionSheet = SparkActionSheet<ProgressTrackerOrientation>.init(
            values: variants,
            texts: variants.map { $0.name }) { variant in
                self.viewModel.orientation = variant
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentSizeActionSheet(_ sizes: [ProgressTrackerSize]) {
        let actionSheet = SparkActionSheet<ProgressTrackerSize>.init(
            values: sizes,
            texts: sizes.map{ $0.name }) { size in
                self.viewModel.size = size
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentInteractionActionSheet(_ variants: [ProgressTrackerInteractionState]) {
        let actionSheet = SparkActionSheet<ProgressTrackerInteractionState>.init(
            values: variants,
            texts: variants.map{ $0.name }) { interaction in
                self.viewModel.interaction = interaction
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentVariantActionSheet(_ variants: [ProgressTrackerVariant]) {
        let actionSheet = SparkActionSheet<ProgressTrackerVariant>.init(
            values: variants,
            texts: variants.map{ $0.name }) { variant in
                self.viewModel.variant = variant
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentContentActionSheet(_ content: [ProgressTrackerComponentUIViewModel.ContentType]) {
        let actionSheet = SparkActionSheet<ProgressTrackerComponentUIViewModel.ContentType>.init(
            values: content,
            texts: content.map{ $0.name }) { content in
                self.viewModel.contentType = content
            }
            self.present(actionSheet, isAnimated: true)
    }
}
