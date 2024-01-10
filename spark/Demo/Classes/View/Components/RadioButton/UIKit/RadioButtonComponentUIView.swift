//
//  RadioButtonComponentUIView.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 23.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import SparkCore
import UIKit

final class RadioButtonComponentUIView: ComponentUIView {
    // MARK: - Components
    private let componentView: RadioButtonUIGroupView<Int>
    private let singleComponentView: RadioButtonUIView<Int>
    private let stackView: UIStackView

    // MARK: - Properties

    private let viewModel: RadioButtonComponentUIViewModel
    private var cancellables = Set<AnyCancellable>()
    private var singleRadioButtonValuePublished = false

    // MARK: - Initializer
    init(viewModel: RadioButtonComponentUIViewModel) {
        self.viewModel = viewModel
        let componentView = Self.makeRadioButtonView(viewModel)
        self.componentView = componentView
        let singleComponentView = Self.makeSingleRadioButtonView(viewModel)
        self.singleComponentView = singleComponentView

        let stackView = UIStackView(arrangedSubviews: [componentView, singleComponentView])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 20

        self.stackView = stackView

        super.init(
            viewModel: viewModel,
            componentView: stackView
        )

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

            self.componentView.theme = theme
            self.singleComponentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
            self.singleComponentView.intent = intent
        }

        self.viewModel.$labelAlignment.subscribe(in: &self.cancellables) { [weak self] alignment in
            guard let self = self else { return }
            self.viewModel.alignmentConfigurationItemViewModel.buttonTitle = alignment.name
            self.componentView.labelAlignment = alignment
            self.singleComponentView.labelAlignment = alignment
        }

        self.viewModel.$axis.subscribe(in: &self.cancellables) { [weak self] axis in
            guard let self = self else { return }
            self.componentView.groupLayout = axis
        }

        self.viewModel.$showLongLabel.subscribe(in: &self.cancellables) { [weak self] showLongLabel in
            guard let self = self else { return }

            let index = self.componentView.items.count > 1 ? 1 : 0

            self.componentView.setTitle(self.viewModel.label(at: index), forItemAt: index)

            if self.viewModel.showAttributedLabel {
                if showLongLabel {
                    self.componentView.setTitle(self.viewModel.longTitleAttributed(at: index), forItemAt: index)
                } else {
                    self.componentView.setTitle(self.viewModel.shortTitleAttributed(at: index), forItemAt: index)
                }
            } else {
                if showLongLabel {
                    self.componentView.setTitle(self.viewModel.longTitle(at: index), forItemAt: index)
                } else {
                    self.componentView.setTitle(self.viewModel.shortTitle(at: index), forItemAt: index)
                }
            }
        }

        self.viewModel.$showAttributedLabel.subscribe(in: &self.cancellables) { [weak self] showAttributedLabel in
            guard let self = self else { return }

            let index = self.componentView.items.count > 1 ? 1 : 0

            if showAttributedLabel {
                self.componentView.setTitle(self.viewModel.attributedLabel(at: index), forItemAt: index)
            } else {
                self.componentView.setTitle(self.viewModel.label(at: index), forItemAt: index)
            }
        }

        self.viewModel.$isDisabled.subscribe(in: &self.cancellables) { [weak self] disabled in
            self?.componentView.isEnabled = !disabled

            self?.singleComponentView.isEnabled = !disabled
        }

        self.viewModel.$isSelected.subscribe(in: &self.cancellables) { [weak self] selected in
            self?.singleComponentView.isSelected = selected
        }

        self.viewModel.$numberOfRadioButtons.subscribe(in: &self.cancellables) { [weak self] numberOfRadioButtons in
            guard let self = self else { return }

            if numberOfRadioButtons < self.componentView.numberOfItems {
                self.componentView.removeRadioButton(
                    at: self.componentView.numberOfItems - 1,
                    animated: true)
            } else {
                let index = numberOfRadioButtons - 1
                let content = self.viewModel.content[index]
                self.componentView.addRadioButton(content)
            }
        }

        self.componentView.publisher.subscribe(in: &self.cancellables) { value in
            Console.log("Group: published \(value)")
        }

        let groupValueChanged = UIAction { _ in
            Console.log("Group: value changed")
        }

        let groupTouchInsde = UIAction { _ in
            Console.log("Group: touched")
        }
        self.componentView.addAction(groupValueChanged, for: .valueChanged)
        self.componentView.addAction(groupTouchInsde, for: .touchUpInside)

        self.singleComponentView.publisher
            .subscribe(in: &self.cancellables) {
                [weak self] selected in
                guard let self = self else { return }
                self.singleRadioButtonValuePublished = selected
                Console.log("Single: published \(selected)")
            }

        let touchAction = UIAction { [weak self] action in
            guard let self = self else { return }
            Console.log("Single: touched")
            if !self.singleRadioButtonValuePublished {
                self.singleComponentView.isSelected = false
            }
            Console.log("[RadioButton] single touchUpInside")
            self.singleRadioButtonValuePublished = false
        }
        self.singleComponentView.addAction(touchAction, for: .touchUpInside)

        let valueChanged = UIAction { _ in
            Console.log("Single: value changed")
        }
        self.singleComponentView.addAction(valueChanged, for: .valueChanged)
    }

    @objc func buttonValueChanged(_ item: Any?) {
        if let item = item as? RadioButtonUIGroupView<Int> {
            Console.log("[RadioButton] valueChanged: \(item.selectedID ?? -1)")
        } else {
            Console.log("[RadioButton] ERROR non expected item!")
        }
    }

    // MARK: - Private construction helper
    static private func makeRadioButtonView(_ viewModel: RadioButtonComponentUIViewModel) -> RadioButtonUIGroupView<Int> {

        let component = RadioButtonUIGroupView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            selectedID: viewModel.selectedRadioButton,
            items: viewModel.content,
            labelAlignment: viewModel.labelAlignment,
            groupLayout: viewModel.axis
        )

        component.title = "Radio Button Group (UIKit)"
        component.supplementaryText = "Radio Button Group Supplementary Text"
        return component
    }

    static private func makeSingleRadioButtonView(_ viewModel: RadioButtonComponentUIViewModel) -> RadioButtonUIView<Int> {
        return RadioButtonUIView(
            theme: viewModel.theme,
            intent: viewModel.intent,
            id: 99,
            label: NSAttributedString(string: "Sample of toggle on radio button"),
            isSelected: false)
    }
}