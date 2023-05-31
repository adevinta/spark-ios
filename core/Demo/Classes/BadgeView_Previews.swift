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
        
        @State var standartBadge = BadgeViewModel(
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
            format: .overflowCounter(maxValue: 10),
            isOutlined: false
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
            List {
                Section(header: Text("SwiftUI Badge")) {
                    Button("Change Default Badge Value") {
                        standartBadge.setBadgeValue(23)
                    }
                    Button("Change Small Custom Badge") {
                        smallCustomWithoutBorder.setBadgeValue(18)
                        smallCustomWithoutBorder.isBadgeOutlined = true
                        smallCustomWithoutBorder.badgeType = .primary
                        smallCustomWithoutBorder.badgeSize = .normal
                    }
                    Button("Change Dange Badge") {
                        standartDangerBadge.badgeType = .neutral
                    }
                    VStack(spacing: 100) {
                        HStack(spacing: 50) {
                            ZStack(alignment: .leading) {
                                Text("Default Badge")
                                BadgeView(viewModel: standartBadge)
                                    .offset(x: 100, y: -15)
                            }
                            ZStack(alignment: .leading) {
                                Text("Small Custom")
                                BadgeView(viewModel: smallCustomWithoutBorder)
                                    .offset(x: 100, y: -15)
                            }
                        }

                        HStack(spacing: 55) {
                            ZStack(alignment: .leading) {
                                Text("Danger Badge")
                                BadgeView(viewModel: standartDangerBadge)
                                    .offset(x: 100, y: -15)
                            }
                            ZStack(alignment: .leading) {
                                Text("Text")
                                BadgeView(viewModel: standartInfoBadge)
                                    .offset(x: 25, y: -15)
                            }
                            ZStack(alignment: .leading) {
                                Text("Text")
                                BadgeView(viewModel: standartNeutralBadge)
                                    .offset(x: 25, y: -15)
                            }
                        }

                        HStack(spacing: 50) {
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
                    .padding(.vertical, 15)
                    .listRowBackground(Color.gray.opacity(0.3))
                }
            }
        }
    }

    static var previews: some View {
        BadgeContainerView(hOffset: SparkTheme.shared.layout.spacing.xxLarge, vOffset: SparkTheme.shared.layout.spacing.medium * 1.5)
    }
}
