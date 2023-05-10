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
    // MARK: - Container

    struct ContainerView: View {
        let theme = SparkTheme.shared

        @State private var selection1: CheckboxSelectionState = .selected
        @State private var selection2: CheckboxSelectionState = .unselected
        @State private var selection3: CheckboxSelectionState = .indeterminate

        // MARK: - Content

        var body: some View {
            self.scrollView
                .environment(\.sizeCategory, .extraSmall)
                .previewDisplayName("Extra small")

            self.scrollView
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewDisplayName("Extra large")
        }

        var scrollView: some View {
            ScrollView {
                VStack(spacing: 0) {
                    Text("Left")
                    CheckboxView(
                        text: "Selected checkbox.",
                        theme: self.theme,
                        selectionState: $selection1
                    )
                    CheckboxView(
                        text: "Unselected checkbox.",
                        theme: self.theme,
                        selectionState: $selection2
                    )
                    CheckboxView(
                        text: "Indeterminate checkbox.",
                        theme: self.theme,
                        selectionState: $selection3
                    )

                    Divider()
                    Text("Right")
                    CheckboxView(
                        text: "Selected checkbox.",
                        checkboxPosition: .right,
                        theme: self.theme,
                        selectionState: $selection1
                    )
                    CheckboxView(
                        text: "Unselected checkbox.",
                        checkboxPosition: .right,
                        theme: self.theme,
                        selectionState: $selection2
                    )
                    CheckboxView(
                        text: "Indeterminate checkbox.",
                        checkboxPosition: .right,
                        theme: self.theme,
                        selectionState: $selection3
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
