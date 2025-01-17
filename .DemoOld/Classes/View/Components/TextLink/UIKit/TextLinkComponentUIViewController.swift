//
//  TextLinkComponentUIViewController.swift
//  Spark
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import SwiftUI
import UIKit
@_spi(SI_SPI) import SparkCommon

final class TextLinkComponentUIViewController: UIViewController {

    // MARK: - Published Properties

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties

    let componentView: TextLinkComponentUIView
    let viewModel: TextLinkComponentUIViewModel
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(viewModel: TextLinkComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = TextLinkComponentUIView(viewModel: viewModel)

        super.init(nibName: nil, bundle: nil)

        self.componentView.viewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = self.componentView
    }

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.viewModel.identifier
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
            .store(in: &self.subscriptions)

        self.viewModel.showThemeSheet.subscribe(in: &self.subscriptions) { intents in
            self.presentThemeActionSheet(intents)
        }

        self.viewModel.showIntentSheet.subscribe(in: &self.subscriptions) { intents in
            self.presentIntentActionSheet(intents)
        }

        self.viewModel.showVariantSheet.subscribe(in: &self.subscriptions) { variants in
            self.presentVariantActionSheet(variants)
        }

        self.viewModel.showTypographySheet.subscribe(in: &self.subscriptions) { typography in
            self.presentTypographyActionSheet(typography)
        }

        self.viewModel.showContentSheet.subscribe(in: &self.subscriptions) { content in
            self.presentContentActionSheet(content)
        }

        self.viewModel.showContentAlignmentSheet.subscribe(in: &self.subscriptions) { contentAlignment in
            self.presentContentAlignmentActionSheet(contentAlignment)
        }

        self.viewModel.showTextAlignmentSheet.subscribe(in: &self.subscriptions) { textAlignment in
            self.presentTextAlignmentActionSheet(textAlignment)
        }

        self.viewModel.showLineBreakModeSheet.subscribe(in: &self.subscriptions) { lineBreakMode in
            self.presentLineBreakModeActionSheet(lineBreakMode)
        }

        self.viewModel.showControlType.subscribe(in: &self.subscriptions) { types in
            self.presentControlTypeActionSheet(types)
        }
    }
}

// MARK: - Builder
extension TextLinkComponentUIViewController {

    static func build() -> TextLinkComponentUIViewController {
        let viewModel = TextLinkComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return TextLinkComponentUIViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension TextLinkComponentUIViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, animated: true)
    }

    private func presentIntentActionSheet(_ intents: [TextLinkIntent]) {
        let actionSheet = SparkActionSheet<TextLinkIntent>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, animated: true)
    }

    private func presentVariantActionSheet(_ variants: [TextLinkVariant]) {
        let actionSheet = SparkActionSheet<TextLinkVariant>.init(
            values: variants,
            texts: variants.map { $0.name }) { variant in
                self.viewModel.variant = variant
            }
        self.present(actionSheet, animated: true)
    }

    private func presentTypographyActionSheet(_ typographys: [TextLinkTypography]) {
        let actionSheet = SparkActionSheet<TextLinkTypography>.init(
            values: typographys,
            texts: typographys.map { $0.name }) { typography in
                self.viewModel.typography = typography
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentActionSheet(_ contents: [TextLinkContent]) {
        let actionSheet = SparkActionSheet<TextLinkContent>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.content = content
            }
        self.present(actionSheet, animated: true)
    }

    private func presentContentAlignmentActionSheet(_ contentAlignments: [TextLinkAlignment]) {
        let actionSheet = SparkActionSheet<TextLinkAlignment>.init(
            values: contentAlignments,
            texts: contentAlignments.map { $0.name }) { contentAlignment in
                self.viewModel.contentAlignment = contentAlignment
            }
        self.present(actionSheet, animated: true)
    }

    private func presentTextAlignmentActionSheet(_ textAlignments: [NSTextAlignment]) {
        let actionSheet = SparkActionSheet<NSTextAlignment>.init(
            values: textAlignments,
            texts: textAlignments.map { $0.name }) { textAlignment in
                self.viewModel.textAlignment = textAlignment
            }
        self.present(actionSheet, animated: true)
    }

    private func presentLineBreakModeActionSheet(_ lineBreakModes: [NSLineBreakMode]) {
        let actionSheet = SparkActionSheet<NSLineBreakMode>.init(
            values: lineBreakModes,
            texts: lineBreakModes.map { $0.name }) { lineBreakMode in
                self.viewModel.lineBreakMode = lineBreakMode
            }
        self.present(actionSheet, animated: true)
    }

    private func presentControlTypeActionSheet(_ contents: [TextLinkControlType]) {
        let actionSheet = SparkActionSheet<TextLinkControlType>.init(
            values: contents,
            texts: contents.map { $0.name }) { content in
                self.viewModel.controlType = content
            }
        self.present(actionSheet, animated: true)
    }
}
