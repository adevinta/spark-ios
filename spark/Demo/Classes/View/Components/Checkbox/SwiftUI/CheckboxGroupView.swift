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

struct CheckboxGroupListView: View {

    // MARK: - Properties

    private let viewModel = CheckboxViewModel()

    // MARK: - View

    @State private var layout: CheckboxGroupLayout = .vertical

    @State private var checkboxPosition: CheckboxPosition = .left

    @State private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItem(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItem(title: "Entry 2", id: "2", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 3", id: "3", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 4", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItem(title: "Entry 5", id: "5", selectionState: .unselected, state: .disabled),
        CheckboxGroupItem(title: "Entry 6", id: "6", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 7", id: "7", selectionState: .unselected),
        CheckboxGroupItem(title: "Entry 8", id: "8", selectionState: .unselected)
    ]

    @ObservedObject private var themePublisher = SparkThemePublisher.shared

    var theme: Theme {
        self.themePublisher.theme
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Selection:\n\(self.selectedItemsText)")
                Spacer()
            }

            Button("Shuffle states") {
                self.shuffleAction()
            }

            Button("Change layout") {
                withAnimation {
                    self.layout = layout == .horizontal ? .vertical : .horizontal
                }
            }

            Button("Change position") {
                withAnimation {
                    self.checkboxPosition = self.checkboxPosition == .left ? .right : .left
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

        ScrollView(self.layout == .horizontal ? .horizontal : .vertical) {
            HStack {
                let checkedImage = DemoIconography.shared.checkmark

                CheckboxGroupView(
                    title: "Checkbox-group title (SwiftUI)",
                    checkedImage: checkedImage,
                    items: $items,
                    layout: layout,
                    checkboxPosition: checkboxPosition,
                    theme: self.theme,
                    accessibilityIdentifierPrefix: "checkbox-group"
                )
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text("Checkbox"))

        Spacer()
    }

    func shuffleAction() {
        let states = [SelectButtonState.enabled, .disabled, .success(message: "Success"), .warning(message: "Warning"), .error(message: "Error")]
        let selectionStates = [CheckboxSelectionState.selected, .unselected, .indeterminate]

        withAnimation {
            for index in 0..<items.count {
                var item = self.items[index]
                if let randomState = states.randomElement() {
                    item.state = randomState
                }

                if let randomSelectionState = selectionStates.randomElement() {
                    item.selectionState = randomSelectionState
                }
                self.items[index] = item
            }
        }
    }

    var selectedItems: [any CheckboxGroupItemProtocol] {
        self.items.filter { $0.selectionState == .selected }
    }

    var selectedItemsText: String {
        self.selectedItems.map { $0.title }.joined(separator: ", ")
    }
}

struct CheckboxGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxListView()
    }
}

// MARK: - Demo item

class CheckboxGroupItem: CheckboxGroupItemProtocol, Hashable {
    static func == (lhs: CheckboxGroupItem, rhs: CheckboxGroupItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var title: String
    var attributedTitle: NSAttributedString?
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
        self.attributedTitle = nil
        self.id = id
        self.selectionState = selectionState
        self.state = state
    }

    init(
        attributedTitle: NSAttributedString,
        id: String,
        selectionState: CheckboxSelectionState,
        state: SelectButtonState = .enabled
    ) {
        self.title = attributedTitle.string
        self.attributedTitle = attributedTitle
        self.id = id
        self.selectionState = selectionState
        self.state = state
    }
}
