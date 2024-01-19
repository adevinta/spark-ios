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

    enum ExtraComponent: CaseIterable {
        case badge
        case button
        case none
    }

    private static let alertIcon = UIImage(imageLiteralResourceName: "alert")

    private var label: String? = "Label" {
        didSet {
            self.title = self.label
        }
    }

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

    var showExtraComponent: AnyPublisher<[ExtraComponent], Never> {
        showExtraComponentSheetSubject
            .eraseToAnyPublisher()
    }

    var themes = ThemeCellModel.themes

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ChipIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ChipVariant], Never> = .init()
    private var showIconPositionSheetSubject: PassthroughSubject<[IconPosition], Never> = .init()
    private var showExtraComponentSheetSubject: PassthroughSubject<[ExtraComponent], Never> = .init()

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
        let viewModel = ComponentsConfigurationItemUIViewModel(
            name: "Icon Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentIconPositonSheet)))
        viewModel.buttonTitle = IconPosition.none.name
        return viewModel
    }()

    lazy var extraComponentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        let viewModel = ComponentsConfigurationItemUIViewModel(
            name: "Extra Component",
            type: .button,
            target: (source: self, action: #selector(self.presentExtraComponentSheet)))
        viewModel.buttonTitle = ExtraComponent.none.name
        return viewModel
    }()

    lazy var labelContentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Label",
            type: .input(text: self.label),
            target: (source: self, action: #selector(self.labelChanged(_:))))
    }()

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Enable",
            type: .checkbox(title: "", isOn: self.isEnabled),
            target: (source: self, action: #selector(self.enabledChanged(_:))))
    }()

    lazy var selectedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Selected",
            type: .checkbox(title: "", isOn: self.isSelected),
            target: (source: self, action: #selector(self.selectedChanged(_:))))
    }()

    lazy var hasActionConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Action",
            type: .checkbox(title: "", isOn: self.hasAction),
            target: (source: self, action: #selector(self.hasActionChanged(_:))))
    }()

    var showIcon = true {
        didSet {
            self.icon = self.showIcon ? Self.alertIcon : nil
        }
    }

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
    @Published var badge: UIView?
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
            self.extraComponentConfigurationItemViewModel,
            self.labelContentConfigurationItemViewModel,
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

    private func createButton() -> UIButton {
        let button = UIButton()

        let image = UIImage(systemName: "xmark.circle")?
            .withRenderingMode(.alwaysTemplate)

        var configuration = UIButton.Configuration.bordered()
        configuration.image = image
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.baseBackgroundColor = .clear

        button.configuration = configuration
        button.addTarget(self, action: #selector(self.deleteItem), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.tintColor = self.theme.colors.basic.basic.uiColor
        return button
    }

    func iconAlignmentDidUpdate(_ alignment: IconPosition) {
        switch alignment {
        case .none: self.showIcon = false
        case .leading: self.showIcon = true
            self.alignment = .leadingIcon
        case .trailing: self.showIcon = true
            self.alignment = .trailingIcon
        }

        self.iconConfigurationItemViewModel.buttonTitle = alignment.name
    }

    func extraComponentDidUpdate(_ component: ExtraComponent) {
        self.extraComponentConfigurationItemViewModel.buttonTitle = component.name

        switch component {
        case .none: self.badge = nil
        case .button: self.badge = self.createButton()
        case .badge: self.badge = self.createBadge()
        }
    }

}

// MARK: - Navigation
extension ChipComponentUIViewModel {

    @objc func deleteItem() {
    }

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

    @objc func presentExtraComponentSheet() {
        self.showExtraComponentSheetSubject.send(ExtraComponent.allCases)
    }

    @objc func labelChanged(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            self.label = textField.text
        } else  {
            self.label = nil
        }
    }

    @objc func showIconChanged(_ isSelected: Any?) {
        self.showIcon = isTrue(isSelected)
    }

    @objc func enabledChanged(_ isSelected: Any?) {
        self.isEnabled = isTrue(isSelected)
    }

    @objc func selectedChanged(_ isSelected: Any?) {
        self.isSelected = isTrue(isSelected)
    }

    @objc func hasActionChanged(_ isSelected: Any?) {
        self.hasAction = isTrue(isSelected)
    }
}
