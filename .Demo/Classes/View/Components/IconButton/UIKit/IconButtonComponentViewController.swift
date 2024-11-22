//
//  IconButtonComponentViewController.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import SparkCore
@_spi(SI_SPI) import SparkCommon

final class IconButtonComponentViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties

    let buttonComponentView: IconButtonComponentUIView
    let viewModel: IconButtonComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer

    init(viewModel: IconButtonComponentUIViewModel) {
        self.viewModel = viewModel
        self.buttonComponentView = IconButtonComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Icon Button"
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

        self.viewModel.showVariantSheet.subscribe(in: &self.cancellables) { variants in
            self.presentVariantActionSheet(variants)
        }

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { sizes in
            self.presentSizeActionSheet(sizes)
        }

        self.viewModel.showShapeSheet.subscribe(in: &self.cancellables) { shapes in
            self.presentShapeActionSheet(shapes)
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

        self.viewModel.showControlType.subscribe(in: &self.cancellables) { types in
            self.presentControlTypeActionSheet(types)
        }
    }
}

// MARK: - Builder

extension IconButtonComponentViewController {

    static func build() -> IconButtonComponentViewController {
        let viewModel = IconButtonComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return IconButtonComponentViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation

extension IconButtonComponentViewController {

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

    private func presentContentHighlightedActionSheet(_ contents: [IconButtonContentDefault]) {
        let actionSheet = SparkActionSheet<IconButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentHighlighted = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentDisabledActionSheet(_ contents: [IconButtonContentDefault]) {
        let actionSheet = SparkActionSheet<IconButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentDisabled = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentSelectedActionSheet(_ contents: [IconButtonContentDefault]) {
        let actionSheet = SparkActionSheet<IconButtonContentDefault>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.contentSelected = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentControlTypeActionSheet(_ contents: [ButtonControlType]) {
        let actionSheet = SparkActionSheet<ButtonControlType>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.controlType = content
            }
        self.present(actionSheet, animated: true)
    }
}
