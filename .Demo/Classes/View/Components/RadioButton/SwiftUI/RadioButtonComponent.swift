//
//  RadioButtonComponent.swift
//  SparkDemo
//
//  Created by michael.zimmermann on 24.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@_spi(SI_SPI) import SparkCommon
import SparkCore
import SwiftUI

struct RadioButtonComponent: View {
    // MARK: - Properties

    enum Constants {
        static let text = "Label"
        static let longText = "Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"
    }

    @State var theme: Theme = SparkThemePublisher.shared.theme
    @State var intent: RadioButtonIntent = .basic
    @State var trailingLabel = CheckboxSelectionState.selected
    @State var verticalLayout = CheckboxSelectionState.selected
    @State var isDisabled = CheckboxSelectionState.unselected
    @State var longLabel = CheckboxSelectionState.unselected
    @State var numberOfItems = 3
    @State var selectedID: Int? = 1

    var items: [RadioButtonItem<Int>] {
        return (1...self.numberOfItems).map { index in
            RadioButtonItem(id: index, label: self.label(index: index))
        }
    }

    // MARK: - View
    var body: some View {
        Component(
            name: "Radio Button",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent",
                    dialogTitle: "Select an Intent",
                    values: RadioButtonIntent.allCases,
                    value: self.$intent
                )

                Checkbox(
                    title: "Trailing label",
                    selectionState: self.$trailingLabel
                )

                Checkbox(
                    title: "Vertical Layout",
                    selectionState: self.$verticalLayout
                )

                Checkbox(
                    title: "Long Label",
                    selectionState: self.$longLabel
                )

                Checkbox(
                    title: "Disable",
                    selectionState: self.$isDisabled
                )

                RangeSelector(
                    title: "No. of Items",
                    range: 2...20,
                    selectedValue: self.$numberOfItems
                )
            },
            integration: {
                RadioButtonGroupView(
                    theme: self.theme,
                    intent: self.intent,
                    selectedID: self.$selectedID,
                    items: self.items,
                    labelAlignment: self.trailingLabel == .selected ? .trailing : .leading,
                    groupLayout: self.verticalLayout == .selected ? .vertical : .horizontal
                )
                .title("Radio Button Group (SwiftUI)")
                .supplementaryText("Radio Button Group Supplementary Text")
                .disabled(self.isDisabled == .selected)
            }
        )
    }

    private func label(index: Int) -> String {
        if self.longLabel == .selected, index == 2 {
            return "\(index) - \(Constants.longText)"
        } else {
            return "\(index) - \(Constants.text)"
        }
    }
}
