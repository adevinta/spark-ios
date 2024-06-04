//
//  TextLinkComponentUIViewModel.swift
//  Spark
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
@_spi(SI_SPI) import SparkCommon
import Spark
import UIKit

final class TextLinkComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Type Alias

    private typealias Constants = TextLinkConstants

    // MARK: - Published Properties

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showIntentSheet: AnyPublisher<[TextLinkIntent], Never> {
        showIntentSheetSubject
            .eraseToAnyPublisher()
    }

    var showTypographySheet: AnyPublisher<[TextLinkTypography], Never> {
        showTypographySheetSubject
            .eraseToAnyPublisher()
    }

    var showVariantSheet: AnyPublisher<[TextLinkVariant], Never> {
        showVariantSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentSheet: AnyPublisher<[TextLinkContent], Never> {
        showContentSheetSubject
            .eraseToAnyPublisher()
    }

    var showContentAlignmentSheet: AnyPublisher<[TextLinkAlignment], Never> {
        showContentAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    var showTextAlignmentSheet: AnyPublisher<[NSTextAlignment], Never> {
        showTextAlignmentSheetSubject
            .eraseToAnyPublisher()
    }

    var showLineBreakModeSheet: AnyPublisher<[NSLineBreakMode], Never> {
        showLineBreakModeSheetSubject
            .eraseToAnyPublisher()
    }

    var showControlType: AnyPublisher<[TextLinkControlType], Never> {
        showControlTypeSheetSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private var showThemeSheetSubject: PassthroughSubject<[ThemeCellModel], Never> = .init()
    private var showIntentSheetSubject: PassthroughSubject<[TextLinkIntent], Never> = .init()
    private var showVariantSheetSubject: PassthroughSubject<[TextLinkVariant], Never> = .init()
    private var showTypographySheetSubject: PassthroughSubject<[TextLinkTypography], Never> = .init()
    private var showContentSheetSubject: PassthroughSubject<[TextLinkContent], Never> = .init()
    private var showContentAlignmentSheetSubject: PassthroughSubject<[TextLinkAlignment], Never> = .init()
    private var showTextAlignmentSheetSubject: PassthroughSubject<[NSTextAlignment], Never> = .init()
    private var showLineBreakModeSheetSubject: PassthroughSubject<[NSLineBreakMode], Never> = .init()
    private var showControlTypeSheetSubject: PassthroughSubject<[TextLinkControlType], Never> = .init()

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

    lazy var typographyConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Typography",
            type: .button,
            target: (source: self, action: #selector(self.presentTypographySheet))
        )
    }()

    lazy var contentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content",
            type: .button,
            target: (source: self, action: #selector(self.presentContentSheet))
        )
    }()

    lazy var contentAlignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Content Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentContentAlignmentSheet))
        )
    }()

    lazy var textAlignmentConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Text Alignment",
            type: .button,
            target: (source: self, action: #selector(self.presentTextAlignmentSheet))
        )
    }()

    lazy var lineBreakModeConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "Line Break Mode",
            type: .button,
            target: (source: self, action: #selector(self.presentLineBreakModeSheet))
        )
    }()

    lazy var isLineLimitConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "With Line limit",
            type: .toggle(isOn: self.isLineLimit),
            target: (source: self, action: #selector(self.isLineLimitOnChanged))
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

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return  [
            self.themeConfigurationItemViewModel,
            self.intentConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.typographyConfigurationItemViewModel,
            self.contentConfigurationItemViewModel,
            self.contentAlignmentConfigurationItemViewModel,
            self.textAlignmentConfigurationItemViewModel,
            self.lineBreakModeConfigurationItemViewModel,
            self.isLineLimitConfigurationItemViewModel,
            self.controlTypeConfigurationItemViewModel,
            self.isCustomAccessibilityLabelConfigurationItemViewModel
        ]
    }

    // MARK: - Default Value Properties

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var intent: TextLinkIntent
    @Published var variant: TextLinkVariant
    @Published var typography: TextLinkTypography
    @Published var content: TextLinkContent
    @Published var contentAlignment: TextLinkAlignment
    @Published var textAlignment: NSTextAlignment
    @Published var lineBreakMode: NSLineBreakMode
    @Published var isLineLimit: Bool
    @Published var controlType: TextLinkControlType
    @Published var isCustomAccessibilityLabel: Bool

    // MARK: - Initialization

    init(
        theme: Theme,
        intent: TextLinkIntent = .basic,
        variant: TextLinkVariant = .underline,
        typography: TextLinkTypography = .body1,
        content: TextLinkContent = .text,
        contentAlignment: TextLinkAlignment = .leadingImage,
        textAlignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        isLineLimit: Bool = false,
        controlType: TextLinkControlType = .action,
        isCustomAccessibilityLabel: Bool = false
    ) {
        self.theme = theme
        self.intent = intent
        self.variant = variant
        self.typography = typography
        self.content = content
        self.contentAlignment = contentAlignment
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.isLineLimit = isLineLimit
        self.controlType = controlType
        self.isCustomAccessibilityLabel = isCustomAccessibilityLabel

        super.init(identifier: "TextLink")
    }
}

// MARK: - Navigation

extension TextLinkComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentIntentSheet() {
        self.showIntentSheetSubject.send(TextLinkIntent.allCases)
    }

    @objc func presentVariantSheet() {
        self.showVariantSheetSubject.send(TextLinkVariant.allCases)
    }

    @objc func presentTypographySheet() {
        self.showTypographySheetSubject.send(TextLinkTypography.allCases)
    }

    @objc func presentContentSheet() {
        self.showContentSheetSubject.send(TextLinkContent.allCases)
    }

    @objc func presentContentAlignmentSheet() {
        self.showContentAlignmentSheetSubject.send(TextLinkAlignment.allCases)
    }

    @objc func presentTextAlignmentSheet() {
        self.showTextAlignmentSheetSubject.send(NSTextAlignment.allCases)
    }

    @objc func presentLineBreakModeSheet() {
        self.showLineBreakModeSheetSubject.send(NSLineBreakMode.allCases)
    }

    @objc func isLineLimitOnChanged() {
        self.isLineLimit.toggle()
    }

    @objc func presentControlTypeSheet() {
        self.showControlTypeSheetSubject.send(TextLinkControlType.allCases)
    }

    @objc func isCustomAccessibilityLabelChanged() {
        self.isCustomAccessibilityLabel.toggle()
    }
}

// MARK: - NSLineBreakMode

extension NSTextAlignment {

    static var allCases: [Self] {
        return [
            .left,
            .center,
            .right,
            .natural
        ]
    }

    var name: String {
        switch self {
        case .left:
            return "Left"
        case .center:
            return "Center"
        case .right:
            return "Right"
        case .natural:
            return "Natural"
        default:
            return ""
        }
    }
}

// MARK: - NSLineBreakMode

extension NSLineBreakMode {

    static var allCases: [Self] {
        return [
            .byWordWrapping,
            .byTruncatingHead,
            .byTruncatingMiddle,
            .byTruncatingTail,
        ]
    }

    var name: String {
        switch self {
        case .byWordWrapping:
            return "By Word Wrapping"
        case .byTruncatingHead:
            return "By Truncating Head"
        case .byTruncatingMiddle:
            return "By Truncating Middle"
        case .byTruncatingTail:
            return "By Truncating Tail"
        default:
            return ""
        }
    }
}
