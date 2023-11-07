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

    var showContentSheet: AnyPublisher<[ButtonContentDefault], Never> {
        showContentSheetSubject
            .eraseToAnyPublisher()
    }

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var intent: ButtonIntent
    @Published var variant: ButtonVariant
    @Published var size: ButtonSize
    @Published var shape: ButtonShape
    @Published var alignment: ButtonAlignment
    @Published var content: ButtonContentDefault
    @Published var isEnabled: Bool
    @Published var isAnimated: Bool

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

    lazy var contentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content",
            type: .button,
            target: (source: self, action: #selector(self.presentContentSheet))
        )
    }()

    lazy var isEnabledConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Enabled",
            type: .toggle(isOn: self.isEnabled),
            target: (source: self, action: #selector(self.isEnabledChanged))
        )
    }()

    lazy var isAnimatedConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Is Animated",
            type: .toggle(isOn: self.isAnimated),
            target: (source: self, action: #selector(self.isAnimatedChanged))
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
            self.contentConfigurationItemViewModel,
            self.isEnabledConfigurationItemViewModel,
            self.isAnimatedConfigurationItemViewModel
        ]
    }

    // MARK: - Private Properties

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[ButtonIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[ButtonVariant], Never> = .init()
    private var showSizeSheetSubject: PassthroughSubject<[ButtonSize], Never> = .init()
    private var showShapeSheetSubject: PassthroughSubject<[ButtonShape], Never> = .init()
    private var showAlignmentSheetSubject: PassthroughSubject<[ButtonAlignment], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[ButtonContentDefault], Never> = .init()

    // MARK: - Initialization

    init(
        text: String = "Button",
        iconImageNamed: String = "arrow",
        theme: Theme,
        intent: ButtonIntent = .main,
        variant: ButtonVariant = .filled,
        size: ButtonSize = .medium,
        shape: ButtonShape = .rounded,
        alignment: ButtonAlignment = .leadingIcon,
        content: ButtonContentDefault = .text,
        isEnabled: Bool = true,
        isAnimated: Bool = true
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
        self.content = content
        self.isEnabled = isEnabled
        self.isAnimated = isAnimated

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

    @objc func presentContentSheet() {
        self.showContentSheetSubject.send(ButtonContentDefault.allCases)
    }

    @objc func isEnabledChanged() {
        self.isEnabled.toggle()
    }

    @objc func isAnimatedChanged() {
        self.isAnimated.toggle()
    }
}
