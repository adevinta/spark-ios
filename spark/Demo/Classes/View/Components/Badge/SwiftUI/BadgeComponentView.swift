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

struct BadgeComponentView: View {
    @State var theme: Theme = SparkThemePublisher.shared.theme
    @State var intent: BadgeIntentType = .danger
    @State var size: BadgeSize = .medium
    @State var value: Int? = 99
    @State var format: BadgeFormat = .default
    @State var isBorderVisible: CheckboxSelectionState = .unselected

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Configuration")
                .font(.title2)
                .bold()
                .padding(.bottom, 6)

            VStack(alignment: .leading, spacing: 8) {
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
                    TextField("Value", value: self.$value, formatter: NumberFormatter())
                }

                CheckboxView(
                    text: "With Border",
                    checkedImage: DemoIconography.shared.checkmark,
                    theme: theme,
                    state: .enabled,
                    selectionState: self.$isBorderVisible
                )
            }

            Divider()

            Text("Integration")
                .font(.title2)
                .bold()

            BadgeView(theme: self.theme, intent: self.intent, value: self.value)
                .size(self.size)
                .format(self.format)
                .borderVisible(self.isBorderVisible == .selected)

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarTitle(Text("Badge"))
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
