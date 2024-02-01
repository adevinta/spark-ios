//
//  FormFieldComponentUIView.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Spark
import UIKit

final class FormFieldComponentUIView: ComponentUIView {

    // MARK: - Components
    private let componentView: FormFieldUIView

    // MARK: - Properties

    private let viewModel: FormFieldComponentUIViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(viewModel: FormFieldComponentUIViewModel) {
        self.viewModel = viewModel
        self.componentView = Self.makeFormField(viewModel)

        super.init(
            viewModel: viewModel,
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
        self.viewModel.$theme.subscribe(in: &self.cancellables) { [weak self] theme in
            guard let self = self else { return }
            let themes = self.viewModel.themes
            let themeTitle: String? = theme is SparkTheme ? themes.first?.title : themes.last?.title

            self.viewModel.themeConfigurationItemViewModel.buttonTitle = themeTitle
            self.componentView.theme = theme
        }

        self.viewModel.$intent.subscribe(in: &self.cancellables) { [weak self] intent in
            guard let self = self else { return }
            self.viewModel.intentConfigurationItemViewModel.buttonTitle = intent.name
            self.componentView.intent = intent
        }

        self.viewModel.$titleStyle.subscribe(in: &self.cancellables) { [weak self] textStyle in
            guard let self = self else { return }
            self.viewModel.titleStyleConfigurationItemViewModel.buttonTitle = textStyle.name
            switch textStyle {
            case .text:
                self.componentView.title = self.viewModel.text
            case .multilineText:
                self.componentView.title = self.viewModel.multilineText
            case .attributeText:
                self.componentView.attributedTitle = self.viewModel.attributeText
            case .none:
                self.componentView.title = nil
            }
        }

        self.viewModel.$descriptionStyle.subscribe(in: &self.cancellables) { [weak self] textStyle in
            guard let self = self else { return }
            self.viewModel.descriptionStyleConfigurationItemViewModel.buttonTitle = textStyle.name
            switch textStyle {
            case .text:
                self.componentView.descriptionString = self.viewModel.descriptionText
            case .multilineText:
                self.componentView.descriptionString = self.viewModel.multilineText
            case .attributeText:
                self.componentView.attributedDescription = self.viewModel.attributeText
            case .none:
                self.componentView.descriptionString = nil
            }
        }

        self.viewModel.$componentStyle.subscribe(in: &self.cancellables) { [weak self] componentStyle in
            guard let self = self else { return }
            self.viewModel.componentStyleConfigurationItemViewModel.buttonTitle = componentStyle.name

            let component: UIControl!

            switch componentStyle {
            case .basic:
                component = Self.makeBasicView()
            case .singleCheckbox:
                component = Self.makeSingleCheckbox()
            case .verticalCheckbox:
                component = Self.makeVerticalCheckbox()
            case .horizontalCheckbox:
                component = Self.makeHorizontalCheckbox()
            case .horizontalScrollableCheckbox:
                component = Self.makeHorizontalScrollableCheckbox()
            case .singleRadioButton:
                component = Self.makeSingleRadioButton()
            case .verticalRadioButton:
                component = Self.makeVerticalRadioButton()
            case .horizontalRadioButton:
                component = Self.makeHorizontalRadioButton()
            case .textField:
                component = Self.makeTextField()
            case .addOnTextField:
                component = Self.makeAddOnTextField()
            case .ratingInput:
                component = Self.makeRatingInput()
            }

            self.componentView.component = component
        }

        self.viewModel.$isEnabled.subscribe(in: &self.cancellables) {  [weak self] isEnabled in
            guard let self = self else { return }
            self.componentView.isEnabled = isEnabled
        }
    }

    // MARK: - Create View
    static func makeFormField(_ viewModel: FormFieldComponentUIViewModel) -> FormFieldUIView {
        let component: UIControl!

        switch viewModel.componentStyle {
        case .basic:
            component = Self.makeBasicView()
        case .singleCheckbox:
            component = Self.makeSingleCheckbox()
        case .verticalCheckbox:
            component = Self.makeVerticalCheckbox()
        case .horizontalCheckbox:
            component = Self.makeHorizontalCheckbox()
        case .horizontalScrollableCheckbox:
            component = Self.makeHorizontalScrollableCheckbox()
        case .singleRadioButton:
            component = Self.makeSingleRadioButton()
        case .verticalRadioButton:
            component = Self.makeVerticalRadioButton()
        case .horizontalRadioButton:
            component = Self.makeHorizontalRadioButton()
        case .textField:
            component = Self.makeTextField()
        case .addOnTextField:
            component = Self.makeAddOnTextField()
        case .ratingInput:
            component = Self.makeRatingInput()
        }

        return .init(
            theme: viewModel.theme,
            intent: .support,
            title: "Agreement",
            description: "Your agreement is important to us.",
            component: component
        )
    }

    static func makeBasicView() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.lightGray
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }

    static func makeSingleCheckbox() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.red
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return view
    }

    static func makeVerticalCheckbox() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.blue
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }

    static func makeHorizontalCheckbox() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.black
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return view
    }

    static func makeHorizontalScrollableCheckbox() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.brown
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 140).isActive = true
        return view
    }

    static func makeSingleRadioButton() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.systemPink
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return view
    }

    static func makeVerticalRadioButton() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.green
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return view
    }

    static func makeHorizontalRadioButton() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.cyan
        view.heightAnchor.constraint(equalToConstant: 110).isActive = true
        view.widthAnchor.constraint(equalToConstant: 310).isActive = true
        return view
    }

    static func makeTextField() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.orange
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }

    static func makeAddOnTextField() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.magenta
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }

    static func makeRatingInput() -> UIControl {
        let view = UIControl()
        view.backgroundColor = UIColor.purple
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }
}
