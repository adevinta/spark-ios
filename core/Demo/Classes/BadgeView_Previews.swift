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

        @State var theme: Theme = SparkTheme.shared

        @State var standartBadgeValue: Int? = 3
        @State var standartBadgeIsOutlined: Bool = true

        @State var smallCustomBadgeValue: Int? = 14
        @State var smallCustomBadgeSize: BadgeSize = .small
        @State var smallCustomBadgeIsOutlined: Bool = true
        @State var smallCustomBadgeType: BadgeIntentType = .alert
        @State var badgeFormat: BadgeFormat = .default

        @State var standartDangerBadgeType: BadgeIntentType = .danger

        @ScaledMetric var hOffset: CGFloat
        @ScaledMetric var vOffset: CGFloat

        var body: some View {
            List {
                Section(header: Text("SwiftUI Badge")) {
                    Button("Change Default Badge Value") {
                        standartBadgeValue = 23
                        standartBadgeIsOutlined.toggle()
                        badgeFormat = .overflowCounter(maxValue: 20)
                    }
                    Button("Change Small Custom Badge") {
                        smallCustomBadgeValue = 18
                        smallCustomBadgeSize = .normal
                        smallCustomBadgeIsOutlined.toggle()
                        smallCustomBadgeType = .primary
                    }
                    Button("Change Dange Badge") {
                        standartDangerBadgeType = .neutral
                    }
                    VStack(spacing: 100) {
                        HStack(spacing: 50) {
                            ZStack(alignment: .leading) {
                                Text("Default Badge")
                                BadgeView(
                                    theme: theme,
                                    badgeType: .primary,
                                    value: standartBadgeValue
                                )
                                .format(badgeFormat)
                                .outlined(standartBadgeIsOutlined)
                                .offset(x: 100, y: -15)
                            }
                            ZStack(alignment: .leading) {
                                Text("Small Custom")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: smallCustomBadgeType,
                                    value: 22
                                )
                                .outlined(smallCustomBadgeIsOutlined)
                                .size(smallCustomBadgeSize)
                                .offset(x: 100, y: -15)
                            }
                        }

                        HStack(spacing: 55) {
                            ZStack(alignment: .leading) {
                                Text("Danger Badge")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: standartDangerBadgeType,
                                    value: 10
                                )
                                .format(.custom(
                                    formatter: BadgePreviewFormatter()
                                ))
                                    .offset(x: 100, y: -15)
                            }
                            ZStack(alignment: .leading) {
                                Text("Text")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: .info
                                )
                                    .offset(x: 25, y: -15)
                            }
                            ZStack(alignment: .leading) {
                                Text("Text")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: .neutral
                                )
                                    .offset(x: 25, y: -15)
                            }
                        }

                        HStack(spacing: 50) {
                            HStack {
                                Text("Text")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: .primary
                                )
                            }
                            HStack {
                                Text("Text")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: .secondary
                                )
                            }
                            HStack {
                                Text("Text")
                                BadgeView(
                                    theme: SparkTheme.shared,
                                    badgeType: .success
                                )
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
