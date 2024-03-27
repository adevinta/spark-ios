//
//  TextFieldAddonsComponentUIViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 14/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore

final class TextFieldAddonsComponentUIViewModel: ComponentUIViewModel, ObservableObject {

    @Published var theme: Theme
    @Published var intent: TextFieldIntent
    @Published var isEnabled: Bool = true
    @Published var isUserInteractionEnabled: Bool = true
    @Published var leftViewContent: TextFieldSideViewContent = .none
    @Published var rightViewContent: TextFieldSideViewContent = .none
    @Published var leftAddonContent: TextFieldAddonContent = .buttonFull
    @Published var rightAddonContent: TextFieldAddonContent = .icon
    @Published var addonPadding: Bool = false

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        self.showThemeSheetSubject
            .eraseToAnyPublisher()
    }
    var showIntentSheet: AnyPublisher<[TextFieldIntent], Never> {
        self.showIntentSheetSubject
            .eraseToAnyPublisher()
    }
    var showLeftViewContentSheet: AnyPublisher<[TextFieldSideViewContent], Never> {
        self.showLeftViewContentSheetSubject
            .eraseToAnyPublisher()
    }
    var showRightViewContentSheet: AnyPublisher<[TextFieldSideViewContent], Never> {
        self.showRightViewContentSheetSubject
            .eraseToAnyPublisher()
    }
    var showLeftAddonContentSheet: AnyPublisher<[TextFieldAddonContent], Never> {
        self.showLeftAddonContentSheetSubject
            .eraseToAnyPublisher()
    }
    var showRightAddonContentSheet: AnyPublisher<[TextFieldAddonContent], Never> {
        self.showRightAddonContentSheetSubject
            .eraseToAnyPublisher()
    }

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

    lazy var isEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "IsEnabled",
            type: .toggle(isOn: self.isEnabled),
            target: (source: self, action: #selector(self.toggleIsEnabled))
        )
    }()

    lazy var isUserInteractionEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "IsUserInteractionEnabled",
            type: .toggle(isOn: self.isUserInteractionEnabled),
            target: (source: self, action: #selector(self.toggleIsUserInteractionEnabled))
        )
    }()
    lazy var leftViewContentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "LeftViewContent",
            type: .button,
            target: (source: self, action: #selector(self.presentLeftViewContent))
        )
    }()
    lazy var rightViewContentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "RightViewContent",
            type: .button,
            target: (source: self, action: #selector(self.presentRightViewContent))
        )
    }()
    lazy var leftAddonContentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "LeftAddonContent",
            type: .button,
            target: (source: self, action: #selector(self.presentLeftAddonContent))
        )
    }()
    lazy var rightAddonContentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "RightAddonContent",
            type: .button,
            target: (source: self, action: #selector(self.presentRightAddonContent))
        )
    }()

    lazy var addonPaddingConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "With addon padding",
            type: .toggle(isOn: self.addonPadding),
            target: (source: self, action: #selector(self.toggleAddonPadding))
        )
    }()

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TextFieldIntent], Never> = .init()
    private var showLeftViewContentSheetSubject: PassthroughSubject<[TextFieldSideViewContent], Never> = .init()
    private var showRightViewContentSheetSubject: PassthroughSubject<[TextFieldSideViewContent], Never> = .init()
    private var showLeftAddonContentSheetSubject: PassthroughSubject<[TextFieldAddonContent], Never> = .init()
    private var showRightAddonContentSheetSubject: PassthroughSubject<[TextFieldAddonContent], Never> = .init()

    let themes = ThemeCellModel.themes

    init(
        theme: Theme,
        intent: TextFieldIntent = .neutral
    ) {
        self.theme = theme
        self.intent = intent
        super.init(identifier: "TextFieldAddons")
    }

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isUserInteractionEnabledConfigurationItemViewModel,
            self.leftViewContentConfigurationItemViewModel,
            self.rightViewContentConfigurationItemViewModel,
            self.leftAddonContentConfigurationItemViewModel,
            self.rightAddonContentConfigurationItemViewModel,
            self.addonPaddingConfigurationItemViewModel
        ]
    }

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(TextFieldIntent.allCases)
    }

    @objc func toggleIsEnabled() {
        self.isEnabled.toggle()
    }

    @objc func toggleIsUserInteractionEnabled() {
        self.isUserInteractionEnabled.toggle()
    }

    @objc func presentLeftViewContent() {
        self.showLeftViewContentSheetSubject.send(TextFieldSideViewContent.allCases)
    }

    @objc func presentRightViewContent() {
        self.showRightViewContentSheetSubject.send(TextFieldSideViewContent.allCases)
    }

    @objc func presentLeftAddonContent() {
        self.showLeftAddonContentSheetSubject.send(TextFieldAddonContent.allCases)
    }

    @objc func presentRightAddonContent() {
        self.showRightAddonContentSheetSubject.send(TextFieldAddonContent.allCases)
    }

    @objc func toggleAddonPadding() {
        self.addonPadding.toggle()
    }
}
