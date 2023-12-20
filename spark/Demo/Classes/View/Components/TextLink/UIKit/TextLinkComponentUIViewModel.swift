//
//  TextLinkComponentUIViewModel.swift
//  Spark
//
//  Created by robin.lemaire on 07/12/2023.
//  Copyright (c) 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import UIKit

final class TextLinkComponentUIViewModel: ComponentUIViewModel {

    // MARK: - Type Alias

    private typealias Constants = TextLinkConstants

    // MARK: - Published Properties

    var showThemeSheet: AnyPublisher<[ThemeCellModel], Never> {
        showThemeSheetSubject
            .eraseToAnyPublisher()
    }

    var showTextColorTokenSheet: AnyPublisher<[TextLinkColorToken], Never> {
        showTextColorTokenSheetSubject
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
    private var showTextColorTokenSheetSubject: PassthroughSubject<[TextLinkColorToken], Never> = .init()
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

    lazy var textColorTokenConfigurationItemViewModel: ComponentsConfigurationItemUIViewModel = {
        return .init(
            name: "TextColorToken",
            type: .button,
            target: (source: self, action: #selector(self.presentTextColorTokenSheet))
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

    // MARK: - Methods

    override func configurationItemsViewModel() -> [ComponentsConfigurationItemUIViewModel] {
        return  [
            self.themeConfigurationItemViewModel,
            self.textColorTokenConfigurationItemViewModel,
            self.variantConfigurationItemViewModel,
            self.typographyConfigurationItemViewModel,
            self.contentConfigurationItemViewModel,
            self.contentAlignmentConfigurationItemViewModel,
            self.textAlignmentConfigurationItemViewModel,
            self.lineBreakModeConfigurationItemViewModel,
            self.isLineLimitConfigurationItemViewModel,
            self.controlTypeConfigurationItemViewModel
        ]
    }

    // MARK: - Default Value Properties

    let themes = ThemeCellModel.themes

    @Published var theme: Theme
    @Published var textColorToken: TextLinkColorToken
    @Published var variant: TextLinkVariant
    @Published var typography: TextLinkTypography
    @Published var content: TextLinkContent
    @Published var contentAlignment: TextLinkAlignment
    @Published var textAlignment: NSTextAlignment
    @Published var lineBreakMode: NSLineBreakMode
    @Published var isLineLimit: Bool
    @Published var controlType: TextLinkControlType

    // MARK: - Initialization

    init(
        theme: Theme,
        textColorToken: TextLinkColorToken = .main,
        variant: TextLinkVariant = .underline,
        typography: TextLinkTypography = .body1,
        content: TextLinkContent = .imageAndText,
        contentAlignment: TextLinkAlignment = .leadingImage,
        textAlignment: NSTextAlignment = .natural,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        isLineLimit: Bool = false,
        controlType: TextLinkControlType = .action
    ) {
        self.theme = theme
        self.textColorToken = textColorToken
        self.variant = variant
        self.typography = typography
        self.content = content
        self.contentAlignment = contentAlignment
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.isLineLimit = isLineLimit
        self.controlType = controlType

        super.init(identifier: "TextLink")
    }
}

// MARK: - Navigation

extension TextLinkComponentUIViewModel {

    @objc func presentThemeSheet() {
        self.showThemeSheetSubject.send(self.themes)
    }

    @objc func presentTextColorTokenSheet() {
        self.showTextColorTokenSheetSubject.send(TextLinkColorToken.allCases)
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
