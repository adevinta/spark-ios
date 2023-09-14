//
//  CheckboxComponentUIViewController.swift
//  Spark
//
//  Created by alican.aycil on 14.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI
import UIKit

final class CheckboxComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: CheckboxComponentUIView
    let viewModel: CheckboxComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: CheckboxComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = CheckboxComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Checkbox"
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

        self.viewModel.showStateSheet.subscribe(in: &self.cancellables) { states in
            self.presentStateActionSheet(states)
        }

        self.viewModel.showAlignmentSheet.subscribe(in: &self.cancellables) { alignments in
            self.presentAlignmentActionSheet(alignments)
        }
    }
}

// MARK: - Builder
extension CheckboxComponentUIViewController {

    static func build() -> CheckboxComponentUIViewController {
        let viewModel = CheckboxComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = CheckboxComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension CheckboxComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [CheckboxIntent]) {
        let actionSheet = SparkActionSheet<CheckboxIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentStateActionSheet(_ states: [CheckboxState]) {
        let actionSheet = SparkActionSheet<CheckboxState>.init(
            values: states.map { $0 },
            texts: states.map { $0.name }) { state in
                self.viewModel.state = state
            }
        self.present(actionSheet, animated: true)
    }

    private func presentAlignmentActionSheet(_ alignments: [CheckboxAlignment]) {
        let actionSheet = SparkActionSheet<CheckboxAlignment>.init(
            values: alignments,
            texts: alignments.map { $0.name }) { alignment in
                self.viewModel.alignment = alignment
            }
        self.present(actionSheet, animated: true)
    }
}
