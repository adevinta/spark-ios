//
//  CheckboxGroupComponentUIViewController.swift
//  Spark
//
//  Created by alican.aycil on 16.10.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI
import UIKit

final class CheckboxGroupComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: CheckboxGroupComponentUIView
    let viewModel: CheckboxGroupComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: CheckboxGroupComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = CheckboxGroupComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "CheckboxGroup"
        addPublisher()
    }

    // MARK: - Add Publishers
    private func addPublisher() {

        self.themePublisher
            .$theme
            .sink(receiveValue: { [weak self] theme in
                guard let self = self else { return }
                self.viewModel.theme = theme
                self.navigationController?.navigationBar.tintColor = theme.colors.main.main.uiColor
            })
            .store(in: &self.cancellables)

        self.viewModel.showThemeSheet.subscribe(in: &self.cancellables) { intents in
            self.presentThemeActionSheet(intents)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.cancellables) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showImageSheet.subscribe(in: &self.cancellables) { icons in
            self.presentIconActionSheet(icons)
        }

        self.viewModel.showGroupTypeSheet.subscribe(in: &self.cancellables) { types in
            self.presentGroupTypeActionSheet(types)
        }
    }
}

// MARK: - Builder
extension CheckboxGroupComponentUIViewController {

    static func build() -> CheckboxGroupComponentUIViewController {
        let viewModel = CheckboxGroupComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return CheckboxGroupComponentUIViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension CheckboxGroupComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [CheckboxIntent]) {
        let actionSheet = SparkActionSheet<CheckboxIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIconActionSheet(_ icons: [String: UIImage]) {
        let actionSheet = SparkActionSheet<String>.init(
            values: icons.map { $0.0 },
            texts: icons.map { $0.0 }) { iconKey in
                self.viewModel.icon = icons.filter { $0.0 == iconKey }
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentGroupTypeActionSheet(_ types: [CheckboxGroupType]) {
        let actionSheet = SparkActionSheet<CheckboxGroupType>.init(
            values: types,
            texts: types.map { $0.name }) { type in
                self.viewModel.groupType = type
            }
        self.present(actionSheet, isAnimated: true)
    }
}
