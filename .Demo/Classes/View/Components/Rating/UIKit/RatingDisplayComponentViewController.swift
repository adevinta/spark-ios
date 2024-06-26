//
//  RatingDisplayComponentViewController.swift
//  SparkDemo
//
//  Created by Michael Zimmermann on 17.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import SparkCore
@_spi(SI_SPI) import SparkCommon

final class RatingDisplayComponentViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: RatingDisplayComponentUIView
    let viewModel: RatingDisplayComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: RatingDisplayComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = RatingDisplayComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Rating Display"
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

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { sizes in
            self.presentSizeActionSheet(sizes)
        }

        self.viewModel.showCountSheet.subscribe(in: &self.cancellables) { counts in
            self.presentCountActionSheet(counts)
        }
    }
}

// MARK: - Builder
extension RatingDisplayComponentViewController {

    static func build() -> RatingDisplayComponentViewController {
        let viewModel = RatingDisplayComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return RatingDisplayComponentViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension RatingDisplayComponentViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [RatingIntent]) {
        let actionSheet = SparkActionSheet<RatingIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentSizeActionSheet(_ sizes: [RatingDisplaySize]) {
        let actionSheet = SparkActionSheet<RatingDisplaySize>.init(
            values: sizes,
            texts: sizes.map{ $0.name }) { size in
                self.viewModel.size = size
            }
            self.present(actionSheet, isAnimated: true)
    }

    private func presentCountActionSheet(_ counts: [RatingStarsCount]) {
        let actionSheet = SparkActionSheet<RatingStarsCount>.init(
            values: counts,
            texts: counts.map{ $0.name }) { count in
                self.viewModel.count = count
            }
            self.present(actionSheet, isAnimated: true)
    }
}
