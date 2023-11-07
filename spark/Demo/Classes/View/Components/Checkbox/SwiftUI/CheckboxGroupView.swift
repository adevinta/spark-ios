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
    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: CheckboxIntent = .main
    @State private var alignment: CheckboxAlignment = .left
    @State private var layout: CheckboxSelectionState = CheckboxSelectionState.unselected
    @State private var isTitleHidden: CheckboxSelectionState = CheckboxSelectionState.unselected
    @State private var textStyle: CheckboxTextStyle = .text
    @State private var selectedIcon = CheckboxListView.Icons.checkedImage
    @State private var groupType: CheckboxGroupType = .doubleMix
    @State private var items: [any CheckboxGroupItemProtocol] = CheckboxGroupComponentUIViewModel.makeCheckboxGroupItems(type: .doubleMix)
    @State private var selectedItems: String = ""

    var selectedItemsText: String {
        var text: String = ""
        let texts: [String] = self.items.enumerated()
            .map { index, checkbox in
                let line: String = index == (self.items.count - 1) ? "" : "\n"
                return "\(index + 1) \(checkbox.selectionState)" + line
            }
        texts.forEach { text += $0 }
        return text
    }

    // MARK: - View
    var body: some View {
        Component(
            name: "Checkbox Group",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: CheckboxIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Alignment",
                    dialogTitle: "Select a Alignment",
                    values: CheckboxAlignment.allCases,
                    value: self.$alignment
                )

                EnumSelector(
                    title: "Icons",
                    dialogTitle: "Select a Icon",
                    values: CheckboxListView.Icons.allCases,
                    value: self.$selectedIcon
                )

                EnumSelector(
                    title: "Group Type",
                    dialogTitle: "Select a type",
                    values: CheckboxGroupType.allCases,
                    value: self.$groupType
                )

                CheckboxView(
                    text: "Is Layout vertical",
                    checkedImage: CheckboxListView.Icons.checkedImage.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$layout
                )

                CheckboxView(
                    text: "Show Group Title (Deprecated)",
                    checkedImage: CheckboxListView.Icons.checkedImage.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isTitleHidden
                )

                HStack {
                    Text("Items:")
                    Text(self.selectedItemsText)
                }
            },
            integration: {
                CheckboxGroupView(
                    title: self.isTitleHidden == .selected ? "This title was deprecated" : "",
                    checkedImage: self.selectedIcon.image,
                    items: self.$items,
                    layout: self.layout == .selected ? .vertical : .horizontal,
                    checkboxAlignment: self.alignment,
                    theme: self.theme,
                    intent: self.intent,
                    accessibilityIdentifierPrefix: "checkbox-group"
                )
                .onChange(of: self.groupType) { newValue in
                    self.items = self.setItems(groupType: newValue)
                }
            }
        )
    }

    private func setItems(groupType: CheckboxGroupType) -> [any CheckboxGroupItemProtocol] {
        CheckboxGroupComponentUIViewModel.makeCheckboxGroupItems(type: self.groupType)
    }
}

struct CheckboxGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxListView()
    }
}
