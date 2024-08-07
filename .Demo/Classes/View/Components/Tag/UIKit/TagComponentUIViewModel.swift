//
//  TagComponentUIViewModel.swift
//  Spark
//
//  Created by alican.aycil on 01.09.23.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import SparkCore
import UIKit

final class TagComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties
    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[TagIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[TagVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSheet: AnyPublisher<[TagContent], Never> {
        showContentSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties
    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TagIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[TagVariant], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[TagContent], Never> = .init()

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

    lazy var contentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content",
            type: .button,
            target: (source: self, action: #selector(self.presentContentSheet))
        )
    }()

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.contentConfigurationItemViewModel
        ]
    }

    // MARK: - Inherited Properties

    var themes = ThemeCellModel.themes

    // MARK: - Default Value Properties
    let image: UIImage = UIImage(named: "alert") ?? UIImage()

    func attributeText(_ text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        let range = NSRange(location: text.count / 3, length: text.count / 3)

        attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 14), range: range)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        return attributeString
    }

    // MARK: - Initialization
    @Published var theme: Theme
    @Published var intent: TagIntent
    @Published var variant: TagVariant
    @Published var content: TagContent

    init(
        theme: Theme,
        intent: TagIntent = .main,
        variant: TagVariant = .filled,
        content: TagContent = .iconAndText
    ) {
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.content = content

        super.init(identifier: "Tag")
    }
}

// MARK: - Navigation
extension TagComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(TagIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(TagVariant.allCases)
    }

    @objc func presentContentSheet() {
        self.showContentSheetSubject.send(TagContent.allCases)
    }
}
