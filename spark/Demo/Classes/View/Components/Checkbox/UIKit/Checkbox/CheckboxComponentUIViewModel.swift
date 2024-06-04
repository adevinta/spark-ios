//
//  CheckboxComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 14.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import Spark
import UIKit

final class CheckboxComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[CheckboxIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showAlignmentSheet: AnyPublisher<[CheckboxAlignment], Never> {
        showAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    var showTextSheet: AnyPublisher<[CheckboxTextStyle], Never> {
        showTextStyleSheetSubject
            .eraseToAnyPublisher()
    }

    var showImageSheet: AnyPublisher<[String: UIImage], Never> {
        showIconSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[CheckboxIntent], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[CheckboxAlignment], Never> = .init()
    private var showTextStyleSheetSubject: PassthroughSubject<[CheckboxTextStyle], Never> = .init()
    private var showIconSheetSubject: PassthroughSubject<[String: UIImage], Never> = .init()

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

    lazy var alignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Aligment",
            type: .button,
            target: (source: self, action: #selector(self.presentAlignmentSheet))
        )
    }()

    lazy var textStyleConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Text Style",
            type: .button,
            target: (source: self, action: #selector(self.presentTextStyleSheet))
        )
    }()

    lazy var iconConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Icons",
            type: .button,
            target: (source: self, action: #selector(self.presentIconSheet))
        )
    }()

    lazy var isEnableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Enable",
            type: .toggle(isOn: self.isEnabled),
            target: (source: self, action: #selector(self.toggleIsEnable))
        )
    }()

    lazy var isIndeterminateConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Indeterminate",
            type: .toggle(isOn: self.isIndeterminate),
            target: (source: self, action: #selector(self.toggleIsIndeterminate))
        )
    }()

    lazy var containerViewAlignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Extend right checkbox",
            type: .toggle(isOn: self.containerViewAlignment),
            target: (source: self, action: #selector(self.toggleContainerViewAlignment))
        )
    }()

    var themes = ThemeCellModel.themes

    // MARK: - Default Value Properties
    let icons: [String: UIImage] = [
        "Checkmark": DemoIconography.shared.checkmark.uiImage,
        "Close": DemoIconography.shared.close.uiImage
    ]

    let text: String = "Hello World"

    let multilineText: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var attributeText: NSAttributedString {
        let attributeString = NSMutableAttributedString(
            string: multilineText,
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

    let selectionState: CheckboxSelectionState

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: CheckboxIntent
    @Published var isEnabled: Bool
    @Published var alignment: CheckboxAlignment
    @Published var containerViewAlignment: Bool
    @Published var textStyle: CheckboxTextStyle
    @Published var icon: [String: UIImage]
    @Published var isIndeterminate: Bool

    init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        isEnabled: Bool = true,
        selectionState: CheckboxSelectionState = .unselected,
        alignment: CheckboxAlignment = .left,
        containerViewAlignment: Bool = false,
        textStyle: CheckboxTextStyle = .text,
        icon: [String: UIImage] = ["Checkmark": DemoIconography.shared.checkmark.uiImage],
        isIndeterminate: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.isEnabled = isEnabled
        self.selectionState = selectionState
        self.alignment = alignment
        self.containerViewAlignment = containerViewAlignment
        self.textStyle = textStyle
        self.icon = icon
        self.isIndeterminate = isIndeterminate
        super.init(identifier: "Checkbox")

        self.configurationViewModel = .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.textStyleConfigurationItemViewModel,
            self.iconConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.containerViewAlignmentConfigurationItemViewModel,
            self.isEnableConfigurationItemViewModel,
            self.isIndeterminateConfigurationItemViewModel
        ])
    }
}

// MARK: - Navigation
extension CheckboxComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(CheckboxIntent.allCases)
    }

    @objc func presentAlignmentSheet() {
        self.showAlignmentSheetSubject.send(CheckboxAlignment.allCases)
    }

    @objc func presentTextStyleSheet() {
        self.showTextStyleSheetSubject.send(CheckboxTextStyle.allCases)
    }

    @objc func presentIconSheet() {
        self.showIconSheetSubject.send(icons)
    }

    @objc func toggleIsEnable() {
        self.isEnabled.toggle()
    }

    @objc func toggleIsIndeterminate() {
        self.isIndeterminate.toggle()
    }

    @objc func toggleContainerViewAlignment() {
        self.containerViewAlignment.toggle()
    }
}

// MARK: - Enum
enum CheckboxTextStyle: CaseIterable {
    case text
    case multilineText
    case attributeText
    case none
}
