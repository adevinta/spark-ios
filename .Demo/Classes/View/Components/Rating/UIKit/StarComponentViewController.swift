//
//  StarComponentViewController.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import SwiftUI
import UIKit
import SparkCore
@_spi(SI_SPI) import SparkCommon

final class StarComponentViewController: UIViewController {

    // MARK: - Properties
    let componentView: StarComponentUIView
    let viewModel: StarComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: StarComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = StarComponentUIView(viewModel: viewModel)
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
        self.navigationItem.title = "Star (Not a component)"
        addPublisher()
    }

    // MARK: - Add Publishers
    private func addPublisher() {

        self.viewModel.showStarFillColorSheet.subscribe(in: &self.cancellables) { colors in
            self.presentFillColorActionSheet(colors)
        }

        self.viewModel.showStarStrokeColorSheet.subscribe(in: &self.cancellables) { colors in
            self.presentStrokeColorActionSheet(colors)
        }

        self.viewModel.showStarFillModeSheet.subscribe(in: &self.cancellables) { modes in
            self.presentFillModeActionSheet(modes)
        }
    }
}

// MARK: - Builder
extension StarComponentViewController {

    static func build() -> StarComponentViewController {
        let viewModel = StarComponentUIViewModel()
        return StarComponentViewController(viewModel: viewModel)
    }
}

// MARK: - Navigation
extension StarComponentViewController {

    private func presentFillColorActionSheet(_ colors: [StarColor]) {
        let actionSheet = SparkActionSheet<StarColor>.init(
            values: colors,
            texts: colors.map { $0.name }) { color in
                self.viewModel.fillColor = color
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentStrokeColorActionSheet(_ colors: [StarColor]) {
        let actionSheet = SparkActionSheet<StarColor>.init(
            values: colors,
            texts: colors.map { $0.name }) { color in
                self.viewModel.strokeColor = color
            }
        self.present(actionSheet, isAnimated: true)
    }

    private func presentFillModeActionSheet(_ fillModes: [StarFillMode]) {
        let actionSheet = SparkActionSheet<StarFillMode>.init(
            values: fillModes,
            texts: fillModes.map { $0.name }) { fillMode in
                self.viewModel.fillMode = fillMode
            }
        self.present(actionSheet, isAnimated: true)
    }

}
