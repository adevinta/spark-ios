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
        let theming = SparkTheme.shared

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
                    theming: self.theming,
                    selectionState: $selection1
                )
                CheckboxView(
                    text: "Unselected checkbox.",
                    theming: self.theming,
                    selectionState: $selection2
                )
                CheckboxView(
                    text: "Indeterminate checkbox.",
                    theming: self.theming,
                    selectionState: $selection3
                )

                Divider()
                Text("Right")
                CheckboxView(
                    text: "Selected checkbox.",
                    checkboxPosition: .right,
                    theming: self.theming,
                    selectionState: $selection1
                )
                CheckboxView(
                    text: "Unselected checkbox.",
                    checkboxPosition: .right,
                    theming: self.theming,
                    selectionState: $selection2
                )
                CheckboxView(
                    text: "Indeterminate checkbox.",
                    checkboxPosition: .right,
                    theming: self.theming,
                    selectionState: $selection3
                )
            }
            .padding()
        }

    }

    static var previews: some View {
        ContainerView()
    }
}
