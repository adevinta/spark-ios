//
//  ChipComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 24.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class ChipComponentUIViewModel: ComponentUIViewModel {

    enum IconPosition: CaseIterable {
        case leading
        case trailing
        case none
    }

    private static let alertIcon = UIImage(imageLiteralResourceName: "alert")

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ChipIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[ChipVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showIconPosition: AnyPublisher<[IconPosition], Never> {
        showIconPositionSheetSubject
            .eraseToAnyPublisher()
    }

    var themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ChipIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ChipVariant], Never> = .init()
    private var showIconPositionSheetSubject: PassthroughSubject<[IconPosition], Never> = .init()

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

    lazy var variantConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Variant",
            type: .button,
            target: (source: self, action: #selector(self.presentVariantSheet))
        )
    }()

    lazy var iconConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Icon Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentIconPositonSheet)))
    }()


    lazy var labelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Label",
            type: .checkbox(title: "", isOn: self.showLabel),
            target: (source: self, action: #selector(self.showLabelChanged)))
    }()

    lazy var badgeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Show Badge",
            type: .checkbox(title: "", isOn: self.showBadge),
            target: (source: self, action: #selector(self.showBadgeChanged)))
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Enable",
            type: .checkbox(title: "", isOn: self.isEnabled),
            target: (source: self, action: #selector(self.enabledChanged)))
    }()

    lazy var selectedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Selected",
            type: .checkbox(title: "", isOn: self.isSelected),
            target: (source: self, action: #selector(self.selectedChanged)))
    }()

    lazy var hasActionConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Action",
            type: .checkbox(title: "", isOn: self.hasAction),
            target: (source: self, action: #selector(self.hasActionChanged)))
    }()

    var showLabel = true {
        didSet {
            self.title = self.showLabel ? "Label" : nil
        }
    }

    var showIcon = true {
        didSet {
            self.icon = self.showIcon ? Self.alertIcon : nil
        }
    }

    var showBadge = false {
        didSet {
            self.badge = self.showBadge ? self.createBadge() : nil
        }
    }

    // swiftlint:disable all
    var hasAction: Bool {
        set {
            self.action = newValue ? {} : nil
        }
        get {
            self.action != nil
        }
    }

    // MARK: - Published Properties
    @Published var theme: Theme
    @Published var intent: ChipIntent
    @Published var variant: ChipVariant
    @Published var alignment: ChipAlignment = .leadingIcon
    @Published var badge: BadgeUIView?
    @Published var isEnabled = true
    @Published var isSelected = false
    @Published var title: String? = "Label"
    @Published var icon: UIImage? = alertIcon
    @Published var action: (() -> Void)?

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.iconConfigurationItemViewModel,
            self.labelConfigurationItemViewModel,
            self.badgeConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.selectedConfigurationItemViewModel,
            self.hasActionConfigurationItemViewModel
        ]
    }

    // MARK: Initializer
    init(
        theme: Theme,
        intent: ChipIntent = .basic,
        variant: ChipVariant = .outlined
    ) {
        self.theme = theme
        self.intent = intent
        self.variant = variant

        super.init(identifier: "Chip")
        self.action = {}
    }

    private func createBadge() -> BadgeUIView {
        let badge = BadgeUIView(
            theme: self.theme,
            intent: .danger,
            value: 99
        )
        badge.size = .small
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.isBorderVisible = false
        return badge
    }

}

// MARK: - Navigation
extension ChipComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ChipIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(ChipVariant.allCases)
    }

    @objc func presentIconPositonSheet() {
        self.showIconPositionSheetSubject.send(IconPosition.allCases)
    }

    @objc func showLabelChanged() {
        self.showLabel.toggle()
    }

    @objc func showBadgeChanged() {
        self.showBadge.toggle()
    }

    @objc func showIconChanged() {
        self.showIcon.toggle()
    }

    @objc func enabledChanged() {
        self.isEnabled.toggle()
    }

    @objc func selectedChanged() {
        self.isSelected.toggle()
    }

    @objc func hasActionChanged() {
        self.hasAction.toggle()
    }
}
