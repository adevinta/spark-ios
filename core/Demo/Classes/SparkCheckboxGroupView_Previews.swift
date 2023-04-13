//
//  SparkCheckboxGroupView_Previews.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import SwiftUI

struct SparkCheckboxGroupView_Previews: PreviewProvider {

    struct ContainerView: View {
        let position: SparkCheckboxView.CheckboxPosition

        let theming = SparkCheckboxTheming(theme: SparkTheme(), variant: .filled)

        @State private var selection1: SparkCheckboxSelectionState = .selected

        @State private var items: [any SparkCheckboxGroupItemProtocol] = [
            CheckboxGroupItem(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
            CheckboxGroupItem(title: "Cake", id: "2", selectionState: .indeterminate),
            CheckboxGroupItem(title: "Fish", id: "3", selectionState: .unselected),
            CheckboxGroupItem(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
            CheckboxGroupItem(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
        ]

        var body: some View {
            HStack {
                SparkCheckboxGroupView(
                    items: $items,
                    checkboxPosition: position,
                    theming: theming,
                    accessibilityIdentifierPrefix: "group"
                )
                Spacer()
            }
            .padding()
        }

    }

    static var previews: some View {
        ContainerView(position: .left)
            .previewDisplayName("Left layout")

        ContainerView(position: .right)
            .previewDisplayName("Right layout")
    }
}

final class CheckboxGroupItem: SparkCheckboxGroupItemProtocol, Hashable {
    static func == (lhs: CheckboxGroupItem, rhs: CheckboxGroupItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var title: String
    var id: String
    var selectionState: SparkCheckboxSelectionState
    var state: SparkSelectButtonState

    init(
        title: String,
        id: String,
        selectionState: SparkCheckboxSelectionState,
        state: SparkSelectButtonState = .enabled
    ) {
        self.title = title
        self.id = id
        self.selectionState = selectionState
        self.state = state
    }
}
