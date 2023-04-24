//
//  SparkCheckboxView_Previews.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct CheckboxView_Previews: PreviewProvider {

    struct ContainerView: View {
        let theming = CheckboxTheming(theme: SparkTheme.shared)

        @State private var selection1: CheckboxSelectionState = .selected
        @State private var selection2: CheckboxSelectionState = .unselected
        @State private var selection3: CheckboxSelectionState = .indeterminate

        var body: some View {
            scrollView
                .environment(\.sizeCategory, .extraSmall)
                .previewDisplayName("Extra small")

            scrollView
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Extra large")
        }

        var scrollView: some View {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Left")
                    CheckboxView(
                        text: "Selected checkbox.",
                        theming: theming,
                        selectionState: $selection1,
                        accessibilityIdentifier: "test"
                    )
                    CheckboxView(
                        text: "Unselected checkbox.",
                        theming: theming,
                        selectionState: $selection2,
                        accessibilityIdentifier: "test"
                    )
                    CheckboxView(
                        text: "Indeterminate checkbox.",
                        theming: theming,
                        selectionState: $selection3,
                        accessibilityIdentifier: "test"
                    )

                    Divider()
                    Text("Right")
                    CheckboxView(
                        text: "Selected checkbox.",
                        checkboxPosition: .right,
                        theming: theming,
                        selectionState: $selection1,
                        accessibilityIdentifier: "test"
                    )
                    CheckboxView(
                        text: "Unselected checkbox.",
                        checkboxPosition: .right,
                        theming: theming,
                        selectionState: $selection2,
                        accessibilityIdentifier: "test"
                    )
                    CheckboxView(
                        text: "Indeterminate checkbox.",
                        checkboxPosition: .right,
                        theming: theming,
                        selectionState: $selection3,
                        accessibilityIdentifier: "test"
                    )
                }
                .padding()
            }
        }
    }

    static var previews: some View {
        ContainerView()
    }
}
