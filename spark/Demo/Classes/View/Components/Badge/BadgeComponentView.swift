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
            initValue: 6
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .alert,
            badgeSize: .small,
            initValue: 22,
            format: .overflowCounter(maxValue: 20)
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .danger,
            initValue: 10,
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
            initValue: 6
        ),
        BadgeViewModel(
            theme: SparkTheme.shared,
            badgeType: .success
        )
    ]

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
        format: .overflowCounter(maxValue: 20),
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
                    standartBadge.value = 23
                }
                Button("Change Small Custom Badge") {
                    smallCustomWithoutBorder.value = 18
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

struct BadgeComponentView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeComponentView()
    }
}
