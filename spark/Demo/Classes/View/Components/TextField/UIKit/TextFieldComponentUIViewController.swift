//
//  TextFieldComponentUIViewController.swift
//  SparkCore
//
//  Created by louis.borlee on 11/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SwiftUI
import UIKit
import SparkCore

class TextFieldComponentUIViewController: UIViewController {

    let textFieldComponentUIView: TextFieldComponentUIView
    let viewModel: TextFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Initializer
    init(viewModel: TextFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.textFieldComponentUIView = TextFieldComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
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

        self.viewModel.showRightViewModeSheet.subscribe(in: &self.cancellables) { viewMode in
            self.presentRightViewModeActionSheet(viewMode)
        }

        self.viewModel.showLeftViewModeSheet.subscribe(in: &self.cancellables) { viewMode in
            self.presentLeftViewModeActionSheet(viewMode)
        }

        self.viewModel.showLeadingAddOnSheet.subscribe(in: &self.cancellables) { addOnOption in
            self.presentLeadingAddOnOptionSheet(addOnOption)
        }

        self.viewModel.showTrailingAddOnSheet.subscribe(in: &self.cancellables) { addOnOption in
            self.presentTrailingAddOnOptionSheet(addOnOption)
        }

        self.viewModel.showClearButtonModeSheet.subscribe(in: &self.cancellables) { viewMode in
            self.presentClearButtonModeActionSheet(viewMode)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "TextField"
        self.addPublisher()
    }

    private func setupView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        textFieldComponentUIView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textFieldComponentUIView)
        NSLayoutConstraint.activate([
            textFieldComponentUIView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textFieldComponentUIView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            textFieldComponentUIView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textFieldComponentUIView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textFieldComponentUIView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            textFieldComponentUIView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 1000)
        ])
    }

}

extension TextFieldComponentUIViewController {

    static func build() -> TextFieldComponentUIViewController {
        let viewModel = TextFieldComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = TextFieldComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension TextFieldComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [TextFieldIntent]) {
        let actionSheet = SparkActionSheet<TextFieldIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentLeftViewModeActionSheet(_ viewModes: [ViewMode]) {
        let actionSheet = SparkActionSheet<ViewMode>.init(values: viewModes,
                                                          texts: viewModes.map{ $0.name }) { viewMode in
            self.viewModel.leftViewMode = viewMode
        }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentRightViewModeActionSheet(_ viewModes: [ViewMode]) {
        let actionSheet = SparkActionSheet<ViewMode>.init(values: viewModes,
                                                          texts: viewModes.map{ $0.name }) { viewMode in
            self.viewModel.rightViewMode = viewMode
        }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentLeadingAddOnOptionSheet(_ addOnOptions: [AddOnOption]) {
        let actionSheet = SparkActionSheet<AddOnOption>.init(
            values: addOnOptions,
            texts: addOnOptions.map { $0.name }) { addOnOption in
                self.viewModel.leadingAddOnOption = addOnOption
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentTrailingAddOnOptionSheet(_ addOnOptions: [AddOnOption]) {
        let actionSheet = SparkActionSheet<AddOnOption>.init(
            values: addOnOptions,
            texts: addOnOptions.map { $0.name }) { addOnOption in
                self.viewModel.trailingAddOnOption = addOnOption
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentClearButtonModeActionSheet(_ viewModes: [ViewMode]) {
        let actionSheet = SparkActionSheet<ViewMode>.init(values: viewModes,
                                                          texts: viewModes.map{ $0.name }) { viewMode in
            self.viewModel.clearButtonMode = viewMode
        }
        self.present(actionSheet, isAnimated: true)
    }

}
