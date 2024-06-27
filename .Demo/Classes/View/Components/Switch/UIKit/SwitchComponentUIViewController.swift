//
//  SwitchComponentUIViewController.swift
//  Spark
//
//  Created by alican.aycil on 30.08.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon

final class SwitchComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: SwitchComponentUIView
    let viewModel: SwitchComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: SwitchComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = SwitchComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Switch"
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

        self.viewModel.showThemeSheet.subscribe(in: &self.cancellables) { theme in
            self.presentThemeActionSheet(theme)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.cancellables) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showAlignmentSheet.subscribe(in: &self.cancellables) { alignments in
            self.presentAlignmentActionSheet(alignments)
        }

        self.viewModel.showContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentContentActionSheet(contents)
        }
    }
}

// MARK: - Builder
extension SwitchComponentUIViewController {

    static func build() -> SwitchComponentUIViewController {
        let viewModel = SwitchComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return SwitchComponentUIViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension SwitchComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [SwitchIntent]) {
        let actionSheet = SparkActionSheet<SwitchIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentAlignmentActionSheet(_ alignments: [SwitchAlignment]) {
        let actionSheet = SparkActionSheet<SwitchAlignment>.init(
            values: alignments,
            texts: alignments.map { $0.name }) { alignment in
                self.viewModel.alignment = alignment
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentContentActionSheet(_ contents: [SwitchTextContentDefault]) {
        let actionSheet = SparkActionSheet<SwitchTextContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.textContent = content
            }
        self.present(actionSheet, isAnimated: true)
    }
}
