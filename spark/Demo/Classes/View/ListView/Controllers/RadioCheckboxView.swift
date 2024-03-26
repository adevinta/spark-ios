//
//  RadioCheckboxView.swift
//  SparkDemo
//
//  Created by alican.aycil on 22.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Spark
import SparkCore
import SwiftUI

struct RadioCheckboxView: View {

    // MARK: - Properties
    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var alignment: CheckboxAlignment = .left
    @State private var selectedIcon = CheckboxListView.Icons.checkedImage
    @State private var selectedID: Int? = 0
    @State private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", id: "1", selectionState: .selected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Hello World", id: "2", selectionState: .selected, isEnabled: true)
    ]
    @State private var radioGroupItems: [RadioButtonItem<Int>] = [
        RadioButtonItem(id: 0, label: "Hello World"),
        RadioButtonItem(id: 1, label: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
    ]


    // MARK: - View
    var body: some View {
        Component(
            name: "Radio Checkbox SwiftUI",
            configuration: {

                EnumSelector(
                    title: "Alignment",
                    dialogTitle: "Select a Alignment",
                    values: CheckboxAlignment.allCases,
                    value: self.$alignment
                )
            },
            integration: {
                VStack(alignment: .leading) {
                    CheckboxGroupView(
                        checkedImage: self.selectedIcon.image,
                        items: self.$items,
                        layout: .vertical,
                        alignment: self.alignment,
                        theme: self.theme,
                        intent: .main,
                        accessibilityIdentifierPrefix: "checkbox-group"
                    )

                    RadioButtonGroupView(
                        theme: self.theme,
                        intent: .main,
                        selectedID: self.$selectedID,
                        items: self.radioGroupItems,
                        labelAlignment: self.alignment == .left ? .trailing : .leading,
                        groupLayout: .vertical
                    )
                }
            }
        )
    }
}
