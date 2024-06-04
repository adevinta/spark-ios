//
//  BadgeViewModel.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
import SwiftUI
import SparkTheming

/// **BadgeViewModel** is a view model that is required for
/// configuring ``BadgeView`` and changing it's properties.
///
/// List of properties:
/// - value -- property that represents **Int?** displayed in ``BadgeView``.
/// Set *value* to nil to show empty Badge as circle
///
/// - intent -- changes ``BadgeIntentType``
///
/// - isBorderVisible -- ``Bool``, changes outline of the Badge
///
/// - size -- changes ``BadgeSize`` and text font
///
/// - format -- see ``BadgeFormat`` as a formater of **Badge Text**
///
/// - theme  -- represents ``Theme`` used in the app
final class BadgeViewModel: ObservableObject {

    // MARK: - Badge Configuration Public Properties
    var value: Int? = nil {
        didSet {
            self.updateText()
        }
    }
    var intent: BadgeIntentType {
        didSet {
            self.updateColors()
        }
    }
    var size: BadgeSize {
        didSet {
            self.updateFont()
            self.updateScalings()
        }
    }
    var format: BadgeFormat {
        didSet {
            self.updateText()
        }
    }
    var theme: Theme {
        didSet {
            self.updateColors()
            self.updateFont()
            self.updateScalings()
        }
    }

    // MARK: - Internal Published Properties
    @Published var text: String
    @Published var textFont: TypographyFontToken
    @Published var textColor: any ColorToken
    @Published var isBadgeEmpty: Bool
    @Published var backgroundColor: any ColorToken
    @Published var border: BadgeBorder
    @Published var isBorderVisible: Bool
    @Published var badgeHeight: CGFloat
    @Published var offset: EdgeInsets

    // MARK: - Internal Appearance Properties
    var colorsUseCase: BadgeGetIntentColorsUseCaseable
    var sizeAttributesUseCase: BadgeGetSizeAttributesUseCaseable

    // MARK: - Initializer

    init(theme: Theme,
         intent: BadgeIntentType,
         size: BadgeSize = .medium,
         value: Int? = nil,
         format: BadgeFormat = .default,
         isBorderVisible: Bool = true,
         colorsUseCase: BadgeGetIntentColorsUseCaseable = BadgeGetIntentColorsUseCase(),
         sizeAttributesUseCase: BadgeGetSizeAttributesUseCaseable = BadgeGetSizeAttributesUseCase()
    ) {
        let colors = colorsUseCase.execute(intentType: intent, on: theme.colors)

        self.value = value

        self.text = format.text(value)
        self.isBadgeEmpty = format.text(value).isEmpty
        self.textColor = colors.foregroundColor

        self.backgroundColor = colors.backgroundColor

        self.border = BadgeBorder(
            width: theme.border.width.medium,
            radius: theme.border.radius.full,
            color: colors.borderColor
        )

        self.theme = theme

        self.format = format
        self.size = size
        self.intent = intent
        self.isBorderVisible = isBorderVisible
        self.colorsUseCase = colorsUseCase
        self.sizeAttributesUseCase = sizeAttributesUseCase

        let sizeAttributes = sizeAttributesUseCase.execute(theme: theme, size: size)
        self.textFont = sizeAttributes.font
        self.badgeHeight = sizeAttributes.height
        self.offset = sizeAttributes.offset
    }

    private func updateColors() {
        let colors = self.colorsUseCase.execute(intentType: self.intent, on: self.theme.colors)

        self.textColor = colors.foregroundColor
        self.backgroundColor = colors.backgroundColor
        self.border.setColor(colors.borderColor)
    }

    private func updateText() {
        self.text = self.format.text(self.value)
        self.isBadgeEmpty = self.text.isEmpty
    }

    private func updateFont() {
        let sizeAttributes = self.sizeAttributesUseCase.execute(theme: self.theme, size: self.size)
        self.textFont = sizeAttributes.font
    }

    private func updateScalings() {
        let sizeAttributes = self.sizeAttributesUseCase.execute(theme: self.theme, size: self.size)
        self.offset = sizeAttributes.offset
        self.border.setWidth(self.theme.border.width.medium)
        self.badgeHeight = sizeAttributes.height
    }
}
