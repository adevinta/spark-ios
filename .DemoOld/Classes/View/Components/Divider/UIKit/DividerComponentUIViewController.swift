//
//  DividerComponentUIViewController.swift
//  SparkDemo
//
//  Created by louis.borlee on 31/07/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon

final class DividerComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: DividerComponentUIView
    let viewModel: DividerComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: DividerComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = DividerComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Divider"
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
            .store(in: &self.cancellables)

        self.viewModel.showThemeSheet.subscribe(in: &self.cancellables) { intents in
            self.presentThemeActionSheet(intents)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.cancellables) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showAxisSheet.subscribe(in: &self.cancellables) { axis in
            self.presentAxisActionSheet(axis)
        }

        self.viewModel.showAlignmentSheet.subscribe(in: &self.cancellables) { alignments in
            self.presentAlignmentActionSheet(alignments)
        }
    }
}

// MARK: - Builder
extension DividerComponentUIViewController {

    static func build() -> DividerComponentUIViewController {
        let viewModel = DividerComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return DividerComponentUIViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension DividerComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [DividerIntent]) {
        let actionSheet = SparkActionSheet<DividerIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentAxisActionSheet(_ axis: [DividerAxis]) {
        let actionSheet = SparkActionSheet<DividerAxis>.init(
            values: axis,
            texts: axis.map { $0.name }) { axis in
                self.viewModel.axis = axis
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentAlignmentActionSheet(_ alignments: [DividerAlignment]) {
        let actionSheet = SparkActionSheet<DividerAlignment>.init(
            values: alignments,
            texts: alignments.map { $0.name }) { alignment in
                self.viewModel.alignment = alignment
            }
        self.present(actionSheet, isAnimated: true)
    }
}
