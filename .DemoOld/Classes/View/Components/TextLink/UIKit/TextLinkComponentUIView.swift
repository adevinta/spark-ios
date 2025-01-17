//
//  TextLinkComponentUIView.swift
//  Spark
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import UIKit
@_spi(SI_SPI) import SparkCommon

final class TextLinkComponentUIView: ComponentUIView {

    // MARK: - Type Alias

    private typealias Constants = TextLinkConstants

    // MARK: - Components

    private var componentView: TextLinkUIView

    // MARK: - Properties

    private let viewModel: TextLinkComponentUIViewModel
    private var subcriptions: Set<AnyCancellable> = []

    private lazy var componentAction: UIAction = .init { _ in
        self.showAlert(for: .action)
    }

    private var controlSubcription: AnyCancellable?

    // MARK: - Initialization

    init(viewModel: TextLinkComponentUIViewModel) {
        self.viewModel = viewModel

        self.componentView = .init(
            theme: viewModel.theme,
            text: viewModel.content.containsText ? Constants.text : Constants.Long.text,
            intent: viewModel.intent,
            typography: viewModel.typography,
            variant: viewModel.variant,
            image: .init(resource: .info)
        )

        super.init(
            viewModel: viewModel,
            integrationStackViewAlignment: .fill,
            componentView: self.componentView
        )

        // Setup
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.subcriptions) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.subcriptions) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$variant.subscribe(in: &self.subcriptions) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.componentView.variant = variant
        }

        self.viewModel.$typography.subscribe(in: &self.subcriptions) { [weak self] typography in
            guard let self = self else { return }
            self.viewModel.typographyConfigurationItemViewModel.buttonTitle = typography.name
            self.componentView.typography = typography
        }

        self.viewModel.$content.subscribe(in: &self.subcriptions) { [weak self] content in
            guard let self = self else { return }
            self.viewModel.contentConfigurationItemViewModel.buttonTitle = content.name

            self.showRightSpacing = content.containsText ? true : false

            switch content {
            case .text:
                self.componentView.text = Constants.text
                self.componentView.textHighlightRange = nil
                self.componentView.image = nil

            case .paragraph:
                self.componentView.text = Constants.Long.text
                self.componentView.textHighlightRange = Constants.Long.textHighlightRange
                self.componentView.image = nil

            case .imageAndText:
                self.componentView.text = Constants.text
                self.componentView.textHighlightRange = nil
                self.componentView.image = .init(resource: .info)

            case .imageAndParagraph:
                self.componentView.text = Constants.Long.text
                self.componentView.textHighlightRange = Constants.Long.textHighlightRange
                self.componentView.image = .init(resource: .info)
            }
        }

        self.viewModel.$contentAlignment.subscribe(in: &self.subcriptions) { [weak self] contentAlignment in
            guard let self = self else { return }
            self.viewModel.contentAlignmentConfigurationItemViewModel.buttonTitle = contentAlignment.name
            self.componentView.alignment = contentAlignment
        }

        self.viewModel.$textAlignment.subscribe(in: &self.subcriptions) { [weak self] textAlignment in
            guard let self = self else { return }
            self.viewModel.textAlignmentConfigurationItemViewModel.buttonTitle = textAlignment.name
            self.componentView.textAlignment = textAlignment
        }

        self.viewModel.$lineBreakMode.subscribe(in: &self.subcriptions) { [weak self] lineBreakMode in
            guard let self = self else { return }
            self.viewModel.lineBreakModeConfigurationItemViewModel.buttonTitle = lineBreakMode.name
            self.componentView.lineBreakMode = lineBreakMode
        }

        self.viewModel.$isLineLimit.subscribe(in: &self.subcriptions) { [weak self] isLineLimit in
            guard let self = self else { return }
            self.componentView.numberOfLines = isLineLimit ? 2 : 0
        }

        self.viewModel.$controlType.subscribe(in: &self.subcriptions) { [weak self] controlType in
            guard let self = self else { return }
            self.viewModel.controlTypeConfigurationItemViewModel.buttonTitle = controlType.name
            self.setControl(from: controlType)
        }

        self.viewModel.$isCustomAccessibilityLabel.subscribe(in: &self.subcriptions) { [weak self] isCustomAccessibilityLabel in
            guard let self = self else { return }
            self.componentView.accessibilityLabel = isCustomAccessibilityLabel ? "My Textlink Label" : nil
        }
    }

    private func setControl(from controlType: TextLinkControlType) {
        // Publisher ?
        if controlType == .publisher {
            self.controlSubcription = self.componentView.tapPublisher.sink { _ in
                self.showAlert(for: .publisher)
            }
        } else {
            self.controlSubcription?.cancel()
            self.controlSubcription = nil
        }

        // Action ?
        if controlType == .action {
            self.componentView.addAction(self.componentAction, for: .touchUpInside)
        } else {
            self.componentView.removeAction(self.componentAction, for: .touchUpInside)
        }

        // Target ?
        if controlType == .target {
            self.componentView.addTarget(self, action: #selector(self.touchUpInsideTarget), for: .touchUpInside)
        } else {
            self.componentView.removeTarget(self, action: #selector(self.touchUpInsideTarget), for: .touchUpInside)
        }
    }

    // MARK: - Action

    @objc func touchUpInsideTarget() {
        self.showAlert(for: .target)
    }

    // MARK: - Alert

    func showAlert(for controlType: TextLinkControlType) {
        let alertController = UIAlertController(
            title: "TextLink tap from " + controlType.name,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Ok", style: .default))
        self.viewController?.present(alertController, animated: true)
    }
}
