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

    var showGroupTypeSheet: AnyPublisher<[CheckboxGroupType], Never> {
        showGroupTypeSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[CheckboxIntent], Never> = .init()
    private var showIconSheetSubject: PassthroughSubject<[String: UIImage], Never> = .init()
    private var showGroupTypeSubject: PassthroughSubject<[CheckboxGroupType], Never> = .init()

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
            name: "Show Group Title",
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

    lazy var groupTypeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Group Type",
            type: .button,
            target: (source: self, action: #selector(self.presentGroupTypeSheet))
        )
    }()

    lazy var itemsSelectionStateConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Items Selection States",
            type: .label,
            target: (source: self, action: #selector(self.empty))
        )
    }()

    var themes = ThemeCellModel.themes

    // MARK: - Default Value Properties
    let title: String = "This is a title"

    let description: String = "This is Description"

    let icons: [String: UIImage] = [
        "Checkmark": DemoIconography.shared.uiCheckmark,
        "Close": DemoIconography.shared.uiClose
    ]

    static let text: String = "Hello World"

    static let multilineText: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    static var attributeText: NSAttributedString {
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
    @Published var groupType: CheckboxGroupType

    init(
        theme: Theme,
        intent: CheckboxIntent = .main,
        isAlignmentLeft: Bool = true,
        isLayoutVertical: Bool = false,
        showGroupTitle: Bool = false,
        icon: [String: UIImage] = ["Checkmark": DemoIconography.shared.uiCheckmark],
        groupType: CheckboxGroupType = .doubleMix
    ) {
        self.theme = theme
        self.intent = intent
        self.isAlignmentLeft = isAlignmentLeft
        self.isLayoutVertical = isLayoutVertical
        self.showGroupTitle = showGroupTitle
        self.icon = icon
        self.groupType = groupType
        super.init(identifier: "Checkbox Group")

        self.configurationViewModel = .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.layoutConfigurationItemViewModel,
            self.titleConfigurationItemViewModel,
            self.iconConfigurationItemViewModel,
            self.groupTypeConfigurationItemViewModel,
            self.itemsSelectionStateConfigurationItemViewModel
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

    @objc func presentGroupTypeSheet() {
        self.showGroupTypeSubject.send(CheckboxGroupType.allCases)
    }

    @objc func empty() {}
}

// MARK: - Items
extension CheckboxGroupComponentUIViewModel {

    static func makeCheckboxGroupItems(type: CheckboxGroupType, isSwiftUI: Bool = false) -> [CheckboxGroupItemDefault] {
        var items: [CheckboxGroupItemDefault] = []

        switch type {
        case .singleNone:
            items = [
                CheckboxGroupItemDefault(id: "1", selectionState: .selected, isEnabled: true)
            ]
        case .singleBasic:
            items = [
                CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .selected, isEnabled: true)
            ]
        case .singleMultilineText:
            if !isSwiftUI {
                items = [
                    CheckboxGroupItemDefault(attributedTitle: Self.attributeText, id: "1", selectionState: .unselected, isEnabled: true),
                ]
            } else {
                items = [
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "1", selectionState: .unselected, isEnabled: true),
                ]
            }
        case .doubleBasic:
            items = [
                CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .selected, isEnabled: true),
                CheckboxGroupItemDefault(title: Self.text + " 2", id: "2", selectionState: .unselected, isEnabled: true)
            ]
        case .doubleMultilineText:
            if !isSwiftUI {
                items = [
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "1", selectionState: .selected, isEnabled: true),
                    CheckboxGroupItemDefault(attributedTitle: Self.attributeText, id: "2", selectionState: .indeterminate, isEnabled: true)
                ]
            } else {
                items = [
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "1", selectionState: .selected, isEnabled: true),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "2", selectionState: .indeterminate, isEnabled: true)
                ]
            }
        case .doubleMix:
            if !isSwiftUI {
                items = [
                    CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .unselected, isEnabled: true),
                    CheckboxGroupItemDefault(attributedTitle: Self.attributeText, id: "2", selectionState: .selected, isEnabled: true)
                ]
            } else {
                items = [
                    CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .unselected, isEnabled: true),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "2", selectionState: .selected, isEnabled: true)
                ]
            }
        case .tripleBasic:
            items = [
                CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .unselected, isEnabled: true),
                CheckboxGroupItemDefault(title: Self.text + " 2", id: "2", selectionState: .unselected, isEnabled: true),
                CheckboxGroupItemDefault(title: Self.text + " 3", id: "3", selectionState: .unselected, isEnabled: true),
            ]
        case .tripleMultilineText:
            if !isSwiftUI {
                items = [
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "1", selectionState: .selected, isEnabled: false),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "2", selectionState: .unselected, isEnabled: true),
                    CheckboxGroupItemDefault(attributedTitle: Self.attributeText, id: "3", selectionState: .indeterminate, isEnabled: true)
                ]
            } else {
                items = [
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "1", selectionState: .selected, isEnabled: false),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "2", selectionState: .unselected, isEnabled: true),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "3", selectionState: .indeterminate, isEnabled: true)
                ]
            }
        case .tripleMix1:
            items = [
                CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .selected, isEnabled: true),
                CheckboxGroupItemDefault(title: Self.text + " 2", id: "2", selectionState: .indeterminate, isEnabled: true),
                CheckboxGroupItemDefault(title: Self.multilineText, id: "3", selectionState: .unselected, isEnabled: true)
            ]
        case .tripleMix2:
            if !isSwiftUI {
                items = [
                    CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .selected, isEnabled: true),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "2", selectionState: .unselected, isEnabled: true),
                    CheckboxGroupItemDefault(attributedTitle: Self.attributeText, id: "3", selectionState: .indeterminate, isEnabled: true)
                ]
            } else {
                items = [
                    CheckboxGroupItemDefault(title: Self.text, id: "1", selectionState: .selected, isEnabled: true),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "2", selectionState: .unselected, isEnabled: true),
                    CheckboxGroupItemDefault(title: Self.multilineText, id: "3", selectionState: .indeterminate, isEnabled: true)
                ]
            }

        }
        return items
    }
}

// MARK: Enum
enum CheckboxGroupType: CaseIterable {
    case singleNone
    case singleBasic
    case singleMultilineText
    case doubleBasic
    case doubleMultilineText
    case doubleMix
    case tripleBasic
    case tripleMultilineText
    case tripleMix1
    case tripleMix2
}

