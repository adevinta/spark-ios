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

    @State private var checkboxAlignment: CheckboxAlignment = .left

    @State private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Entry", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItemDefault(title: "Entry 2", id: "2", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Entry 3", id: "3", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Entry 4", id: "4", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Entry 5", id: "5", selectionState: .unselected, isEnabled: false),
        CheckboxGroupItemDefault(title: "Entry 6", id: "6", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Entry 7", id: "7", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Entry 8", id: "8", selectionState: .unselected)
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
                    self.checkboxAlignment = self.checkboxAlignment == .left ? .right : .left
                }
            }

            Button("Add checkbox") {
                let identifier = "\(self.items.count + 1)"
                let newItem = CheckboxGroupItemDefault(title: "Entry \(identifier)", id: identifier, selectionState: .unselected)
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
                    checkboxAlignment: checkboxAlignment,
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
        let states = [true, false]
        let selectionStates = [CheckboxSelectionState.selected, .unselected, .indeterminate]

        withAnimation {
            for index in 0..<items.count {
                var item = self.items[index]
                if let randomState = states.randomElement() {
                    item.isEnabled = randomState
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
        self.selectedItems.map { $0.title ?? "" }.joined(separator: ", ")
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

    var title: String?
    var attributedTitle: NSAttributedString?
    var id: String
    var selectionState: CheckboxSelectionState
    var isEnabled: Bool
    var state: SparkCore.SelectButtonState

    init(
        title: String? = nil,
        id: String,
        selectionState: CheckboxSelectionState,
        isEnabled: Bool = true
    ) {
        self.title = title
        self.attributedTitle = nil
        self.id = id
        self.selectionState = selectionState
        self.isEnabled = isEnabled
        self.state = isEnabled ? .enabled : .disabled
    }

    init(
        attributedTitle: NSAttributedString,
        id: String,
        selectionState: CheckboxSelectionState,
        isEnabled: Bool = true
    ) {
        self.title = attributedTitle.string
        self.attributedTitle = attributedTitle
        self.id = id
        self.selectionState = selectionState
        self.isEnabled = isEnabled
        self.state = isEnabled ? .enabled : .disabled
    }
}
