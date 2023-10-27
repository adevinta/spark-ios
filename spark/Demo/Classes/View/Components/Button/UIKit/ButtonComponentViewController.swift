//
//  ButtonComponentViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SwiftUI
import UIKit
import SparkCore

final class ButtonComponentViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let buttonComponentView: ButtonComponentUIView
    let viewModel: ButtonComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: ButtonComponentUIViewModel) {
        self.viewModel = viewModel
        self.buttonComponentView = ButtonComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)

        self.buttonComponentView.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = buttonComponentView
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Button"
        addPublisher()
    }

    // MARK: - Add Publishers
    private func addPublisher() {

        themePublisher
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

        self.viewModel.showVariantSheet.subscribe(in: &self.cancellables) { variants in
            self.presentVariantActionSheet(variants)
        }

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { sizes in
            self.presentSizeActionSheet(sizes)
        }

        self.viewModel.showShapeSheet.subscribe(in: &self.cancellables) { shapes in
            self.presentShapeActionSheet(shapes)
        }

        self.viewModel.showAlignmentSheet.subscribe(in: &self.cancellables) { alignments in
            self.presentAlignmentActionSheet(alignments)
        }

        self.viewModel.showContentNormalSheet.subscribe(in: &self.cancellables) { contents in
            self.presentContentNormalActionSheet(contents)
        }

        self.viewModel.showContentHighlightedSheet.subscribe(in: &self.cancellables) { contents in
            self.presentContentHighlightedActionSheet(contents)
        }

        self.viewModel.showContentDisabledSheet.subscribe(in: &self.cancellables) { contents in
            self.presentContentDisabledActionSheet(contents)
        }

        self.viewModel.showContentSelectedSheet.subscribe(in: &self.cancellables) { contents in
            self.presentContentSelectedActionSheet(contents)
        }
    }
}

// MARK: - Builder
extension ButtonComponentViewController {

    static func build() -> ButtonComponentViewController {
        let viewModel = ButtonComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        let viewController = ButtonComponentViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - Navigation
extension ButtonComponentViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [ButtonIntent]) {
        let actionSheet = SparkActionSheet<ButtonIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentVariantActionSheet(_ variants: [ButtonVariant]) {
        let actionSheet = SparkActionSheet<ButtonVariant>.init(
            values: variants,
            texts: variants.map{ $0.name }) { variant in
                self.viewModel.variant = variant
            }
            self.present(actionSheet, animated: true)
    }

    private func presentSizeActionSheet(_ sizes: [ButtonSize]) {
        let actionSheet = SparkActionSheet<ButtonSize>.init(
            values: sizes,
            texts: sizes.map { $0.name }) { size in
                self.viewModel.size = size
            }
        self.present(actionSheet, animated: true)
    }

    private func presentShapeActionSheet(_ shapes: [ButtonShape]) {
        let actionSheet = SparkActionSheet<ButtonShape>.init(
            values: shapes,
            texts: shapes.map { $0.name }) { shape in
                self.viewModel.shape = shape
            }
        self.present(actionSheet, animated: true)
    }

    private func presentAlignmentActionSheet(_ alignments: [ButtonAlignment]) {
        let actionSheet = SparkActionSheet<ButtonAlignment>.init(
            values: alignments,
            texts: alignments.map { $0.name }) { alignment in
                self.viewModel.alignment = alignment
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentNormalActionSheet(_ contents: [ButtonContentDefault]) {
        let actionSheet = SparkActionSheet<ButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentNormal = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentHighlightedActionSheet(_ contents: [ButtonContentDefault]) {
        let actionSheet = SparkActionSheet<ButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentHighlighted = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentDisabledActionSheet(_ contents: [ButtonContentDefault]) {
        let actionSheet = SparkActionSheet<ButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentDisabled = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentSelectedActionSheet(_ contents: [ButtonContentDefault]) {
        let actionSheet = SparkActionSheet<ButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentSelected = content
            }
        self.present(actionSheet, animated: true)
    }
}
