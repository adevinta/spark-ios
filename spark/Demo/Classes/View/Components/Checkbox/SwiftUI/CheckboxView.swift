//
//  CheckboxItemView.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import Spark
import SparkCore
import SwiftUI

struct CheckboxListView: View {

    // MARK: - Properties

    @State private var theme: Theme = SparkThemePublisher.shared.theme
    @State private var intent: CheckboxIntent = .main
    @State private var alignment: CheckboxAlignment = .left
    @State private var textStle: CheckboxTextStyle = .text
    @State private var isEnabled = CheckboxSelectionState.selected
    @State private var isIndeterminate = CheckboxSelectionState.unselected
    @State private var selectionState = CheckboxSelectionState.unselected
    @State private var selectedIcon = Icons.checkedImage

    // MARK: - View

    var body: some View {
        Component(
            name: "Checkbox",
            configuration: {
                ThemeSelector(theme: self.$theme)

                EnumSelector(
                    title: "Intent:",
                    dialogTitle: "Select an Intent",
                    values: CheckboxIntent.allCases,
                    value: self.$intent
                )

                EnumSelector(
                    title: "Alignment:",
                    dialogTitle: "Select a Alignment",
                    values: CheckboxAlignment.allCases,
                    value: self.$alignment
                )

                EnumSelector(
                    title: "Icons:",
                    dialogTitle: "Select a Icon",
                    values: Icons.allCases,
                    value: self.$selectedIcon
                )

                CheckboxView(
                    text: "Is Enabled:",
                    checkedImage: Icons.checkedImage.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isEnabled
                )

                CheckboxView(
                    text: "Is Indeterminate:",
                    checkedImage: Icons.checkedImage.image,
                    theme: theme,
                    isEnabled: true,
                    selectionState: self.$isIndeterminate
                )
            },
            integration: {
                VStack {
                    CheckboxView(
                        text: "Hello World",
                        checkedImage: Icons.checkedImage.image,
                        theme: self.theme,
                        selectionState: $selectionState
                    )
                }
            }
        )
    }
}

// MARK: - Enum
extension CheckboxListView {

    enum Icons: CaseIterable {
        case checkedImage
        case close

        var image: UIImage {
            switch self {
            case .checkedImage:
                return DemoIconography.shared.checkmark
            case .close:
                return DemoIconography.shared.close
            }
        }

        var name: String {
            switch self {
            case .checkedImage:
                return "Checked"
            case .close:
                return "Close"
            }
        }
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxListView()
    }
}
