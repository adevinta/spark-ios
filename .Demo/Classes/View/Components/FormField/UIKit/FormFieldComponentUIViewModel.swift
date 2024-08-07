//
//  FormFieldComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import SparkCore
import UIKit

final class FormFieldComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showFeedbackStateSheet: AnyPublisher<[FormFieldFeedbackState], Never> {
        showFeedbackStateSheetSubject
            .eraseToAnyPublisher()
    }

    var showTitleSheet: AnyPublisher<[FormFieldTextStyle], Never> {
        showTitleStyleSheetSubject
            .eraseToAnyPublisher()
    }

    var showDescriptionSheet: AnyPublisher<[FormFieldTextStyle], Never> {
        showDescriptionStyleSheetSubject
            .eraseToAnyPublisher()
    }

    var showComponentSheet: AnyPublisher<[FormFieldComponentStyle], Never> {
        showComponentStyleSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showFeedbackStateSheetSubject: PassthroughSubject<[FormFieldFeedbackState], Never> = .init()
    private var showTitleStyleSheetSubject: PassthroughSubject<[FormFieldTextStyle], Never> = .init()
    private var showDescriptionStyleSheetSubject: PassthroughSubject<[FormFieldTextStyle], Never> = .init()
    private var showComponentStyleSheetSubject: PassthroughSubject<[FormFieldComponentStyle], Never> = .init()

    // MARK: - Items Properties
    lazy var themeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Theme",
            type: .button,
            target: (source: self, action: #selector(self.presentThemeSheet))
        )
    }()

    lazy var feedbackStateConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Feedback State",
            type: .button,
            target: (source: self, action: #selector(self.presentIntentSheet))
        )
    }()

    lazy var titleStyleConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Title Style",
            type: .button,
            target: (source: self, action: #selector(self.presentTextStyleSheet))
        )
    }()

    lazy var descriptionStyleConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Description Style",
            type: .button,
            target: (source: self, action: #selector(self.presentDescriptionStyleSheet))
        )
    }()

    lazy var componentStyleConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Component Style",
            type: .button,
            target: (source: self, action: #selector(self.presentComponentStyleSheet))
        )
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Enable",
            type: .checkbox(title: "", isOn: self.isEnabled),
            target: (source: self, action: #selector(self.enabledChanged(_:))))
    }()

    lazy var isRequiredConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Title Required",
            type: .checkbox(title: "", isOn: self.isTitleRequired),
            target: (source: self, action: #selector(self.isRequiredChanged(_:))))
    }()

    lazy var alignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Change component alignment",
            type: .checkbox(title: "", isOn: self.isTrailingAlignment),
            target: (source: self, action: #selector(self.isAlignmentChanged(_:))))
    }()

    lazy var containerViewAlignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Fill screen for right alinment",
            type: .checkbox(title: "", isOn: self.containerViewAlignment),
            target: (source: self, action: #selector(self.isContainerViewAlignmentChanged))
        )
    }()

    // MARK: - Default Properties
    var themes = ThemeCellModel.themes
    let text: String = "Agreement"
    let descriptionText = "Your agreement is important to us."
    let multilineText: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var attributeText: NSAttributedString {
        let attributeString = NSMutableAttributedString(
            string: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            attributes: [.font: UIFont.italicSystemFont(ofSize: 18)]
        )
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .font: UIFont(
                descriptor: UIFontDescriptor().withSymbolicTraits([.traitBold, .traitItalic]) ?? UIFontDescriptor(),
                size: 18
            ),
            .foregroundColor: UIColor.red
        ]
        attributeString.setAttributes(attributes, range: NSRange(location: 0, length: 11))
        return attributeString
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var feedbackState: FormFieldFeedbackState
    @Published var titleStyle: FormFieldTextStyle
    @Published var descriptionStyle: FormFieldTextStyle
    @Published var componentStyle: FormFieldComponentStyle
    @Published var isEnabled: Bool
    @Published var isTitleRequired: Bool
    @Published var isTrailingAlignment: Bool
    @Published var containerViewAlignment: Bool

    init(
        theme: Theme,
        feedbackState: FormFieldFeedbackState = .default,
        titleStyle: FormFieldTextStyle = .text,
        descriptionStyle: FormFieldTextStyle = .text,
        componentStyle: FormFieldComponentStyle = .singleCheckbox,
        isEnabled: Bool = true,
        isTitleRequired: Bool = false,
        isTrailingAlignment: Bool = false,
        containerViewAlignment: Bool = false
    ) {
        self.theme = theme
        self.feedbackState = feedbackState
        self.titleStyle = titleStyle
        self.descriptionStyle = descriptionStyle
        self.componentStyle = componentStyle
        self.isEnabled = isEnabled
        self.isTitleRequired = isTitleRequired
        self.isTrailingAlignment = isTrailingAlignment
        self.containerViewAlignment = containerViewAlignment
        super.init(identifier: "FormField")

        self.configurationViewModel = .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.feedbackStateConfigurationItemViewModel,
            self.titleStyleConfigurationItemViewModel,
            self.descriptionStyleConfigurationItemViewModel,
            self.componentStyleConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.isRequiredConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.containerViewAlignmentConfigurationItemViewModel
        ])
    }
}

// MARK: - Navigation
extension FormFieldComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showFeedbackStateSheetSubject.send(FormFieldFeedbackState.allCases)
    }

    @objc func presentTextStyleSheet() {
        self.showTitleStyleSheetSubject.send(FormFieldTextStyle.allCases)
    }

    @objc func presentDescriptionStyleSheet() {
        self.showDescriptionStyleSheetSubject.send(FormFieldTextStyle.allCases)
    }

    @objc func presentComponentStyleSheet() {
        self.showComponentStyleSheetSubject.send(FormFieldComponentStyle.allCases)
    }

    @objc func enabledChanged(_ isSelected: Any?) {
        self.isEnabled = isTrue(isSelected)
    }

    @objc func isRequiredChanged(_ isSelected: Any?) {
        self.isTitleRequired = isTrue(isSelected)
    }

    @objc func isAlignmentChanged(_ isSelected: Any?) {
        self.isTrailingAlignment = isTrue(isSelected)
    }

    @objc func isContainerViewAlignmentChanged(_ isSelected: Any?) {
        self.containerViewAlignment = isTrue(isSelected)
    }
}

// MARK: - Enum
enum FormFieldTextStyle: CaseIterable {
    case text
    case multilineText
    case attributeText
    case none
}

enum FormFieldComponentStyle: CaseIterable {
    case basic
    case singleCheckbox
    case verticalCheckbox
    case horizontalCheckbox
    case horizontalScrollableCheckbox
    case singleRadioButton
    case verticalRadioButton
    case horizontalRadioButton
    case textField
    case addOnTextField
    case ratingInput
}
