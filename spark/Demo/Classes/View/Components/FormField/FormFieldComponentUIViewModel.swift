//
//  FormFieldComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 30.01.24.
//  Copyright (c) 2024 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class FormFieldComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[FormFieldIntent], Never> {
        showIntentSheetSubject
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
    private var showIntentSheetSubject: PassthroughSubject<[FormFieldIntent], Never> = .init()
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

    lazy var intentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Intent",
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
    var textWithOpacity: NSAttributedString {
        let attributeString = NSMutableAttributedString(
            string: "Your agreement is important to us.",
            attributes: [
                .font: self.theme.typography.caption.uiFont,
                .foregroundColor: self.theme.colors.base.onSurface.opacity(self.theme.dims.dim1).uiColor
            ]
        )
        return attributeString
    }
    var textWithAsterix: NSAttributedString {
        let attributeString = NSMutableAttributedString(
            string: "Label *",
            attributes: [.font: self.theme.typography.body2.uiFont]
        )
        let attributes: [NSMutableAttributedString.Key: Any] = [
            .font: self.theme.typography.caption.uiFont,
            .foregroundColor: self.theme.colors.base.onSurface.opacity(self.theme.dims.dim3).uiColor
        ]
        attributeString.setAttributes(attributes, range: NSRange(location: 6, length: 1))
        return attributeString
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: FormFieldIntent
    @Published var titleStyle: FormFieldTextStyle
    @Published var descriptionStyle: FormFieldTextStyle
    @Published var componentStyle: FormFieldComponentStyle
    @Published var isEnabled: Bool

    init(
        theme: Theme,
        intent: FormFieldIntent = .support,
        titleStyle: FormFieldTextStyle = .text,
        descriptionStyle: FormFieldTextStyle = .text,
        componentStyle: FormFieldComponentStyle = .singleCheckbox,
        isEnabled: Bool = true
    ) {
        self.theme = theme
        self.intent = intent
        self.titleStyle = titleStyle
        self.descriptionStyle = descriptionStyle
        self.componentStyle = componentStyle
        self.isEnabled = isEnabled
        super.init(identifier: "FormField")

        self.configurationViewModel = .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.titleStyleConfigurationItemViewModel,
            self.descriptionStyleConfigurationItemViewModel,
            self.componentStyleConfigurationItemViewModel,
            self.disableConfigurationItemViewModel
        ])
    }
}

// MARK: - Navigation
extension FormFieldComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(FormFieldIntent.allCases)
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
}

// MARK: - Enum
enum FormFieldTextStyle: CaseIterable {
    case text
    case asterixText
    case opacityText
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
