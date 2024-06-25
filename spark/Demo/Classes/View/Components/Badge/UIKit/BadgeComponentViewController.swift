//
//  BadgeComponentViewController.swift
//  SparkDemo
//
//  Created by alican.aycil on 16.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SwiftUI
import UIKit
import SparkCore

final class BadgeComponentViewController: UIViewController {

    // MARK: - Published Properties
    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    // MARK: - Properties
    let badgeComponentView: BadgeComponentUIView
    let viewModel: BadgeComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: BadgeComponentUIViewModel) {
        self.viewModel = viewModel
        self.badgeComponentView = BadgeComponentUIView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = badgeComponentView
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Badge"
        addPublisher()
    }

    // MARK: - Add Publishers
    private func addPublisher() {

        themePublisher
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

        self.viewModel.showSizeSheet.subscribe(in: &self.cancellables) { sizes in
            self.presentSizeActionSheet(sizes)
        }

        self.viewModel.showFormatSheet.subscribe(in: &self.cancellables) { format in
            self.presentFormatActionSheet(format)
        }
    }
}

// MARK: - Builder
extension BadgeComponentViewController {

    static func build() -> BadgeComponentViewController {
        let viewModel = BadgeComponentUIViewModel(theme: SparkThemePublisher.shared.theme)
        return BadgeComponentViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension BadgeComponentViewController {

    private func presentThemeActionSheet(_ themes: [ThemeCellModel]) {
        let actionSheet = SparkActionSheet<Theme>.init(
            values: themes.map { $0.theme },
            texts: themes.map { $0.title }) { theme in
                self.themePublisher.theme = theme
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentIntentActionSheet(_ intents: [BadgeIntentType]) {
        let actionSheet = SparkActionSheet<BadgeIntentType>.init(
            values: intents,
            texts: intents.map { $0.name }) { intent in
                self.viewModel.intent = intent
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentSizeActionSheet(_ sizes: [BadgeSize]) {
        let actionSheet = SparkActionSheet<BadgeSize>.init(
            values: sizes,
            texts: sizes.map { $0.name }) { size in
                self.viewModel.size = size
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentFormatActionSheet(_ formats: [String]) {
        let actionSheet = SparkActionSheet<String>.init(
            values: formats,
            texts: formats) { format in
                self.viewModel.format = BadgeFormat.from(name: format)
            }
            self.present(actionSheet, isAnimated: true)
    }
}

private  extension BadgeFormat {
    static func from(name: String) -> BadgeFormat {
        switch name {
        case Names.custom: return .custom(formatter: BadgePreviewFormatter())
        case Names.overflowCounter: return .overflowCounter(maxValue: 99)
        default: return .default
        }
    }
 }
