//
//  TabComponentUIViewModel.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 06.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Foundation
import UIKit
import Spark

final class TabComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[TabIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[TabSize], Never> {
        showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TabIntent], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[TabSize], Never> = .init()

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

    lazy var sizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Size",
            type: .button,
            target: (source: self, action: #selector(self.presentSizeSheet))
        )
    }()

    lazy var labelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Label",
            type: .checkbox(title: "", isOn: self.showLabel),
            target: (source: self, action: #selector(self.showLabelChanged(_:))))
    }()

    lazy var longLabelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Long Label",
            type: .checkbox(title: "", isOn: self.showLongLabel),
            target: (source: self, action: #selector(self.showLongLabelChanged(_:))))
    }()

    lazy var iconConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Icon",
            type: .checkbox(title: "", isOn: self.showIcon),
            target: (source: self, action: #selector(self.showIconChanged(_:))))
    }()

    lazy var badgeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Badge",
            type: .checkbox(title: "", isOn: self.showBadge),
            target: (source: self, action: #selector(self.showBadgeChanged(_:))))
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Disable Random Tab",
            type: .checkbox(title: "", isOn: self.disabledIndex != nil),
            target: (source: self, action: #selector(self.disableChanged(_:))))
    }()

    lazy var disableAllConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Disable All",
            type: .checkbox(title: "", isOn: self.isDisabled),
            target: (source: self, action: #selector(self.disableAll(_:))))
    }()

    lazy var equalWidthConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Equal width",
            type: .checkbox(title: "", isOn: self.isEqualWidth),
            target: (source: self, action: #selector(self.equalWidthChanged(_:))))
    }()

    lazy var numberOfTabsConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Number of tabs",
            type: .rangeSelector(
                selected: self.numberOfTabs,
                range: 1...20
            ),
            target: (source: self, action: #selector(self.numberOfTabsChanged)))
    }()

    var badge: BadgeUIView {
        let badge = BadgeUIView(
            theme: self.theme,
            intent: .danger,
            value: 99
        )
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.isBorderVisible = false
        badge.size = self.size.badgeSize
        return badge
    }

    var badgePosition: Int {
        return .random(in: 0...numberOfTabs - 1)
    }

    var content: [TabUIItemContent] {
        (0...self.numberOfTabs).map {
            .init(icon: self.image(at: $0), title: self.title(at: $0))
        }
    }

    var themes = ThemeCellModel.themes

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.labelConfigurationItemViewModel,
            self.longLabelConfigurationItemViewModel,
            self.iconConfigurationItemViewModel,
            self.badgeConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.disableAllConfigurationItemViewModel,
            self.equalWidthConfigurationItemViewModel,
            self.numberOfTabsConfigurationItemViewModel
        ]
    }

    // MARK: - Inherited Properties

    let text = "Tab"
    let longText = "Long Title"

    // MARK: - Published Properties
    @Published var theme: Theme
    @Published var intent: TabIntent
    @Published var size: TabSize
    @Published var showLabel = true
    @Published var showLongLabel = false
    @Published var showIcon = true
    @Published var showBadge = false
    @Published var disabledIndex: Int?
    @Published var isDisabled = false
    @Published var isEqualWidth = true
    @Published var numberOfTabs = 2

    // MARK: - Initialization
    init(
        theme: Theme,
        intent: TabIntent = .basic,
        size: TabSize = .md
    ) {
        self.theme = theme
        self.intent = intent
        self.size = size

        super.init(identifier: "Tab")
    }

    func longTitle(at index: Int) -> String {
        return "\(self.longText) \(index + 1)"
    }

    func title(at index: Int) -> String {
        return "\(self.text) \(index + 1)"
    }

    func image(at index: Int) -> UIImage {
        return .image(at: index)
    }
}

// MARK: - Navigation
extension TabComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(TabIntent.allCases)
    }

    @objc func presentSizeSheet() {
        self.showSizeSheetSubject.send(TabSize.allCases)
    }

    @objc func showLabelChanged(_ isSelected: Any?) {
        self.showLabel = isTrue(isSelected)
    }

    @objc func showLongLabelChanged(_ isSelected: Any?) {
        self.showLongLabel = isTrue(isSelected)
    }

    @objc func showIconChanged(_ isSelected: Any?) {
        self.showIcon = isTrue(isSelected)
    }

    @objc func showBadgeChanged(_ isSelected: Any?) {
        self.showBadge = isTrue(isSelected)
    }

    @objc func disableChanged(_ isSelected: Any?) {
        if !isTrue(isSelected) {
            self.disabledIndex = nil
        } else {
            self.disabledIndex = Int.random(in: 0..<self.numberOfTabs)
        }
    }

    @objc func disableAll(_ isSelected: Any?) {
        self.isDisabled = isTrue(isSelected)
    }

    @objc func equalWidthChanged(_ isSelected: Any?) {
        self.isEqualWidth = isTrue(isSelected)
    }

    @objc func numberOfTabsChanged(_ control: NumberSelector) {
        self.numberOfTabs = control.selectedValue
    }
}

// MARK: - Private helpers
extension UIImage {
    static let names = [
        "trash",
        "folder",
        "paperplane",
        "tray",
        "externaldrive",
        "internaldrive",
        "archivebox",
        "doc",
        "clipboard",
        "terminal",
        "book",
        "greetingcard",
        "magazine"
    ]

    static func image(at index: Int) -> UIImage {
        let allSfs: [String] = names.flatMap{ [$0, "\($0).fill"] }
        let imageName = allSfs[index % allSfs.count]
        return UIImage(systemName: imageName) ?? UIImage()
    }

    static func standardImage(at index: Int) -> UIImage {
        let imageName = names[index % names.count]
        return UIImage(systemName: imageName) ?? UIImage()
    }

    static func filledImage(at index: Int) -> UIImage {
        let imageName = names[index % names.count]
        return UIImage(systemName: "\(imageName).fill") ?? UIImage()
    }

    static func selectedImage(at index: Int) -> UIImage {
        let imageName = names[index % names.count]
        return UIImage(systemName: "\(imageName).circle.fill") ?? UIImage()
    }
}

private extension TabSize {
    var badgeSize: BadgeSize {
        switch self {
        case .md: return .medium
        case .xs: return .small
        case .sm: return .small
        @unknown default: return .medium
        }
    }
}
