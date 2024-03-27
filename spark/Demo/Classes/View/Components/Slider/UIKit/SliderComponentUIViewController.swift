//
//  SliderComponentUIViewController.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI
import UIKit

// swiftlint:disable no_debugging_method
final class SliderComponentUIViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let componentView: SliderComponentUIView
    let viewModel: SliderComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: SliderComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = SliderComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Slider"
        self.addPublisher()

        self.componentView.slider.addAction(UIAction(handler: { [weak self] _ in
            guard self != nil else { return }
        }), for: .valueChanged)
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

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { intents in
            self.presentShapeActionSheet(intents)
        }
    }
}

// MARK: - Builder
extension SliderComponentUIViewController {

    static func build() -> SliderComponentUIViewController {
        let viewModel = SliderComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = SliderComponentUIViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension SliderComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [SliderIntent]) {
        let actionSheet = SparkActionSheet<SliderIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentShapeActionSheet(_ sizes: [SliderShape]) {
        let actionSheet = SparkActionSheet<SliderShape>.init(
            values: sizes,
            texts: sizes.map { $0.name }) { shape in
                self.viewModel.shape = shape
            }
        self.present(actionSheet, animated: true)
    }
}
