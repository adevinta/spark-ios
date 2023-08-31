//
//  ButtonComponentUIView.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class ButtonComponentUIView: ComponentUIView {

    // MARK: - Components

    private let buttonView: ButtonUIView

    private static func makeButtonView(_ viewModel: ButtonComponentUIViewModel) -> ButtonUIView {
        switch viewModel.content {
        case .icon:
            return .init(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                iconImage: viewModel.iconImage,
                isEnabled: viewModel.isEnabled
            )

        case .text:
            return .init(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                text: viewModel.text,
                isEnabled: viewModel.isEnabled
            )

        case .attributedText:
            return .init(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                attributedText: viewModel.attributedText,
                isEnabled: viewModel.isEnabled
            )

        case .iconAndText:
            return .init(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                iconImage: viewModel.iconImage,
                text: viewModel.text,
                isEnabled: viewModel.isEnabled
            )

        case .iconAndAttributedText:
            return .init(
                theme: viewModel.theme,
                intent: viewModel.intent,
                variant: viewModel.variant,
                size: viewModel.size,
                shape: viewModel.shape,
                alignment: viewModel.alignment,
                iconImage: viewModel.iconImage,
                attributedText: viewModel.attributedText,
                isEnabled: viewModel.isEnabled
            )
        }
    }

    // MARK: - Properties

    private let viewModel: ButtonComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer

    init(viewModel: ButtonComponentUIViewModel) {
        self.viewModel = viewModel
        self.buttonView = Self.makeButtonView(viewModel)

        super.init(
            viewModel: viewModel,
            componentView: self.buttonView
        )

        // Setup
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let color = self.viewModel.theme.colors.main.main.uiColor
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(color: color)

            self.buttonView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.buttonView.intent = intent
        }

        self.viewModel.$variant.subscribe(in: &self.cancellables) { [weak self] variant in
            guard let self = self else { return }
            self.viewModel.variantConfigurationItemViewModel.buttonTitle = variant.name
            self.buttonView.variant = variant
        }

        self.viewModel.$size.subscribe(in: &self.cancellables) { [weak self] size in
            guard let self = self else { return }
            self.viewModel.sizeConfigurationItemViewModel.buttonTitle = size.name
            self.buttonView.size = size
        }

        self.viewModel.$shape.subscribe(in: &self.cancellables) { [weak self] shape in
            guard let self = self else { return }
            self.viewModel.shapeConfigurationItemViewModel.buttonTitle = shape.name
            self.buttonView.shape = shape
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.buttonView.alignment = alignment
        }

        self.viewModel.$content.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentConfigurationItemViewModel.buttonTitle = content.name

            self.componentSpaceView.isHidden = content != .icon
            switch content {
            case .icon:
                self.buttonView.text = nil
                self.buttonView.attributedText = nil
                self.buttonView.iconImage = self.viewModel.iconImage

            case .text:
                self.buttonView.iconImage = nil
                self.buttonView.text = self.viewModel.text

            case .attributedText:
                self.buttonView.iconImage = nil
                self.buttonView.attributedText = self.viewModel.attributedText

            case .iconAndText:
                self.buttonView.iconImage = self.viewModel.iconImage
                self.buttonView.text = self.viewModel.text

            case .iconAndAttributedText:
                self.buttonView.iconImage = self.viewModel.iconImage
                self.buttonView.attributedText = self.viewModel.attributedText
            }
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.buttonView.isEnabled = isEnabled
        }
    }
}
