//
//  TextEditorComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 12.06.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import Spark
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

    lazy var disableConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Enable",
            type: .checkbox(title: "", isOn: self.isEnabled),
            target: (source: self, action: #selector(self.enabledChanged(_:))))
    }()

    lazy var readonlyConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "IsReadonly",
            type: .checkbox(title: "", isOn: self.isReadonly),
            target: (source: self, action: #selector(self.readonlyChanged(_:))))
    }()

    lazy var dynamicHeightConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "IsDynamicHeight",
            type: .checkbox(title: "", isOn: self.isDynamicHeight),
            target: (source: self, action: #selector(self.dynamicHeightChanged(_:))))
    }()

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.textConfigurationItemViewModel,
            self.placeholderConfigurationItemViewModel,
            self.disableConfigurationItemViewModel,
            self.readonlyConfigurationItemViewModel,
            self.dynamicHeightConfigurationItemViewModel
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
    @Published var isReadonly: Bool
    @Published var isDynamicHeight: Bool

    init(
        theme: Theme,
        intent: TextEditorIntent = .neutral,
        text: TextEditorContent = .none,
        placeholder: TextEditorContent = .medium,
        isEnabled: Bool = true,
        isReadonly: Bool = false,
        isDynamicHeight: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.text = text
        self.placeholder = placeholder
        self.isEnabled = isEnabled
        self.isReadonly = isReadonly
        self.isDynamicHeight = isDynamicHeight

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

    @objc func readonlyChanged(_ isSelected: Any?) {
        self.isReadonly = isTrue(isSelected)
    }

    @objc func dynamicHeightChanged(_ isSelected: Any?) {
        self.isDynamicHeight = isTrue(isSelected)
    }
}

enum TextEditorContent: CaseIterable {
    case none
    case short
    case medium
    case long
}

enum TextEditorWidthSize: CaseIterable {
    case `default`
    case statics
    case extend
}

enum TextEditorHeightSize: CaseIterable {
    case `default`
    case statics
    case flexiable
}
