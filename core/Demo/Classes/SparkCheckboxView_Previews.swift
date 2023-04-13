//
//  SparkCheckboxView_Previews.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct SparkCheckboxView_Previews: PreviewProvider {

    struct ContainerView: View {
        let theming = SparkCheckboxTheming(theme: SparkTheme(), variant: .filled)

        @State private var selection1: SparkCheckboxSelectionState = .selected
        @State private var selection2: SparkCheckboxSelectionState = .unselected
        @State private var selection3: SparkCheckboxSelectionState = .indeterminate

        @State private var items: [any SparkCheckboxGroupItemProtocol] = [
            CheckboxGroupItem(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
            CheckboxGroupItem(title: "Entry 2", id: "2", selectionState: .unselected),
            CheckboxGroupItem(title: "Entry 3", id: "3", selectionState: .unselected)
        ]

        var body: some View {
            VStack(alignment: .leading) {
                Text("Left")
                SparkCheckboxView(
                    text: "Selected checkbox.",
                    theming: theming,
                    selectionState: $selection1,
                    accessibilityIdentifier: "test"
                )
                SparkCheckboxView(
                    text: "Unselected checkbox.",
                    theming: theming,
                    selectionState: $selection2,
                    accessibilityIdentifier: "test"
                )
                SparkCheckboxView(
                    text: "Indeterminate checkbox.",
                    theming: theming,
                    selectionState: $selection3,
                    accessibilityIdentifier: "test"
                )

                Divider()
                Text("Right")
                SparkCheckboxView(
                    text: "Selected checkbox.",
                    checkboxPosition: .right,
                    theming: theming,
                    selectionState: $selection1,
                    accessibilityIdentifier: "test"
                )
                SparkCheckboxView(
                    text: "Unselected checkbox.",
                    checkboxPosition: .right,
                    theming: theming,
                    selectionState: $selection2,
                    accessibilityIdentifier: "test"
                )
                SparkCheckboxView(
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

    static var previews: some View {
        ContainerView()
    }
}
