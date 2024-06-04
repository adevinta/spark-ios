//
//  SliderComponentUIControl.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import UIKit
@_spi(SI_SPI) import SparkCommon

// swiftlint:disable no_debugging_method
final class SliderComponentUIView: ComponentUIView {

    // MARK: - Properties
    private let numberFormatter = NumberFormatter()
    let slider: SliderUIControl<Float>
    private let viewModel: SliderComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: SliderComponentUIViewModel) {
        self.viewModel = viewModel
        self.slider = SliderUIControl<Float>(
            theme: self.viewModel.theme,
            shape: self.viewModel.shape,
            intent: self.viewModel.intent
        )
        super.init(viewModel: self.viewModel,
                   integrationStackViewAlignment: .fill,
                   componentView: self.slider)

        self.addPublishers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Publishers
    private func addPublishers() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

            self.slider.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.slider.intent = intent
        }

        self.viewModel.$shape.subscribe(in: &self.cancellables) { [weak self] shape in
            guard let self = self else { return }
            self.viewModel.shapeConfigurationItemViewModel.buttonTitle = shape.name
            self.slider.shape = shape
        }

        self.viewModel.$isContinuous.subscribe(in: &self.cancellables) { [weak self] isContinuous in
            guard let self = self else { return }
            self.viewModel.isContinuousConfigurationItemViewModel.isOn = isContinuous
            self.slider.isContinuous = isContinuous
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.viewModel.isEnabledConfigurationItemViewModel.isOn = isEnabled
            self.slider.isEnabled = isEnabled
        }

        self.viewModel.$value.subscribe(in: &self.cancellables) { [weak self] value in
            guard let self = self else { return }
            self.slider.setValue(value)
            self.viewModel.valueConfigurationItemViewModel.labelText = "\(self.slider.value)"
        }

        self.viewModel.$range.subscribe(in: &self.cancellables) { [weak self] range in
            guard let self = self else { return }
            self.slider.range = range
            self.viewModel.minConfigurationItemViewModel.labelText = "\(self.slider.range.lowerBound)"
            self.viewModel.maxConfigurationItemViewModel.labelText = "\(self.slider.range.upperBound)"
            self.viewModel.valueConfigurationItemViewModel.labelText = "\(self.slider.value)"
        }

        self.viewModel.$step.subscribe(in: &self.cancellables) { [weak self] step in
            guard let self = self else { return }
            self.slider.step = step == .zero ? nil : step
            self.viewModel.stepConfigurationItemViewModel.labelText = "\(self.slider.step ?? 0)"
        }

        self.slider.valuePublisher.subscribe(in: &self.cancellables) { [weak self] value in
            guard let self else { return }
            self.viewModel.valueConfigurationItemViewModel.labelText = "\(self.slider.value)"
        }

        self.slider.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            print("Slider.valuedChanged: \(self.slider.value)")
        }), for: .valueChanged)
    }
}
