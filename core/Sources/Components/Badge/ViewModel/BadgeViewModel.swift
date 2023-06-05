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

    // MARK: - Appearance Internal Properties
    @Published public var value: Int? = nil
    @Published public var badgeType: BadgeIntentType
    @Published public var isBadgeOutlined: Bool
    @Published public var badgeSize: BadgeSize
    @Published public var badgeFormat: BadgeFormat
    @Published public var theme: Theme

    var backgroundColor: ColorToken
    var badgeBorder: BadgeBorder
    var isBadgeEmpty: Bool {
        self.badgeFormat.badgeText(value).isEmpty
    }
    var verticalOffset: CGFloat
    var horizontalOffset: CGFloat

    // MARK: - Internal Text Properties
    var text: String {
        badgeFormat.badgeText(value)
    }
    var textFont: TypographyFontToken {
        badgeSize.fontSize(for: self.theme)
    }
    var textColor: ColorToken

    // MARK: - Initializer

    public init(theme: Theme, badgeType: BadgeIntentType, badgeSize: BadgeSize = .normal, value: Int? = nil, format: BadgeFormat = .default, isOutlined: Bool = true) {
        let badgeColors = BadgeGetIntentColorsUseCase().execute(intentType: badgeType, on: theme.colors)

        self.value = value
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
        self.isBadgeOutlined = isOutlined
    }

    func updateColors() {
        let badgeColors = BadgeGetIntentColorsUseCase().execute(intentType: self.badgeType, on: self.theme.colors)

        self.textColor = badgeColors.foregroundColor

        self.backgroundColor = badgeColors.backgroundColor

        self.badgeBorder.setColor(badgeColors.borderColor)
    }

    func updateScalings() {
        let verticalOffset = self.theme.layout.spacing.small
        let horizontalOffset = self.theme.layout.spacing.medium

        self.verticalOffset = verticalOffset
        self.horizontalOffset = horizontalOffset

        self.badgeBorder.setWidth(self.theme.border.width.medium)
    }
}
