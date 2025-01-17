//
//  TextEditorComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 12.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import SparkCore
import UIKit

final class TextEditorComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[TextEditorIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showTextSheet: AnyPublisher<[TextEditorContent], Never> {
        showTextSheetSubject
            .eraseToAnyPublisher()
    }

    var showPlaceholderSheet: AnyPublisher<[TextEditorContent], Never> {
        showPlaceHolderSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TextEditorIntent], Never> = .init()
    private var showTextSheetSubject: PassthroughSubject<[TextEditorContent], Never> = .init()
    private var showPlaceHolderSheetSubject: PassthroughSubject<[TextEditorContent], Never> = .init()

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

    lazy var textConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Text Type",
            type: .button,
            target: (source: self, action: #selector(self.presentTextSheet))
        )
    }()

    lazy var placeholderConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Placeholder Type",
            type: .button,
            target: (source: self, action: #selector(self.presentPlaceholderSheet))
        )
    }()

    lazy var isEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "is Enabled",
            type: .checkbox(title: "", isOn: self.isEnabled),
            target: (source: self, action: #selector(self.enabledChanged(_:))))
    }()

    lazy var isEditableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Editable",
            type: .checkbox(title: "", isOn: self.isEditable),
            target: (source: self, action: #selector(self.isEditableChanged(_:))))
    }()

    lazy var sizesConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Static Sizes",
            type: .checkbox(title: "", isOn: self.isStaticSizes),
            target: (source: self, action: #selector(self.staticSizesChanged(_:))))
    }()

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.textConfigurationItemViewModel,
            self.placeholderConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isEditableConfigurationItemViewModel,
            self.sizesConfigurationItemViewModel
        ]
    }

    // MARK: - Inherited Properties

    var themes = ThemeCellModel.themes

    // MARK: - Default Value Properties
    let image: UIImage = UIImage(named: "alert") ?? UIImage()

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: TextEditorIntent
    @Published var text: TextEditorContent
    @Published var placeholder: TextEditorContent
    @Published var isEnabled: Bool
    @Published var isEditable: Bool
    @Published var isStaticSizes: Bool

    init(
        theme: Theme,
        intent: TextEditorIntent = .neutral,
        text: TextEditorContent = .medium,
        placeholder: TextEditorContent = .short,
        isEnabled: Bool = true,
        isEditable: Bool = true,
        isDynamicHeight: Bool = true,
        isStaticSizes: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.text = text
        self.placeholder = placeholder
        self.isEnabled = isEnabled
        self.isEditable = isEditable
        self.isStaticSizes = isStaticSizes

        super.init(identifier: "TextEditor")
    }
}

// MARK: - Navigation
extension TextEditorComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(TextEditorIntent.allCases)
    }

    @objc func presentTextSheet() {
        self.showTextSheetSubject.send(TextEditorContent.allCases)
    }

    @objc func presentPlaceholderSheet() {
        self.showPlaceHolderSheetSubject.send(TextEditorContent.allCases)
    }

    @objc func enabledChanged(_ isSelected: Any?) {
        self.isEnabled = isTrue(isSelected)
    }

    @objc func isEditableChanged(_ isSelected: Any?) {
        self.isEditable = isTrue(isSelected)
    }

    @objc func staticSizesChanged(_ isSelected: Any?) {
        self.isStaticSizes = isTrue(isSelected)
    }
}

enum TextEditorContent: CaseIterable {
    case none
    case short
    case medium
    case long
}
