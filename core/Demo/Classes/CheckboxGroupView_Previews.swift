//
//  SparkCheckboxGroupView_Previews.swift
//  SparkCoreDemo
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct CheckboxGroupView_Previews: PreviewProvider {

    struct ContainerView: View {
        let position: CheckboxPosition

        let theme: Theme = SparkTheme.shared

        @State private var selection1: CheckboxSelectionState = .selected

        @State private var items: [any CheckboxGroupItemProtocol] = [
            CheckboxGroupItem(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
            CheckboxGroupItem(title: "Cake", id: "2", selectionState: .indeterminate),
            CheckboxGroupItem(title: "Fish", id: "3", selectionState: .unselected),
            CheckboxGroupItem(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
            CheckboxGroupItem(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
        ]

        var body: some View {
            HStack {
                CheckboxGroupView(
                    items: $items,
                    checkboxPosition: self.position,
                    theme: self.theme,
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

final class CheckboxGroupItem: CheckboxGroupItemProtocol, Hashable {
    static func == (lhs: CheckboxGroupItem, rhs: CheckboxGroupItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var title: String
    var id: String
    var selectionState: CheckboxSelectionState
    var state: SelectButtonState

    init(
        title: String,
        id: String,
        selectionState: CheckboxSelectionState,
        state: SelectButtonState = .enabled
    ) {
        self.title = title
        self.id = id
        self.selectionState = selectionState
        self.state = state
    }
}
