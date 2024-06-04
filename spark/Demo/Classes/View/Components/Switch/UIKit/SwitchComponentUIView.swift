//
//  SwitchComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 30.08.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import UIKit
@_spi(SI_SPI) import SparkCommon

final class SwitchComponentUIView: ComponentUIView {

    // MARK: - Components
    private var componentView: SwitchUIView

    // MARK: - Properties

    private let viewModel: SwitchComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: SwitchComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeSwitchView(viewModel)
        super.init(
            viewModel: viewModel,
            componentView: self.componentView
        )

        // Setup
        self.setupSubscriptions()

        // Delegate
        self.componentView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subscribe
    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.componentView.alignment = alignment
        }

        self.viewModel.$textContent.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentConfigurationItemViewModel.buttonTitle = content.name

            switch content {
            case .text:
                self.componentView.text = self.viewModel.text

            case .attributedText:
                self.componentView.attributedText = self.viewModel.attributedText

            case .multilineText:
                self.componentView.text = self.viewModel.multilineText

            case .none:
                self.componentView.text = nil
                self.componentView.attributedText = nil
            }
        }

        self.viewModel.$isOn.subscribe(in: &self.cancellables) { [weak self] isOn in
            guard let self = self else { return }

            if self.viewModel.isOnAnimated {
                self.componentView.setOn(isOn, animated: true)
            } else {
                self.componentView.isOn = isOn
            }
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }

            if self.viewModel.isEnabledAnimated {
                self.componentView.setEnabled(isEnabled, animated: true)
            } else {
                self.componentView.isEnabled = isEnabled
            }
        }

        self.viewModel.$hasImages.subscribe(in: &self.cancellables) { [weak self] hasImages in
            guard let self = self else { return }
            self.componentView.images = hasImages ? self.viewModel.images : nil
        }

        self.componentView.isOnChangedPublisher.subscribe(in: &self.cancellables) { [weak self] isOn in
            guard let self = self else { return }
            self.viewModel.isOnConfigurationItemViewModel.isOn = isOn
        }
    }
}

private extension SwitchComponentUIView {

    static func makeSwitchView(_ viewModel: SwitchComponentUIViewModel) -> SwitchUIView {
        var switchView: SwitchUIView!
        let content = viewModel.textContent
        let hasImages = viewModel.hasImages

        if content == .text && hasImages {
            switchView = SwitchUIView(
                theme: viewModel.theme,
                isOn: viewModel.isOn,
                alignment: viewModel.alignment,
                intent: viewModel.intent,
                isEnabled: viewModel.isEnabled,
                images: viewModel.images,
                text: viewModel.text
            )
        } else if content == .text && !hasImages {
            switchView = SwitchUIView(
                theme: viewModel.theme,
                isOn: viewModel.isOn,
                alignment: viewModel.alignment,
                intent: viewModel.intent,
                isEnabled: viewModel.isEnabled,
                text: viewModel.text
            )
        } else if content == .attributedText && hasImages {
            switchView = SwitchUIView(
                theme: viewModel.theme,
                isOn: viewModel.isOn,
                alignment: viewModel.alignment,
                intent: viewModel.intent,
                isEnabled: viewModel.isEnabled,
                images: viewModel.images,
                attributedText: viewModel.attributedText
            )
        } else if content == .attributedText && !hasImages {
            switchView = SwitchUIView(
                theme: viewModel.theme,
                isOn: viewModel.isOn,
                alignment: viewModel.alignment,
                intent: viewModel.intent,
                isEnabled: viewModel.isEnabled,
                attributedText: viewModel.attributedText
            )
        } else if content == .multilineText && hasImages {
            switchView = SwitchUIView(
                theme: viewModel.theme,
                isOn: viewModel.isOn,
                alignment: viewModel.alignment,
                intent: viewModel.intent,
                isEnabled: viewModel.isEnabled,
                images: viewModel.images,
                text: viewModel.multilineText
            )
        } else if content == .multilineText && !hasImages {
            switchView = SwitchUIView(
                theme: viewModel.theme,
                isOn: viewModel.isOn,
                alignment: viewModel.alignment,
                intent: viewModel.intent,
                isEnabled: viewModel.isEnabled,
                text: viewModel.multilineText
            )
        }
        return switchView
    }
}

extension SwitchComponentUIView: SwitchUIViewDelegate {

    func switchDidChange(_ switchView: SparkCore.SwitchUIView, isOn: Bool) {
        self.viewModel.isOn = isOn
    }
}
