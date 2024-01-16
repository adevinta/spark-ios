//
//  IconButtonComponentUIViewModel.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class IconButtonComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Published Properties

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[ButtonIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[ButtonVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showSizeSheet: AnyPublisher<[ButtonSize], Never> {
        showSizeSheetSubject
            .eraseToAnyPublisher()
    }

    var showShapeSheet: AnyPublisher<[ButtonShape], Never> {
        showShapeSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentHighlightedSheet: AnyPublisher<[IconButtonContentDefault], Never> {
        showContentHighlightedSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentDisabledSheet: AnyPublisher<[IconButtonContentDefault], Never> {
        showContentDisabledSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSelectedSheet: AnyPublisher<[IconButtonContentDefault], Never> {
        showContentSelectedSheetSubject
            .eraseToAnyPublisher()
    }

    var showControlType: AnyPublisher<[ButtonControlType], Never> {
        showControlTypeSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var intent: ButtonIntent
    @Published var variant: ButtonVariant
    @Published var size: ButtonSize
    @Published var shape: ButtonShape
    @Published var contentNormal: IconButtonContentDefault
    @Published var contentHighlighted: IconButtonContentDefault
    @Published var contentDisabled: IconButtonContentDefault
    @Published var contentSelected: IconButtonContentDefault
    @Published var isEnabled: Bool
    @Published var isSelected: Bool
    @Published var isAnimated: Bool
    @Published var controlType: ButtonControlType

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

    lazy var sizeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Size",
            type: .button,
            target: (source: self, action: #selector(self.presentSizeSheet))
        )
    }()

    lazy var shapeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Shape",
            type: .button,
            target: (source: self, action: #selector(self.presentShapeSheet))
        )
    }()

    lazy var contentHighlightedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content (highlighted state)",
            type: .button,
            target: (source: self, action: #selector(self.presentContentHighlightedCSheet))
        )
    }()

    lazy var contentDisabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content (disabled state)",
            type: .button,
            target: (source: self, action: #selector(self.presentContentDisabledSheet))
        )
    }()

    lazy var contentSelectedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content (selected state)",
            type: .button,
            target: (source: self, action: #selector(self.presentContentSelectedSheet))
        )
    }()

    lazy var isEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Enabled",
            type: .toggle(isOn: self.isEnabled),
            target: (source: self, action: #selector(self.isEnabledChanged))
        )
    }()

    lazy var isSelectedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Selected",
            type: .toggle(isOn: self.isSelected),
            target: (source: self, action: #selector(self.isSelectedChanged))
        )
    }()

    lazy var isAnimatedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Animated",
            type: .toggle(isOn: self.isAnimated),
            target: (source: self, action: #selector(self.isAnimatedChanged))
        )
    }()

    lazy var controlTypeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Control Type",
            type: .button,
            target: (source: self, action: #selector(self.presentControlTypeSheet))
        )
    }()

    // MARK: - Properties

    let text: String
    let iconImage: UIImage
    let attributedText: NSAttributedString

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.sizeConfigurationItemViewModel,
            self.shapeConfigurationItemViewModel,
            self.contentHighlightedConfigurationItemViewModel,
            self.contentDisabledConfigurationItemViewModel,
            self.contentSelectedConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isSelectedConfigurationItemViewModel,
            self.isAnimatedConfigurationItemViewModel,
            self.controlTypeConfigurationItemViewModel
        ]
    }

    // MARK: - Private Properties

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ButtonIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ButtonVariant], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[ButtonSize], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[ButtonShape], Never> = .init()
    private var showContentHighlightedSheetSubject: PassthroughSubject<[IconButtonContentDefault], Never> = .init()
    private var showContentDisabledSheetSubject: PassthroughSubject<[IconButtonContentDefault], Never> = .init()
    private var showContentSelectedSheetSubject: PassthroughSubject<[IconButtonContentDefault], Never> = .init()
    private var showControlTypeSheetSubject: PassthroughSubject<[ButtonControlType], Never> = .init()

    // MARK: - Initialization

    init(
        text: String = "Icon Button",
        iconImageNamed: String = "arrow",
        theme: Theme,
        intent: ButtonIntent = .main,
        variant: ButtonVariant = .filled,
        size: ButtonSize = .medium,
        shape: ButtonShape = .rounded,
        contentNormal: IconButtonContentDefault = .image,
        contentHighlighted: IconButtonContentDefault = .image,
        contentDisabled: IconButtonContentDefault = .image,
        contentSelected: IconButtonContentDefault = .image,
        isEnabled: Bool = true,
        isSelected: Bool = false,
        isAnimated: Bool = true,
        controlType: ButtonControlType = .action
    ) {
        self.text = text
        self.iconImage = .init(named: iconImageNamed) ?? UIImage()
        self.attributedText = .init(
            string: text,
            attributes: [
                .foregroundColor: UIColor.purple,
                .font: SparkTheme.shared.typography.body2Highlight.uiFont
            ]
        )
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.size = size
        self.shape = shape
        self.contentNormal = contentNormal
        self.contentHighlighted = contentHighlighted
        self.contentDisabled = contentDisabled
        self.contentSelected = contentSelected
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.isAnimated = isAnimated
        self.controlType = controlType

        super.init(identifier: "Button")
    }
}

// MARK: - Navigation

extension IconButtonComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(ButtonIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(ButtonVariant.allCases)
    }

    @objc func presentSizeSheet() {
        self.showSizeSheetSubject.send(ButtonSize.allCases)
    }

    @objc func presentShapeSheet() {
        self.showShapeSheetSubject.send(ButtonShape.allCases)
    }

    @objc func presentContentHighlightedCSheet() {
        self.showContentHighlightedSheetSubject.send(IconButtonContentDefault.allCases)
    }

    @objc func presentContentDisabledSheet() {
        self.showContentDisabledSheetSubject.send(IconButtonContentDefault.allCases)
    }

    @objc func presentContentSelectedSheet() {
        self.showContentSelectedSheetSubject.send(IconButtonContentDefault.allCases)
    }

    @objc func isEnabledChanged() {
        self.isEnabled.toggle()
    }

    @objc func isSelectedChanged() {
        self.isSelected.toggle()
    }

    @objc func isAnimatedChanged() {
        self.isAnimated.toggle()
    }

    @objc func presentControlTypeSheet() {
        self.showControlTypeSheetSubject.send(ButtonControlType.allCases)
    }
}
