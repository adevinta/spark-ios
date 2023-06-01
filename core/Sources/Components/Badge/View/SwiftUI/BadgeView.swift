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
/// Badge view is created by passing:
/// - **Theme**
/// - ``BadgeViewModel``
///
/// **Example**
/// This example shows how to create view with horizontal alignment of Badge
/// ```swift
///    @StateObject var viewModel = BadgeViewModel(
///     theme: SparkTheme.shared,
///     badgeType: .alert,
///     badgeSize: .normal,
///     initValue: 0
///    )
///    @State var value: Int? = 3
///    var body: any View {
///    Button("Change Notifications Number") {
///         viewModel.setBadgeValue(5)
///    }
///    HStack {
///         Text("Some text")
///         BadgeView(viewModel)
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

    public init(viewModel: BadgeViewModel) {
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
}
