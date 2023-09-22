//
//  SparkCheckboxView_Previews.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

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
                let checkedImage = UIImage(systemName: "checkmark")!.withRenderingMode(.alwaysTemplate)

                VStack(spacing: 0) {
                    Text("Left")
                    CheckboxView(
                        text: "Selected checkbox.",
                        checkedImage: checkedImage,
                        theme: self.theme,
                        selectionState: $selection1
                    )
                    CheckboxView(
                        text: "Unselected checkbox.",
                        checkedImage: checkedImage,
                        theme: self.theme,
                        selectionState: $selection2
                    )
                    CheckboxView(
                        text: "Indeterminate checkbox.",
                        checkedImage: checkedImage,
                        theme: self.theme,
                        selectionState: $selection3
                    )

                    Divider()
                    Text("Right")
                    CheckboxView(
                        text: "Selected checkbox.",
                        checkedImage: checkedImage,
                        checkboxAlignment: .right,
                        theme: self.theme,
                        selectionState: $selection1
                    )
                    CheckboxView(
                        text: "Unselected checkbox.",
                        checkedImage: checkedImage,
                        checkboxAlignment: .right,
                        theme: self.theme,
                        selectionState: $selection2
                    )
                    CheckboxView(
                        text: "Indeterminate checkbox.",
                        checkedImage: checkedImage,
                        checkboxAlignment: .right,
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
