//
//  BadgeComponentView.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Spark
import SwiftUI

private struct BadgePreviewFormatter: BadgeFormatting {
    func formatText(for value: Int?) -> String {
        guard let value else {
            return "_"
        }
        return "Test \(value)"
    }
}

struct BadgeComponentView: View {

    private var viewModels: [BadgeViewModel] =
    [
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            badgeSize: .normal,
            value: 6
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            badgeSize: .small,
            value: 22,
            format: .overflowCounter(maxValue: 20)
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .danger,
            value: 10,
            format: .custom(
                formatter: BadgePreviewFormatter()
            )
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .info
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .neutral,
            isOutlined: false
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .primary
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .secondary,
            value: 6
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .success
        )
    ]

    @State var theme: Theme = SparkTheme.shared

    @State var standartBadgeValue: Int? = 3
    @State var standartBadgeIsOutlined: Bool = true

    @State var smallCustomBadgeValue: Int? = 14
    @State var smallCustomBadgeSize: BadgeSize = .small
    @State var smallCustomBadgeIsOutlined: Bool = true
    @State var smallCustomBadgeType: BadgeIntentType = .alert
    @State var badgeFormat: BadgeFormat = .default

    @State var standartDangerBadgeType: BadgeIntentType = .danger

    var body: some View {
        List {
            Section(header: Text("UIKit Badge")) {
                Button("Change UIKit Badge 0 Type") {
                    viewModels[0].badgeType = BadgeIntentType.allCases.randomElement() ?? .alert
                }
                Button("Change UIKit Badge 1 Value") {
                    if viewModels[1].value == 10 {
                        viewModels[1].value = nil
                    } else if viewModels[1].value == 22 {
                        viewModels[1].value = 10
                    } else {
                        viewModels[1].value = 22
                    }
                }
                Button("Change UIKit Badge 2 Outline") {
                    viewModels[2].isBadgeOutlined.toggle()
                }
                UIBadgeView(viewModels: viewModels)
                    .frame(height: 400)
            }
            .listRowBackground(Color.gray.opacity(0.3))

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

struct BadgeComponentView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeComponentView()
    }
}
