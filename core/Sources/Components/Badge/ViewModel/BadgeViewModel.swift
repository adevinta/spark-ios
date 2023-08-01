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
            updateText()
        }
    }
    var intent: BadgeIntentType {
        didSet {
            updateColors()
        }
    }
    var size: BadgeSize {
        didSet {
            updateFont()
        }
    }
    var format: BadgeFormat {
        didSet {
            updateText()
        }
    }
    var theme: Theme {
        didSet {
            updateColors()
            updateScalings()
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

    // MARK: - Internal Appearance Properties
    var colorsUseCase: BadgeGetIntentColorsUseCaseable
    var verticalOffset: CGFloat
    var horizontalOffset: CGFloat


    // MARK: - Initializer

    init(theme: Theme, intent: BadgeIntentType, size: BadgeSize = .normal, value: Int? = nil, format: BadgeFormat = .default, isBorderVisible: Bool = true, colorsUseCase: BadgeGetIntentColorsUseCaseable = BadgeGetIntentColorsUseCase()) {
        let colors = colorsUseCase.execute(intentType: intent, on: theme.colors)

        self.value = value

        self.text = format.text(value)
        self.isBadgeEmpty = format.text(value).isEmpty
        switch size {
        case .normal:
            self.textFont = theme.typography.captionHighlight
        case .small:
            self.textFont = theme.typography.smallHighlight
        }
        self.textColor = colors.foregroundColor

        self.backgroundColor = colors.backgroundColor

        let verticalOffset = theme.layout.spacing.small
        let horizontalOffset = theme.layout.spacing.medium

        self.verticalOffset = verticalOffset
        self.horizontalOffset = horizontalOffset

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
    }

    private func updateColors() {
        let colors = self.colorsUseCase.execute(intentType: self.intent, on: self.theme.colors)

        self.textColor = colors.foregroundColor

        self.backgroundColor = colors.backgroundColor

        self.border.setColor(colors.borderColor)
    }

    private func updateText() {
        self.text = self.format.text(self.value)
        self.isBadgeEmpty = self.format.text(value).isEmpty
    }

    private func updateFont() {
        switch size {
        case .normal:
            self.textFont = self.theme.typography.captionHighlight
        case .small:
            self.textFont = self.theme.typography.smallHighlight
        }
    }

    private func updateScalings() {
        let verticalOffset = self.theme.layout.spacing.small
        let horizontalOffset = self.theme.layout.spacing.medium

        self.verticalOffset = verticalOffset
        self.horizontalOffset = horizontalOffset

        self.border.setWidth(self.theme.border.width.medium)
    }
}
