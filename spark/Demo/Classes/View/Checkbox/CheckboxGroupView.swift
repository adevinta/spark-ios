//
//  CheckboxGroupView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 06.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct CheckboxGroupView: View {

    // MARK: - Properties

    private let viewModel = CheckboxViewModel()

    // MARK: - View

    @State private var layout: SparkCheckboxGroupLayout = .vertical

    @State private var checkboxPosition: SparkCheckboxView.CheckboxPosition = .left

    @State private var items: [any SparkCheckboxItemProtocol] = [
        CheckboxGroupItem(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItem(title: "Entry 2", id: "2", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 3", id: "3", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 4", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItem(title: "Entry 5", id: "5", selectionState: .unselected, state: .disabled),
        CheckboxGroupItem(title: "Entry 6", id: "6", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 7", id: "7", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 8", id: "8", selectionState: .unselected)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Selection:\n\(selectedItemsText)")
                Spacer()
            }

            Button("Shuffle states") {
                shuffleAction()
            }

            Button("Change layout") {
                withAnimation {
                    layout = layout == .horizontal ? .vertical : .horizontal
                }
            }

            Button("Change position") {
                withAnimation {
                    checkboxPosition = checkboxPosition == .left ? .right : .left
                }
            }

            Button("Add checkbox") {
                let identifier = "\(self.items.count + 1)"
                let newItem = CheckboxGroupItem(title: "Entry \(identifier)", id: identifier, selectionState: .unselected)
                withAnimation {
                    self.items.append(newItem)
                }
            }
        }
        .padding(.horizontal, 16)

        ScrollView(layout == .horizontal ? .horizontal : .vertical) {
            HStack {
                let theming = SparkCheckboxTheming.init(
                    theme: SparkTheme.shared,
                    variant: .filled
                )
                SparkCheckboxGroupView(
                    items: $items,
                    layout: layout,
                    checkboxPosition: checkboxPosition,
                    theming: theming
                )
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text("Checkbox"))

        Spacer()
    }

    func shuffleAction() {
        let states = [SparkSelectButtonState.enabled, .disabled, .success(message: "Success"), .warning(message: "Warning"), .error(message: "Error")]
        let selectionStates = [SparkCheckboxSelectionState.selected, .unselected, .indeterminate]

        withAnimation {
            for index in 0..<items.count {
                var item = items[index]
                if let randomState = states.randomElement() {
                    item.state = randomState
                }

                if let randomSelectionState = selectionStates.randomElement() {
                    item.selectionState = randomSelectionState
                }
                items[index] = item
            }
        }
    }

    var selectedItems: [any SparkCheckboxItemProtocol] {
        items.filter { $0.selectionState == .selected }
    }

    var selectedItemsText: String {
        selectedItems.map { $0.title }.joined(separator: ", ")
    }
}

struct CheckboxGrouüView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxView()
    }
}

class CheckboxGroupItem: SparkCheckboxItemProtocol, Hashable {
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
