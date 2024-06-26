//
//  SwitchComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 30.08.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import UIKit

final class SwitchComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[SwitchIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showAlignmentSheet: AnyPublisher<[SwitchAlignment], Never> {
        showAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSheet: AnyPublisher<[SwitchTextContentDefault], Never> {
        showContentSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[SwitchIntent], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[SwitchAlignment], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[SwitchTextContentDefault], Never> = .init()

    private let atttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: SparkTheme.shared.colors.main.main.uiColor,
        .font: SparkTheme.shared.typography.body2Highlight.uiFont
    ]

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
            name: "Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentAlignmentSheet))
        )
    }()

    lazy var contentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content",
            type: .button,
            target: (source: self, action: #selector(self.presentContentSheet))
        )
    }()

    lazy var isOnConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is On",
            type: .toggle(isOn: self.isOn),
            target: (source: self, action: #selector(self.isOnChanged))
        )
    }()

    lazy var isOnAnimatedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is On Animated",
            type: .toggle(isOn: self.isOnAnimated),
            target: (source: self, action: #selector(self.isOnAnimatedChanged))
        )
    }()

    lazy var isEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Enabled",
            type: .toggle(isOn: self.isEnabled),
            target: (source: self, action: #selector(self.isEnabledChanged))
        )
    }()

    lazy var isEnabledAnimatedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Enabled Animated",
            type: .toggle(isOn: self.isEnabledAnimated),
            target: (source: self, action: #selector(self.isEnabledAnimatedChanged))
        )
    }()

    lazy var hasImagesConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Has Images",
            type: .toggle(isOn: self.hasImages),
            target: (source: self, action: #selector(self.hasImagesChanged))
        )
    }()

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return  [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.alignmentConfigurationItemViewModel,
            self.contentConfigurationItemViewModel,
            self.isOnConfigurationItemViewModel,
            self.isOnAnimatedConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isEnabledAnimatedConfigurationItemViewModel,
            self.hasImagesConfigurationItemViewModel,
        ]
    }

    // MARK: - Default Value Properties
    let themes = ThemeCellModel.themes
    let images: SwitchUIImages = {
        let onImage = UIImage(named: "check") ?? UIImage()
        let offImage = UIImage(named: "close") ?? UIImage()

        return SwitchUIImages(
            on: onImage,
            off: offImage
        )
    }()
    let text: String = "Text"
    let multilineText: String = "This is an example of a multi-line text which is very long and in which the user should read all the information."
    let attributedText: NSAttributedString

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: SwitchIntent
    @Published var alignment: SwitchAlignment
    @Published var textContent: SwitchTextContentDefault
    @Published var isOn: Bool
    @Published var isOnAnimated: Bool
    @Published var isEnabled: Bool
    @Published var isEnabledAnimated: Bool
    @Published var hasImages: Bool

    init(
        theme: Theme,
        intent: SwitchIntent = .main,
        alignment: SwitchAlignment = .left,
        textContent: SwitchTextContentDefault = .text,
        isOn: Bool = true,
        isOnAnimated: Bool = true,
        isEnabled: Bool = true,
        isEnabledAnimated: Bool = true,
        hasImages: Bool = false,
        isAnimated: Bool = true
    ) {
        self.theme = theme
        self.intent = intent
        self.alignment = alignment
        self.textContent = textContent
        self.isOn = isOn
        self.isOnAnimated = isOnAnimated
        self.isEnabled = isEnabled
        self.isEnabledAnimated = isEnabledAnimated
        self.hasImages = hasImages
        self.attributedText = .init(
            string: self.text,
            attributes: atttributes
        )

        super.init(identifier: "Switch")
    }
}

// MARK: - Navigation
extension SwitchComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(SwitchIntent.allCases)
    }

    @objc func presentAlignmentSheet() {
        self.showAlignmentSheetSubject.send(SwitchAlignment.allCases)
    }

    @objc func presentContentSheet() {
        self.showContentSheetSubject.send(SwitchTextContentDefault.allCases)
    }

    @objc func isOnChanged() {
        self.isOn.toggle()
    }

    @objc func isOnAnimatedChanged() {
        self.isOnAnimated.toggle()
    }

    @objc func isEnabledChanged() {
        self.isEnabled.toggle()
    }

    @objc func isEnabledAnimatedChanged() {
        self.isEnabledAnimated.toggle()
    }

    @objc func hasImagesChanged() {
        self.hasImages.toggle()
    }
}
