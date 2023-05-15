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

public class BadgeViewModel: ObservableObject {
    
    @Published private var value: Int? = nil

    @Published var text: String
    @Published var textFont: TypographyFontToken
    @Published var textColor: ColorToken

    @Published var backgroundColor: ColorToken

    @Published var verticalOffset: CGFloat
    @Published var horizontalOffset: CGFloat

    @Published var badgeBorder: BadgeBorder

    @Published var theme: Theme
    @Published private(set) var badgeFormat: BadgeFormat

    let emptySize: CGSize = .init(width: 12, height: 12)

    // MARK: - Initializer

    public init(theme: Theme, badgeType: BadgeIntentType, badgeSize: BadgeSize = .normal, initValue: Int? = nil, format: BadgeFormat = .standart, isOutlined: Bool = true) {
        let badgeColors = BadgeGetIntentColorsUseCase().execute(intentType: badgeType, on: theme.colors)

        value = initValue
        text = format.badgeText(initValue)
        textFont = badgeSize == .normal ? theme.typography.captionHighlight : theme.typography.smallHighlight
        textColor = badgeColors.foregroundColor

        backgroundColor = badgeColors.backgroundColor

        verticalOffset = theme.layout.spacing.small * 2
        horizontalOffset = theme.layout.spacing.medium * 2

        badgeBorder = BadgeBorder(
            width: isOutlined ?
                theme.border.width.medium :
                theme.border.width.none,
            radius: theme.border.radius.full,
            color: badgeColors.borderColor
        )

        self.theme = theme
        badgeFormat = .standart
    }

    // MARK: - Update configuration function

    public func setBadgeValue(_ value: Int?) {
        self.value = value
        self.text = badgeFormat.badgeText(value)
    }
}
