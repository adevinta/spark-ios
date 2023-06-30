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

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    private var views = [
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .alert,
            value: 6
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .primary,
            size: .normal,
            value: 22,
            format: .overflowCounter(maxValue: 20)
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .danger,
            value: 10,
            format: .custom(
                formatter: BadgePreviewFormatter()
            )
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .info,
            value: 20
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .primary
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .neutral,
            isBorderVisible: false
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .secondary,
            value: 23
        ),
        BadgeUIView(
            theme: SparkThemePublisher.shared.theme,
            intent: .success
        )
    ]

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
                    views[0].setIntent(BadgeIntentType.allCases.randomElement() ?? .alert)
                }
                Button("Change UIKit Badge 1 Value") {
                    views[1].setValue(2)
                }
                Button("Change UIKit Badge 2 Outline") {
                    views[2].setBorderVisible(false)
                }
                Button("Change UIKit Badge 3 Size") {
                    views[3].setSize(.small)
                }
                UIBadgeView(views: views)
                    .frame(height: 400)
                    .listRowBackground(Color.gray.opacity(0.3))
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
                                intent: .primary,
                                value: standartBadgeValue
                            )
                            .format(badgeFormat)
                            .borderVisible(standartBadgeIsOutlined)
                            .offset(x: 100, y: -15)
                        }
                        ZStack(alignment: .leading) {
                            Text("Small Custom")
                            BadgeView(
                                theme: SparkTheme.shared,
                                intent: smallCustomBadgeType,
                                value: 22
                            )
                            .borderVisible(smallCustomBadgeIsOutlined)
                            .size(smallCustomBadgeSize)
                            .offset(x: 100, y: -15)
                        }
                    }

                    HStack(spacing: 55) {
                        ZStack(alignment: .leading) {
                            Text("Danger Badge")
                            BadgeView(
                                theme: self.theme,
                                intent: standartDangerBadgeType,
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
                                theme: self.theme,
                                intent: .info
                            )
                                .offset(x: 25, y: -15)
                        }
                        ZStack(alignment: .leading) {
                            Text("Text")
                            BadgeView(
                                theme: self.theme,
                                intent: .neutral
                            )
                                .offset(x: 25, y: -15)
                        }
                    }

                    HStack(spacing: 50) {
                        HStack {
                            Text("Text")
                            BadgeView(
                                theme: self.theme,
                                intent: .primary
                            )
                        }
                        HStack {
                            Text("Text")
                            BadgeView(
                                theme: self.theme,
                                intent: .secondary
                            )
                        }
                        HStack {
                            Text("Text")
                            BadgeView(
                                theme: self.theme,
                                intent: .success
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
