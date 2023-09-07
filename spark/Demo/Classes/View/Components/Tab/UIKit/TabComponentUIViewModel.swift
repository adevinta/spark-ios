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
import SparkCore

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
            target: (source: self, action: #selector(self.showLabelChanged)))
    }()

    lazy var longLabelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Long Label",
            type: .checkbox(title: "", isOn: self.showLongLabel),
            target: (source: self, action: #selector(self.showLongLabelChanged)))
    }()

    lazy var iconConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Icon",
            type: .checkbox(title: "", isOn: self.showIcon),
            target: (source: self, action: #selector(self.showIconChanged)))
    }()

    lazy var badgeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Badge",
            type: .checkbox(title: "", isOn: self.showBadge),
            target: (source: self, action: #selector(self.showBadgeChanged)))
    }()

    lazy var equalWidthConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Equal width",
            type: .checkbox(title: "", isOn: self.isEqualWidth),
            target: (source: self, action: #selector(self.equalWidthChanged)))
    }()

    lazy var numberOfTabsConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Number of tabs",
            type: .rangeSelector(selected: self.numberOfTabs, range: 1...20),
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

    var content: [(image: UIImage?, title: String?)] {
        (0...self.numberOfTabs).map{
            (self.image(at: $0), self.title(at: $0))
        }
    }

    lazy var configurationViewModel: ComponentsConfigurationUIViewModel = {
        return .init(itemsViewModel: [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.labelConfigurationItemViewModel,
            self.longLabelConfigurationItemViewModel,
            self.iconConfigurationItemViewModel,
            self.badgeConfigurationItemViewModel,
            self.equalWidthConfigurationItemViewModel,
            self.numberOfTabsConfigurationItemViewModel
        ])
    }()
    var themes = ThemeCellModel.themes

    // MARK: - Inherited Properties
    let identifier: String = "Tab"
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
    }

    func longTitle(at index: Int) -> String {
        return "\(self.longText) \(index + 1)"
    }

    func title(at index: Int) -> String {
        if self.showLongLabel && index == 1 {
            return longTitle(at: index)
        }
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

    @objc func showLabelChanged() {
        self.showLabel.toggle()
    }

    @objc func showLongLabelChanged() {
        self.showLongLabel.toggle()
    }

    @objc func showIconChanged() {
        self.showIcon.toggle()
    }

    @objc func showBadgeChanged() {
        self.showBadge.toggle()
    }

    @objc func equalWidthChanged() {
        self.isEqualWidth.toggle()
    }

    @objc func numberOfTabsChanged(_ control: NumberSelector) {
        self.numberOfTabs = control.selectedValue
    }
}

// MARK: - Private helpers
private extension UIImage {
    static let names = [
        "fleuron",
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
        "menucard",
        "magazine"
    ]

    // swiftlint: disable force_unwrapping
    static func image(at index: Int) -> UIImage {
        let allSfs: [String] = names.flatMap{ [$0, "\($0).fill"] }
        let imageName = allSfs[index % names.count]
        return UIImage(systemName: imageName)!
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
