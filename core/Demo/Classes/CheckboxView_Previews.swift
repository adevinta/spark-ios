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

        @State private var items: [any CheckboxGroupItemProtocol] = [
            CheckboxGroupItem(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
            CheckboxGroupItem(title: "Entry 2", id: "2", selectionState: .unselected),
            CheckboxGroupItem(title: "Entry 3", id: "3", selectionState: .unselected)
        ]

        var body: some View {
            VStack(alignment: .leading) {
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

    static var previews: some View {
        ContainerView()
    }
}
