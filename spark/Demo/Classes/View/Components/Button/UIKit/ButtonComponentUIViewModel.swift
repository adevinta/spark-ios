//
//  ButtonComponentUIViewModel.swift
//  SparkDemo
//
//  Created by alican.aycil on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class ButtonComponentUIViewModel: ComponentUIViewModel {

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

    var showAlignmentSheet: AnyPublisher<[ButtonAlignment], Never> {
        showAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentNormalSheet: AnyPublisher<[ButtonContentDefault], Never> {
        showContentNormalSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentHighlightedSheet: AnyPublisher<[ButtonContentDefault], Never> {
        showContentHighlightedSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentDisabledSheet: AnyPublisher<[ButtonContentDefault], Never> {
        showContentDisabledSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSelectedSheet: AnyPublisher<[ButtonContentDefault], Never> {
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
    @Published var alignment: ButtonAlignment
    @Published var contentNormal: ButtonContentDefault
    @Published var contentHighlighted: ButtonContentDefault
    @Published var contentDisabled: ButtonContentDefault
    @Published var contentSelected: ButtonContentDefault
    @Published var isEnabled: Bool
    @Published var isSelected: Bool
    @Published var isAnimated: Bool
    @Published var controlType: ButtonControlType
    @Published var isCustomAccessibilityLabel: Bool

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

    lazy var alignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentAlignmentSheet))
        )
    }()

    lazy var contentNormalConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content (normal state)",
            type: .button,
            target: (source: self, action: #selector(self.presentContentNormalSheet))
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

    lazy var isCustomAccessibilityLabelConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "is Custom AccessibilityLabel",
            type: .toggle(isOn: self.isCustomAccessibilityLabel),
            target: (source: self, action: #selector(self.isCustomAccessibilityLabelChanged))
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
            self.alignmentConfigurationItemViewModel,
            self.contentNormalConfigurationItemViewModel,
            self.contentHighlightedConfigurationItemViewModel,
            self.contentDisabledConfigurationItemViewModel,
            self.contentSelectedConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isSelectedConfigurationItemViewModel,
            self.isAnimatedConfigurationItemViewModel,
            self.controlTypeConfigurationItemViewModel,
            self.isCustomAccessibilityLabelConfigurationItemViewModel
        ]
    }

    // MARK: - Private Properties

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ButtonIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ButtonVariant], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[ButtonSize], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[ButtonShape], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[ButtonAlignment], Never> = .init()
    private var showContentNormalSheetSubject: PassthroughSubject<[ButtonContentDefault], Never> = .init()
    private var showContentHighlightedSheetSubject: PassthroughSubject<[ButtonContentDefault], Never> = .init()
    private var showContentDisabledSheetSubject: PassthroughSubject<[ButtonContentDefault], Never> = .init()
    private var showContentSelectedSheetSubject: PassthroughSubject<[ButtonContentDefault], Never> = .init()
    private var showControlTypeSheetSubject: PassthroughSubject<[ButtonControlType], Never> = .init()

    // MARK: - Initialization

    init(
        text: String = "Button",
        iconImageNamed: String = "arrow",
        theme: Theme,
        intent: ButtonIntent = .main,
        variant: ButtonVariant = .filled,
        size: ButtonSize = .medium,
        shape: ButtonShape = .rounded,
        alignment: ButtonAlignment = .leadingImage,
        contentNormal: ButtonContentDefault = .text,
        contentHighlighted: ButtonContentDefault = .text,
        contentDisabled: ButtonContentDefault = .text,
        contentSelected: ButtonContentDefault = .text,
        isEnabled: Bool = true,
        isSelected: Bool = false,
        isAnimated: Bool = true,
        controlType: ButtonControlType = .action,
        isCustomAccessibilityLabel: Bool = false
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
        self.alignment = alignment
        self.contentNormal = contentNormal
        self.contentHighlighted = contentHighlighted
        self.contentDisabled = contentDisabled
        self.contentSelected = contentSelected
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.isAnimated = isAnimated
        self.controlType = controlType
        self.isCustomAccessibilityLabel = isCustomAccessibilityLabel

        super.init(identifier: "Button")
    }
}

// MARK: - Navigation

extension ButtonComponentUIViewModel {

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

    @objc func presentAlignmentSheet() {
        self.showAlignmentSheetSubject.send(ButtonAlignment.allCases)
    }

    @objc func presentContentNormalSheet() {
        self.showContentNormalSheetSubject.send(ButtonContentDefault.allCasesExceptNone)
    }

    @objc func presentContentHighlightedCSheet() {
        self.showContentHighlightedSheetSubject.send(ButtonContentDefault.allCases)
    }

    @objc func presentContentDisabledSheet() {
        self.showContentDisabledSheetSubject.send(ButtonContentDefault.allCases)
    }

    @objc func presentContentSelectedSheet() {
        self.showContentSelectedSheetSubject.send(ButtonContentDefault.allCases)
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

    @objc func isCustomAccessibilityLabelChanged() {
        self.isCustomAccessibilityLabel.toggle()
    }
}
