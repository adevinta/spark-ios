//
//  BadgeView.swift
//  SparkCore
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// This is SwiftUI badge view to show notifications count
///
/// Badge border and offsets of it's text are **@ScaledMetric** variables and alligned to user's **Accessibility**
/// 
/// **Example**
/// This example shows how to create view with horizontal alignment of Badge
/// ```swift
///    @State var value: Int? = 3
///    var body: any View {
///    HStack {
///         Text("Some text")
///         BadgeView(theme: YourTheme.shared, badgeType: .alert, value: value)
///    }
///    }
/// ```
public struct BadgeView: View {
    @ObservedObject private var viewModel: BadgeViewModel
    @ScaledMetric private var smallOffset: CGFloat
    @ScaledMetric private var mediumOffset: CGFloat
    @ScaledMetric private var emptySize: CGFloat
    @ScaledMetric private var borderWidth: CGFloat

    public var body: some View {
        if self.viewModel.isBadgeEmpty {
            Circle()
                .foregroundColor(self.viewModel.backgroundColor.color)
                .frame(width: self.emptySize, height: self.emptySize)
                .border(
                    width: self.viewModel.isBadgeOutlined ? borderWidth : 0,
                    radius: self.viewModel.badgeBorder.radius,
                    colorToken: self.viewModel.badgeBorder.color
                )
                .fixedSize()
        } else {
            Text(self.viewModel.text)
                .font(self.viewModel.textFont.font)
                .foregroundColor(self.viewModel.textColor.color)
                .padding(.init(vertical: self.smallOffset, horizontal: self.mediumOffset))
                .background(self.viewModel.backgroundColor.color)
                .border(
                    width: self.viewModel.isBadgeOutlined ? borderWidth : 0,
                    radius: self.viewModel.badgeBorder.radius,
                    colorToken: self.viewModel.badgeBorder.color
                )
                .fixedSize()
                .accessibilityIdentifier(BadgeAccessibilityIdentifier.text)
        }
    }

    /// - Parameter theme: ``Theme``
    /// - Parameter badgeType: ``BadgeIntentType``
    /// - Parameter value: **Int?** You can set value to nil, to make ``BadgeView`` without text
    public init(theme: Theme, badgeType: BadgeIntentType, value: Int? = nil) {
        let viewModel = BadgeViewModel(theme: theme, badgeType: badgeType, value: value)
        self.viewModel = viewModel

        self._smallOffset =
            .init(wrappedValue:
                    viewModel.verticalOffset
            )
        self._mediumOffset =
            .init(wrappedValue:
                    viewModel.horizontalOffset
            )
        self._emptySize = .init(wrappedValue: BadgeConstants.emptySize.width)
        self._borderWidth = .init(wrappedValue: viewModel.badgeBorder.width)
    }

    // MARK: - Badge Modification Functions

    /// Controlls outline state of the Badge.
    /// By default Badge has an outline based on current ``Theme``.
    ///
    /// Use @State variable to control outline based on this variable.
    public func outlined(_ isOutlined: Bool) -> Self {
        self.viewModel.isBadgeOutlined = isOutlined
        return self
    }

    /// Controlls text size of the Badge. By ``BadgeSize`` is *.normal*.
    ///
    /// Text font size is based on ``BadgeSize`` value and current ``Theme``.
    /// Use @State variable to control ``BadgeSize`` based on this variable.
    public func size(_ badgeSize: BadgeSize) -> Self {
        self.viewModel.badgeSize = badgeSize
        return self
    }

    /// Controlls text format of the Badge. See more details in ``BadgeFormat``.
    ///
    /// Use @State variable to control ``BadgeFormat`` based on this variable.
    public func format(_ badgeFormat: BadgeFormat) -> Self {
        self.viewModel.badgeFormat = badgeFormat
        return self
    }

    /// Controlls spark theme of the Badge. See more details in ``Theme``.
    ///
    /// Use @State variable to control ``Theme`` based on this variable.
    public func theme(_ theme: Theme) -> Self {
        self.viewModel.theme = theme
        return self
    }

    /// Controlls badge intent type. See more details in ``BadgeIntentType``
    ///
    /// Use @State variable to control ``BadgeIntentType`` based on this variable.
    public func value(_ value: Int?) -> Self {
        self.viewModel.value = value
        return self
    }
}
