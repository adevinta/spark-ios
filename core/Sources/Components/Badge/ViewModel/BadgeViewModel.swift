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
/// - badgeType -- changes ``BadgeIntentType``
///
/// - isBadgeOutlined -- ``Bool``, changes outline of the Badge
///
/// - badgeSize -- changes ``BadgeSize`` and text font
///
/// - badgeFormat -- see ``BadgeFormat`` as a formater of **Badge Text**
///
/// - theme  -- represents ``Theme`` used in the app
public final class BadgeViewModel: ObservableObject {

    // MARK: - Badge Configuration Public Properties
    public var value: Int? = nil {
        didSet {
            updateText()
        }
    }
    public var badgeType: BadgeIntentType {
        didSet {
            updateColors()
        }
    }
    public var badgeSize: BadgeSize {
        didSet {
            updateFont()
        }
    }
    public var badgeFormat: BadgeFormat {
        didSet {
            updateText()
        }
    }
    public var theme: Theme {
        didSet {
            updateColors()
            updateScalings()
        }
    }

    // MARK: - Internal Published Properties
    @Published var text: String
    @Published var textFont: TypographyFontToken
    @Published var textColor: ColorToken
    @Published var isBadgeEmpty: Bool

    @Published var backgroundColor: ColorToken
    @Published var badgeBorder: BadgeBorder

    @Published var isBadgeOutlined: Bool

    // MARK: - Internal Appearance Properties
    var colorsUseCase: BadgeGetIntentColorsUseCaseable
    var verticalOffset: CGFloat
    var horizontalOffset: CGFloat


    // MARK: - Initializer

    init(theme: Theme, badgeType: BadgeIntentType, badgeSize: BadgeSize = .normal, value: Int? = nil, format: BadgeFormat = .default, isBadgeOutlined: Bool = true, colorsUseCase: BadgeGetIntentColorsUseCaseable = BadgeGetIntentColorsUseCase()) {
        let badgeColors = colorsUseCase.execute(intentType: badgeType, on: theme.colors)

        self.value = value

        self.text = format.badgeText(value)
        self.isBadgeEmpty = format.badgeText(value).isEmpty
        switch badgeSize {
        case .normal:
            self.textFont = theme.typography.captionHighlight
        case .small:
            self.textFont = theme.typography.smallHighlight
        }
        self.textColor = badgeColors.foregroundColor

        self.backgroundColor = badgeColors.backgroundColor

        let verticalOffset = theme.layout.spacing.small
        let horizontalOffset = theme.layout.spacing.medium

        self.verticalOffset = verticalOffset
        self.horizontalOffset = horizontalOffset

        self.badgeBorder = BadgeBorder(
            width: theme.border.width.medium,
            radius: theme.border.radius.full,
            color: badgeColors.borderColor
        )

        self.theme = theme

        self.badgeFormat = format
        self.badgeSize = badgeSize
        self.badgeType = badgeType
        self.isBadgeOutlined = isBadgeOutlined
        self.colorsUseCase = colorsUseCase
    }

    private func updateColors() {
        let badgeColors = self.colorsUseCase.execute(intentType: self.badgeType, on: self.theme.colors)

        self.textColor = badgeColors.foregroundColor

        self.backgroundColor = badgeColors.backgroundColor

        self.badgeBorder.setColor(badgeColors.borderColor)
    }

    private func updateText() {
        self.text = self.badgeFormat.badgeText(self.value)
        self.isBadgeEmpty = self.badgeFormat.badgeText(value).isEmpty
    }

    private func updateFont() {
        switch badgeSize {
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

        self.badgeBorder.setWidth(self.theme.border.width.medium)
    }
}
