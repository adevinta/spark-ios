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
/// **Initializer**
/// - A theme -- app theme
/// - Badge type -- intent type of Badge see ``BadgeIntentType``
/// - Badge size -- see ``BadgeSize``
/// - Initial value -- Value that should be set on view creation
/// - Formatter -- see ``BadgeFormat``
/// - isOutlined -- property to show or hide border 
///
/// List of properties:
/// - value -- property that represents **Int** displayed in ``BadgeView``
/// - text -- property that represents text in ``BadgeView``. Appearance of it
/// is configured via ``BadgeFormat`` and based on **value** property.
/// - textColor -- property for coloring text
/// - backgroundColor -- changes color of ``BadgeView`` and based on ``BadgeIntentType``
/// - verticalOffset & horizontalOffset -- are offsets of **text** inside of ``BadgeView``
/// - badgeBorder -- is property that helps you to configure ``BadgeView`` with
/// border radius, width and color. See ``BadgeBorder``
/// - theme  is representer of **Theme** used in the app
/// - badgeFormat -- see ``BadgeFormat`` as a formatter of **text**
public final class BadgeViewModel: ObservableObject {

    @Published private var value: Int? = nil

    // MARK: - Text Properties
    public var text: String
    var textFont: TypographyFontToken
    var textColor: ColorToken

    // MARK: - Appearance Public Properties
    @Published public var badgeSize: BadgeSize {
        didSet {
            guard oldValue != badgeSize else {
                return
            }

            reloadSize()
        }
    }
    @Published public var badgeType: BadgeIntentType {
        didSet {
            guard oldValue != badgeType else {
                return
            }

            reloadColors()
        }
    }
    @Published public var isBadgeOutlined: Bool

    // MARK: - Appearance Internal Properties
    var backgroundColor: ColorToken
    var badgeBorder: BadgeBorder
    var theme: Theme

    var verticalOffset: CGFloat
    var horizontalOffset: CGFloat

    // MARK: - Appearance Private Properties
    private var badgeFormat: BadgeFormat

    // MARK: - Initializer

    public init(theme: Theme, badgeType: BadgeIntentType, badgeSize: BadgeSize = .normal, initValue: Int? = nil, format: BadgeFormat = .default, isOutlined: Bool = true) {
        let badgeColors = BadgeGetIntentColorsUseCase().execute(intentType: badgeType, on: theme.colors)

        self.value = initValue
        self.text = format.badgeText(initValue)
        self.textFont = badgeSize == .normal ? theme.typography.captionHighlight : theme.typography.smallHighlight
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

    // MARK: - Badge update functions

    public func setBadgeValue(_ value: Int?) {
        self.value = value
        self.text = badgeFormat.badgeText(value)
    }

    private func reloadSize() {
        self.textFont = self.badgeSize == .normal ? self.theme.typography.captionHighlight : self.theme.typography.smallHighlight
    }

    private func reloadColors() {
        let badgeColors = BadgeGetIntentColorsUseCase().execute(intentType: badgeType, on: theme.colors)

        self.textColor = badgeColors.foregroundColor

        self.backgroundColor = badgeColors.backgroundColor

        self.badgeBorder.setColor(badgeColors.borderColor)
    }
}
