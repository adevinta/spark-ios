//
//  TextFieldComponentUIViewModel.swift
//  SparkDemo
//
//  Created by louis.borlee on 24/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SparkCore

final class TextFieldComponentUIViewModel: ComponentUIViewModel, ObservableObject {

    @Published var theme: Theme
    @Published var intent: TextFieldIntent
    @Published var isEnabled: Bool = true
    @Published var isUserInteractionEnabled: Bool = true
    @Published var leftViewMode: UITextField.ViewMode = .never
    @Published var rightViewMode: UITextField.ViewMode = .never
    @Published var clearButtonMode: UITextField.ViewMode = .never

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        self.showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[TextFieldIntent], Never> {
        self.showIntentSheetSubject
            .eraseToAnyPublisher()
    }
    var showClearButtonModeSheet: AnyPublisher<[UITextField.ViewMode], Never> {
        self.showClearButtonModeSheetSubject
            .eraseToAnyPublisher()
    }
    var showLeftViewModeSheet: AnyPublisher<[UITextField.ViewMode], Never> {
        self.showLeftViewModeSheetSubject
            .eraseToAnyPublisher()
    }
    var showRightViewModeSheet: AnyPublisher<[UITextField.ViewMode], Never> {
        self.showRightViewModeSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

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

    lazy var clearButtonModeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "ClearButtonMode",
            type: .button,
            target: (source: self, action: #selector(self.presentClearButtonMode))
        )
    }()

    lazy var leftViewModeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "LeftViewMode",
            type: .button,
            target: (source: self, action: #selector(self.presentLeftViewMode))
        )
    }()

    lazy var rightViewModeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "RightViewMode",
            type: .button,
            target: (source: self, action: #selector(self.presentRightViewMode))
        )
    }()

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TextFieldIntent], Never> = .init()
    private var showClearButtonModeSheetSubject: PassthroughSubject<[UITextField.ViewMode], Never> = .init()
    private var showLeftViewModeSheetSubject: PassthroughSubject<[UITextField.ViewMode], Never> = .init()
    private var showRightViewModeSheetSubject: PassthroughSubject<[UITextField.ViewMode], Never> = .init()

    init(
        theme: Theme,
        intent: TextFieldIntent = .neutral
    ) {
        self.theme = theme
        self.intent = intent
        super.init(identifier: "TextField")
    }

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isUserInteractionEnabledConfigurationItemViewModel,
            self.clearButtonModeConfigurationItemViewModel,
            self.leftViewModeConfigurationItemViewModel,
            self.rightViewModeConfigurationItemViewModel
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

    @objc func presentClearButtonMode() {
        self.showClearButtonModeSheetSubject.send(UITextField.ViewMode.allCases)
    }

    @objc func presentLeftViewMode() {
        self.showLeftViewModeSheetSubject.send(UITextField.ViewMode.allCases)
    }

    @objc func presentRightViewMode() {
        self.showRightViewModeSheetSubject.send(UITextField.ViewMode.allCases)
    }
}

extension UITextField.ViewMode: CaseIterable {
    public static var allCases: [UITextField.ViewMode] = [
        .never,
        .whileEditing,
        .unlessEditing,
        .always
    ]
}
