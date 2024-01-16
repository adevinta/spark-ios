//
//  ChipComponentUIViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 24.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SwiftUI
import UIKit
import SparkCore

final class ChipComponentViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: ChipComponentUIView
    let viewModel: ChipComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: ChipComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = ChipComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Chip"
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

        self.viewModel.showVariantSheet.subscribe(in: &self.cancellables) { intents in
            self.presentVariantActionSheet(intents)
        }

        self.viewModel.showIconPosition.subscribe(in: &self.cancellables) { variants in
            self.presentIconAlignmentActionSheet(variants)
        }

        self.viewModel.showExtraComponent.subscribe(in: &self.cancellables) { variants in
            self.presentExtraComponentActionSheet(variants)
        }
    }
}

// MARK: - Builder
extension ChipComponentViewController {

    static func build() -> ChipComponentViewController {
        let viewModel = ChipComponentUIViewModel(theme: SparkThemePublisher.shared.theme, intent: .support, variant: .outlined)
        let viewController = ChipComponentViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension ChipComponentViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [ChipIntent]) {
        let actionSheet = SparkActionSheet<ChipIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentVariantActionSheet(_ variants: [ChipVariant]) {
        let actionSheet = SparkActionSheet<ChipVariant>.init(
            values: variants,
            texts: variants.map{ $0.name }) { variant in
                self.viewModel.variant = variant
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentIconAlignmentActionSheet(_ variants: [ChipComponentUIViewModel.IconPosition]) {
        let actionSheet = SparkActionSheet<ChipComponentUIViewModel.IconPosition>.init(
            values: variants,
            texts: variants.map{ $0.name }) { variant in
                self.viewModel.iconAlignmentDidUpdate(variant)
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentExtraComponentActionSheet(_ variants: [ChipComponentUIViewModel.ExtraComponent]) {
        let actionSheet = SparkActionSheet<ChipComponentUIViewModel.ExtraComponent>.init(
            values: variants,
            texts: variants.map{ $0.name }) { variant in
                self.viewModel.extraComponentDidUpdate(variant)
            }
            self.present(actionSheet, isAnimated: true)
    }
}
