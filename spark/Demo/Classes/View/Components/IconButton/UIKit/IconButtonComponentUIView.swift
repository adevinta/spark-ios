//
//  IconButtonComponentUIView.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore
import Spark

final class IconButtonComponentUIView: ComponentUIView {

    // MARK: - Components

    private let buttonView: IconButtonUIView

    // MARK: - Properties

    private let viewModel: IconButtonComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    private lazy var buttonAction: UIAction = .init { _ in
        self.showAlert(for: .action)
    }
    private var buttonControlCancellable: AnyCancellable?

    // MARK: - Initializer

    init(viewModel: IconButtonComponentUIViewModel) {
        self.viewModel = viewModel
        self.buttonView = .init(
            theme: viewModel.theme,
            intent: viewModel.intent,
            variant: viewModel.variant,
            size: viewModel.size,
            shape: viewModel.shape
        )

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
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)

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

        self.viewModel.$contentNormal.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentNormalConfigurationItemViewModel.buttonTitle = content.name
            self.showRightSpacing = content != .image
            self.setContent(content, for: .normal)
        }

        self.viewModel.$contentHighlighted.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentHighlightedConfigurationItemViewModel.buttonTitle = content.name
            self.setContent(content, for: .highlighted)
        }

        self.viewModel.$contentDisabled.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentDisabledConfigurationItemViewModel.buttonTitle = content.name
            self.setContent(content, for: .disabled)
        }

        self.viewModel.$contentSelected.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentSelectedConfigurationItemViewModel.buttonTitle = content.name
            self.setContent(content, for: .selected)
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.buttonView.isEnabled = isEnabled
        }

        self.viewModel.$isSelected.subscribe(in: &self.cancellables) { [weak self] isSelected in
            guard let self = self else { return }
            self.buttonView.isSelected = isSelected
        }

        self.viewModel.$isAnimated.subscribe(in: &self.cancellables) { [weak self] isAnimated in
            guard let self = self else { return }
            self.buttonView.isAnimated = isAnimated
        }

        self.viewModel.$controlType.subscribe(in: &self.cancellables) { [weak self] controlType in
            guard let self = self else { return }
            self.viewModel.controlTypeConfigurationItemViewModel.buttonTitle = controlType.name
            self.setControl(from: controlType)
        }
    }

    // MARK: - Setter

    private func setContent(_ content: IconButtonContentDefault, for state: ControlState) {
        switch content {
        case .image:
            self.buttonView.setImage(self.image(for: state), for: state)

        case .none:
            self.buttonView.setImage(nil, for: state)
        }
    }

    private func setControl(from controlType: ButtonControlType) {
        // Publisher ?
        if controlType == .publisher {
            self.buttonControlCancellable = self.buttonView.tapPublisher.sink { _ in
                self.showAlert(for: .publisher)
            }
        } else {
            self.buttonControlCancellable?.cancel()
            self.buttonControlCancellable = nil
        }

        // Action ?
        if controlType == .action {
            self.buttonView.addAction(self.buttonAction, for: .touchUpInside)
        } else {
            self.buttonView.removeAction(self.buttonAction, for: .touchUpInside)
        }

        // Target ?
        if controlType == .target {
            self.buttonView.addTarget(self, action: #selector(self.touchUpInsideTarget), for: .touchUpInside)
        } else {
            self.buttonView.removeTarget(self, action: #selector(self.touchUpInsideTarget), for: .touchUpInside)
        }
    }

    // MARK: - Getter

    private func image(for state: ControlState) -> UIImage? {
        switch state {
        case .normal: return UIImage(named: "arrow")
        case .highlighted: return UIImage(named: "close")
        case .disabled: return UIImage(named: "check")
        case .selected: return UIImage(named: "alert")
        @unknown default: return nil
        }
    }

    // MARK: - Action

    @objc func touchUpInsideTarget() {
        self.showAlert(for: .target)
    }

    // MARK: - Alert

    func showAlert(for controlType: ButtonControlType) {
        let alertController = UIAlertController(
            title: "Button tap from " + controlType.name,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Ok", style: .default))
        self.viewController?.present(alertController, animated: true)
    }
}
