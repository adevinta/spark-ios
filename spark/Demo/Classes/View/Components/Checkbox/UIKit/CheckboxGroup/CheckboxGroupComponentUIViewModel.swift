//
//  CheckboxGroupComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 16.10.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class CheckboxGroupComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[CheckboxIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showImageSheet: AnyPublisher<[String: UIImage], Never> {
        showIconSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[CheckboxIntent], Never> = .init()
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
            name: "Is Alignment Left",
            type: .toggle(isOn: self.isAlignmentLeft),
            target: (source: self, action: #selector(self.toggleIsAlignmentLeft))
        )
    }()

    lazy var layoutConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Layout Vertical",
            type: .toggle(isOn: self.isLayoutVertical),
            target: (source: self, action: #selector(self.toggleIsLayoutVertical))
        )
    }()

    lazy var titleConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Group Title (Deprecated)",
            type: .toggle(isOn: self.showGroupTitle),
            target: (source: self, action: #selector(self.toggleShowGroupTitle))
        )
    }()

    lazy var iconConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Icons",
            type: .button,
            target: (source: self, action: #selector(self.presentIconSheet))
        )
    }()

    var themes = ThemeCellModel.themes

    // MARK: - Default Value Properties
    let title: String = "This title was deprecated"

    let description: String = "This is Description"

    let icons: [String: UIImage] = [
        "Checkmark": DemoIconography.shared.checkmark,
        "Close": DemoIconography.shared.close
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

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: CheckboxIntent
    @Published var isAlignmentLeft: Bool
    @Published var isLayoutVertical: Bool
    @Published var showGroupTitle: Bool
    @Published var icon: [String: UIImage]

    init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        isAlignmentLeft: Bool = true,
        isLayoutVertical: Bool = false,
        showGroupTitle: Bool = false,
        icon: [String: UIImage] = ["Checkmark": DemoIconography.shared.checkmark]
    ) {
        self.theme = theme
        self.intent = intent
        self.isAlignmentLeft = isAlignmentLeft
        self.isLayoutVertical = isLayoutVertical
        self.showGroupTitle = showGroupTitle
        self.icon = icon
        super.init(identifier: "Checkbox Group")

        self.configurationViewModel = .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.layoutConfigurationItemViewModel,
            self.titleConfigurationItemViewModel,
            self.iconConfigurationItemViewModel
        ])
    }
}

// MARK: - Navigation
extension CheckboxGroupComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(CheckboxIntent.allCases)
    }

    @objc func toggleIsAlignmentLeft() {
        self.isAlignmentLeft.toggle()
    }

    @objc func toggleIsLayoutVertical() {
        self.isLayoutVertical.toggle()
    }

    @objc func toggleShowGroupTitle() {
        self.showGroupTitle.toggle()
    }

    @objc func presentIconSheet() {
        self.showIconSheetSubject.send(icons)
    }
}
