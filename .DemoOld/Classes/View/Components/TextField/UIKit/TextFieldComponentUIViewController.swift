//
//  TextFieldComponentUIViewController.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI
import SparkCore
@_spi(SI_SPI) import SparkCommon

final class TextFieldComponentUIViewController: UIViewController {

    // MARK: - Properties
    let componentView: TextFieldComponentUIView
    let viewModel: TextFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Initializer
    init(viewModel: TextFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = TextFieldComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.componentView.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        view = self.componentView
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "TextField "
        self.setupSubscriptions()
    }

    private func setupSubscriptions() {
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

        self.viewModel.showClearButtonModeSheet.subscribe(in: &self.cancellables) { viewModes in
            self.presentViewModeActionSheet(viewModes) { viewMode in
                self.viewModel.clearButtonMode = viewMode
            }
        }

        self.viewModel.showLeftViewModeSheet.subscribe(in: &self.cancellables) { viewModes in
            self.presentViewModeActionSheet(viewModes) { viewMode in
                self.viewModel.leftViewMode = viewMode
            }
        }

        self.viewModel.showRightViewModeSheet.subscribe(in: &self.cancellables) { viewModes in
            self.presentViewModeActionSheet(viewModes) { viewMode in
                self.viewModel.rightViewMode = viewMode
            }
        }

        self.viewModel.showLeftViewContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentSideViewContentActionSheet(contents) { content in
                self.viewModel.leftViewContent = content
            }
        }

        self.viewModel.showRightViewContentSheet.subscribe(in: &self.cancellables) { contents in
            self.presentSideViewContentActionSheet(contents) { content in
                self.viewModel.rightViewContent = content
            }
        }
    }

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

    private func presentViewModeActionSheet(_ viewModes: [UITextField.ViewMode], completion: @escaping (UITextField.ViewMode) -> Void) {
        let actionSheet = SparkActionSheet<UITextField.ViewMode>.init(
            values: viewModes,
            texts: viewModes.map { $0.description },
            completion: completion)
        self.present(actionSheet, isAnimated: true)
    }

    private func presentSideViewContentActionSheet(_ contents: [TextFieldSideViewContent], completion: @escaping (TextFieldSideViewContent) -> Void) {
        let actionSheet = SparkActionSheet<TextFieldSideViewContent>.init(
            values: contents,
            texts: contents.map { $0.name },
            completion: completion)
        self.present(actionSheet, isAnimated: true)
    }
}

extension TextFieldComponentUIViewController {
    static func build() -> TextFieldComponentUIViewController {
        let viewModel = TextFieldComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return TextFieldComponentUIViewController(viewModel: viewModel)
    }
}

extension UITextField.ViewMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .always: return "always"
        case .never: return "never"
        case .unlessEditing: return "unlessEditing"
        case .whileEditing: return "whileEditing"
        @unknown default:
            fatalError()
        }
    }
}
