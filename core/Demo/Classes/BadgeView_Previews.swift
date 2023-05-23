//
//  BadgeView_Previews.swift
//  SparkCoreDemo
//
//  Created by alex.vecherov on 22.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore

private struct BadgePreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "\(value)€"
    }
}

struct BadgeView_Previews: PreviewProvider {

    struct BadgeContainerView: View {
        
        @StateObject var standartBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            badgeSize: .normal,
            initValue: 6
        )

        @State var smallCustomWithoutBorder = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            badgeSize: .small,
            initValue: 22,
            format: .overflowCounter(maxValue: 20)
        )

        @State var standartDangerBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .danger,
            initValue: 10,
            format: .custom(
                formatter: BadgePreviewFormatter()
            )
        )

        @State var standartInfoBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .info
        )

        @State var standartNeutralBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .neutral,
            isOutlined: false
        )

        @State var standartPrimaryBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .primary
        )

        @State var standartSecondaryBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .secondary
        )

        @State var standartSuccessBadge = BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .success
        )

        @State var value: Int? = 3
        @State var isOutlined: Bool = false
        @ScaledMetric var hOffset: CGFloat
        @ScaledMetric var vOffset: CGFloat

        var body: some View {
            ScrollView {
                Button("Change value") {
                    standartBadge.setBadgeValue(23)
                    smallCustomWithoutBorder.setBadgeValue(18)
                }
                VStack(spacing: 100) {
                    HStack(spacing: 100) {
                        ZStack(alignment: .leading) {
                            Text("Text")
                            BadgeView(viewModel: standartBadge)
                                .offset(x: hOffset, y: -vOffset)
                        }
                        ZStack(alignment: .leading) {
                            Text("Text")
                            BadgeView(viewModel: smallCustomWithoutBorder)
                                .offset(x: hOffset, y: -vOffset)
                        }
                    }

                    HStack(spacing: 100) {
                        ZStack(alignment: .leading) {
                            Text("Text")
                            BadgeView(viewModel: standartDangerBadge)
                                .offset(x: hOffset, y: -vOffset)
                        }
                        ZStack(alignment: .leading) {
                            Text("Text")
                            BadgeView(viewModel: standartInfoBadge)
                                .offset(x: hOffset, y: -vOffset)
                        }
                        ZStack(alignment: .leading) {
                            Text("Text")
                            BadgeView(viewModel: standartNeutralBadge)
                                .offset(x: hOffset, y: -vOffset)
                        }
                    }

                    HStack(spacing: 100) {
                        HStack {
                            Text("Text")
                            BadgeView(viewModel: standartPrimaryBadge)
                        }
                        HStack {
                            Text("Text")
                            BadgeView(viewModel: standartSecondaryBadge)
                        }
                        HStack {
                            Text("Text")
                            BadgeView(viewModel: standartSuccessBadge)
                        }
                    }
                }
                .offset(y: 30)
                .frame(minWidth: 375)
            }
            .background(Color.gray)
        }
    }

    static var previews: some View {
        BadgeContainerView(hOffset: SparkTheme.shared.layout.spacing.xxLarge, vOffset: SparkTheme.shared.layout.spacing.medium * 1.5)
    }
}
