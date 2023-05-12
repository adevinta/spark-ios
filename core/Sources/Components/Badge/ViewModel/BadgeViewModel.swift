//
//  BadgeViewModel.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public enum BadgeSize {
    case normal
    case small
}

public struct BadgeStyle {
    let badgeSize: BadgeSize
    let badgeType: BadgeIntentType
    let badgeColors: BadgeColorables
    let isBadgeOutlined: Bool

    public init(badgeSize: BadgeSize, badgeType: BadgeIntentType, isBadgeOutlined: Bool, theme: Theme) {
        self.badgeSize = badgeSize
        self.badgeType = badgeType
        self.isBadgeOutlined = isBadgeOutlined
        self.badgeColors = BadgeGetColorsUseCase().execute(from: theme, badgeType: badgeType)
    }
}

public class BadgeViewModel {

    private var formatter: BadgeFormatter
    public var badgeText: String {
        switch formatter {
        case .standart:
            return value ?? ""
        case .thousandsCounter:
            if let value, let intValue = Int(value) {
                return "\(Int(intValue / 1000))k"
            } else {
                return value ?? ""
            }
        case .custom(let formatter):
            return formatter.badgeText(value: value)
        }
    }
    private var value: String?
    private(set) var badgeStyle: BadgeStyle
    private var theme: Theme
    public var backgroundColor: UIColor {
        badgeStyle.badgeColors.backgroundColor.uiColor
    }
    public var borderColor: ColorToken {
        badgeStyle.isBadgeOutlined ? badgeStyle.badgeColors.borderColor : ColorTokenDefault.clear
    }
    public var textColor: UIColor {
        badgeStyle.badgeColors.foregroundColor.uiColor
    }
    public var textFont: TypographyFontToken {
        switch badgeStyle.badgeSize {
        case .small:
            return theme.typography.smallHighlight
        case .normal:
            return theme.typography.captionHighlight
        }
    }
    public var verticalOffset: CGFloat {
        theme.layout.spacing.small * 2
    }
    public var horizontalOffset: CGFloat {
        theme.layout.spacing.medium * 2
    }

    public var borderWidth: CGFloat {
        badgeStyle.isBadgeOutlined ? 2 : 0
    }
    public let emptySize: CGSize = .init(width: 12, height: 12)

    public init(formatter: BadgeFormatter, theme: Theme, badgeStyle: BadgeStyle, value: String?) {
        self.formatter = formatter
        self.value = value
        self.badgeStyle = badgeStyle
        self.theme = theme
    }
}
