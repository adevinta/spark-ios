//
//  TextFieldAddonsComponentUIView.swift
//  SparkDemo
//
//  Created by louis.borlee on 14/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import UIKit
import SparkCore

// swiftlint:disable no_debugging_method
final class TextFieldAddonsComponentUIView: ComponentUIView {
    private let viewModel: TextFieldAddonsComponentUIViewModel
    private let textFieldAddons: TextFieldAddonsUIView
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: TextFieldAddonsComponentUIViewModel) {
        self.viewModel = viewModel
        self.textFieldAddons = .init(
            theme: viewModel.theme,
            intent: viewModel.intent,
            successImage: .init(named: "check") ?? UIImage(),
            alertImage: .init(named: "alert") ?? UIImage(),
            errorImage: .init(named: "alert-circle") ?? UIImage()
        )
        self.textFieldAddons.textField.leftViewMode = .always
        self.textFieldAddons.textField.rightViewMode = .always
        super.init(viewModel: viewModel, componentView: self.textFieldAddons)
        self.textFieldAddons.textField.placeholder = "Placeholder"
        self.setupSubscriptions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubscriptions() {
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.viewModel.configurationViewModel.update(theme: theme)
            self.textFieldAddons.textField.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.textFieldAddons.textField.intent = intent
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) { [weak self] isEnabled in
            guard let self = self else { return }
            self.viewModel.isEnabledConfigurationItemViewModel.isOn = isEnabled
            self.textFieldAddons.isEnabled = isEnabled
        }

        self.viewModel.$isUserInteractionEnabled.subscribe(in: &self.cancellables) { [weak self] isUserInteractionEnabled in
            guard let self = self else { return }
            self.viewModel.isUserInteractionEnabledConfigurationItemViewModel.isOn = isUserInteractionEnabled
            self.textFieldAddons.isUserInteractionEnabled = isUserInteractionEnabled
        }

        self.viewModel.$leftViewContent.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self else { return }
            self.viewModel.leftViewContentConfigurationItemViewModel.buttonTitle = content.name
            self.textFieldAddons.textField.leftView = self.getContentView(from: content, side: .left)
        }

        self.viewModel.$rightViewContent.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self else { return }
            self.viewModel.rightViewContentConfigurationItemViewModel.buttonTitle = content.name
            self.textFieldAddons.textField.rightView = self.getContentView(from: content, side: .right)
        }

        self.viewModel.$leftAddonContent.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self else { return }
            self.viewModel.leftAddonContentConfigurationItemViewModel.buttonTitle = content.name
            self.textFieldAddons.setLeftAddon(self.getAddonContentView(from: content, side: .left), withPadding: self.viewModel.addonPadding)
        }

        self.viewModel.$rightAddonContent.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self else { return }
            self.viewModel.rightAddonContentConfigurationItemViewModel.buttonTitle = content.name
            self.textFieldAddons.setRightAddon(self.getAddonContentView(from: content, side: .right), withPadding: self.viewModel.addonPadding)
        }

        self.viewModel.$addonPadding.subscribe(in: &self.cancellables) { [weak self] addonPadding in
            guard let self else { return }
            self.textFieldAddons.setLeftAddon(self.textFieldAddons.leftAddon, withPadding: addonPadding)
            self.textFieldAddons.setRightAddon(self.textFieldAddons.rightAddon, withPadding: addonPadding)
        }

        self.viewModel.refreshLayout.subscribe(in: &self.cancellables) { [weak self] in
            guard let self else { return }
            self.textFieldAddons.textField.invalidateIntrinsicContentSize()
            self.textFieldAddons.textField.setNeedsLayout()
            self.textFieldAddons.textField.layoutIfNeeded()
        }
    }

    private func getContentView(from content: TextFieldSideViewContent, side: TextFieldContentSide) -> UIView? {
        switch content {
        case .button:
            return self.createButton(side: side)
        case .image:
            return self.createImage(side: side)
        case .text:
            return self.createText(side: side)
        case .all:
            let stackView = UIStackView(arrangedSubviews: [
                self.createButton(side: side),
                self.createImage(side: side),
                self.createText(side: side)
            ])
            stackView.spacing = 4
            stackView.axis = .horizontal
            return stackView
        case .none: return nil
        }
    }

    private func getAddonContentView(from content: TextFieldAddonContent, side: TextFieldContentSide) -> UIView? {
        switch content {
        case .button:
            return self.createButton(side: side)
        case .icon:
            return self.createIcon(side: side)
        case .text:
            return self.createText(side: side)
        case .buttonFull:
            return self.createButtonFull(side: side)
        case .none: return nil
        }
    }

    private func createButton(side: TextFieldContentSide) -> ButtonUIView {
        let button = ButtonUIView(
            theme: self.viewModel.theme,
            intent: side == .right ? .info : .alert,
            variant: .tinted,
            size: .small,
            shape: .pill,
            alignment: .trailingImage)
        button.setImage(.init(systemName: side == .left ? "pencil" : "eraser.fill"), for: .normal)
        return button
    }

    private func createImage(side: TextFieldContentSide) -> UIImageView {
        let imageView = UIImageView(image: .init(systemName: side == .left ? "power" : "eject.circle.fill"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private func createIcon(side: TextFieldContentSide) -> IconUIView {
        let icon = IconUIView(
            iconImage: .init(systemName: side == .left ? "power" : "eject.circle.fill"),
            theme: self.viewModel.theme,
            intent: .support,
            size: .extraLarge
        )
        return icon
    }

    private func createText(side: TextFieldContentSide) -> UILabel {
        let label = UILabel()
        label.text = side.rawValue
        return label
    }

    private func createButtonFull(side: TextFieldContentSide) -> ButtonUIView {
        let button = ButtonUIView(
            theme: self.viewModel.theme,
            intent: side == .right ? .danger : .success,
            variant: .tinted,
            size: .large,
            shape: .square,
            alignment: .leadingImage)
        button.setTitle(side == .right ? "This is a very long text" : "Add", for: .normal)
        button.isAnimated = false
        return button
    }
}
