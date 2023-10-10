//
//  BadgeComponentView.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

// swiftlint:disable no_debugging_method
struct BadgeComponentView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: BadgeIntentType = .danger
    @State private var size: BadgeSize = .medium
    @State private var value: Int = 99
    @State private var format: BadgeFormat = .default
    @State private var isBorderVisible: CheckboxSelectionState = .unselected

    private let numberFormatter = NumberFormatter()

    // MARK: - View

    var body: some View {
        Component(
            name: "Badge",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: BadgeIntentType.allCases,
                    value: self.$intent)

                EnumSelector(
                    title: "Badge Size",
                    dialogTitle: "Select a Size",
                    values: BadgeSize.allCases,
                    value: self.$size)

                EnumSelector(
                    title: "Format",
                    dialogTitle: "Select a Format",
                    values: BadgeFormat.allCases,
                    value: self.$format,
                    nameFormatter: { badgeFormat in
                        return badgeFormat.name
                    }
                )

                HStack() {
                    Text("Value ").bold()
                    TextField(
                        "Value",
                        value: self.$value,
                        formatter: self.numberFormatter
                    )
                }

                CheckboxView(
                    text: "With Border",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isBorderVisible
                )
            },
            integration: {
                BadgeView(
                    theme: self.theme,
                    intent: self.intent,
                    value: self.value
                )
                .size(self.size)
                .format(self.format)
                .borderVisible(self.isBorderVisible == .selected)
            }
        )
    }
}

struct BadgeComponentView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeComponentView()
    }
}

extension BadgeFormat: CaseIterable {
    public static var allCases: [SparkCore.BadgeFormat] {
        [`default`,
         custom(formatter: BadgePreviewFormatter()),
         overflowCounter(maxValue: 99)
        ]
    }
}

extension BadgeFormat: Hashable {
    public static func == (lhs: SparkCore.BadgeFormat, rhs: SparkCore.BadgeFormat) -> Bool {
        switch (lhs, rhs) {
        case (`default`, `default`): return true
        case (custom, custom): return true
        case (overflowCounter, overflowCounter): return true
        default: return false
        }
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
    }
}
