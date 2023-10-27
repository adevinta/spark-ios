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
        return .init(
            theme: viewModel.theme,
            intent: viewModel.intent,
            variant: viewModel.variant,
            size: viewModel.size,
            shape: viewModel.shape,
            alignment: viewModel.alignment,
            isEnabled: viewModel.isEnabled
        )
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

        self.viewModel.$alignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.buttonView.alignment = alignment
        }

        self.viewModel.$contentNormal.subscribe(in: &self.cancellables) { [weak self] content in
            guard let self = self else { return }

            self.viewModel.contentNormalConfigurationItemViewModel.buttonTitle = content.name
            self.showRightSpacing = content != .icon
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
    }

    // MARK: - Setter

    private func setContent(_ content: ButtonContentDefault, for state: ControlState) {
        switch content {
        case .icon:
            self.buttonView.setTitle(nil, for: state)
            self.buttonView.setAttributedTitle(nil, for: state)
            self.buttonView.setImage(self.image(for: state), for: state)

        case .text:
            self.buttonView.setImage(nil, for: state)
            self.buttonView.setTitle(self.title(for: state), for: state)

        case .attributedText:
            self.buttonView.setImage(nil, for: state)
            self.buttonView.setAttributedTitle(self.attributedTitle(for: state), for: state)

        case .iconAndText:
            self.buttonView.setImage(self.image(for: state), for: state)
            self.buttonView.setTitle(self.title(for: state), for: state)

        case .iconAndAttributedText:
            self.buttonView.setImage(self.image(for: state), for: state)
            self.buttonView.setAttributedTitle(self.attributedTitle(for: state), for: state)
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

    private func title(for state: ControlState) -> String? {
        switch state {
        case .normal: return "My Title"
        case .highlighted: return "My Highlighted"
        case .disabled: return "My Disabled"
        case .selected: return "My Selected"
        @unknown default: return nil
        }
    }

    private func attributedTitle(for state: ControlState) -> NSAttributedString? {

        func attributedText(_ text: String) -> NSAttributedString {
            return .init(
                string: text,
                attributes: [
                    .foregroundColor: UIColor.purple,
                    .font: UIFont.italicSystemFont(ofSize: 20),
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
            )
        }

        switch state {
        case .normal: return attributedText("My A_Title")
        case .highlighted: return attributedText("My A_Highlighted")
        case .disabled: return attributedText("My A_Disabled")
        case .selected: return attributedText("My A_Selected")
        @unknown default: return nil
        }
    }
}
