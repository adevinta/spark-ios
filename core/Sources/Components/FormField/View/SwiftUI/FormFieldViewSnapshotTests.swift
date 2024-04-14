//
//  FormFieldViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 14.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

@testable import SparkCore

final class FormfieldViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    @State private var checkboxGroupItems: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Checkbox 1", id: "1", selectionState: .unselected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Checkbox 2", id: "2", selectionState: .selected, isEnabled: true),
    ]
    @State private var selectedID: Int? = 0

    // MARK: - Tests

    func test() {
        let scenarios = FormfieldScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {
                
                @ViewBuilder
                var component: some View {
                    switch configuration.component {
                    case .singleCheckbox:
                        CheckboxView(
                            text: "Hello World",
                            checkedImage: Image.mock,
                            theme: self.theme,
                            intent: .success,
                            selectionState: .constant(.selected)
                        )
                    case .checkboxGroup:
                        CheckboxGroupView(
                            checkedImage: Image.mock,
                            items: self.$checkboxGroupItems,
                            alignment: .left,
                            theme: self.theme,
                            accessibilityIdentifierPrefix: "checkbox-group"
                        )
                    case .singleRadioButton:
                        RadioButtonGroupView(
                            theme: self.theme,
                            intent: .accent,
                            selectedID: self.$selectedID,
                            items: [
                                RadioButtonItem(id: 0, label: "Radio Button 1")
                            ],
                            labelAlignment: .trailing
                        )
                    case .radioButtonGroup:
                        RadioButtonGroupView(
                            theme: self.theme,
                            intent: .danger,
                            selectedID: self.$selectedID,
                            items: [
                                RadioButtonItem(id: 0, label: "Radio Button 1"),
                                RadioButtonItem(id: 1, label: "Radio Button 2"),
                            ],
                            labelAlignment: .trailing
                        )
                    }
                }

                let view = FormFieldView(
                    theme: self.theme,
                    component: {
                        component
                    },
                    feedbackState: configuration.feedbackState,
                    title: configuration.label,
                    description: configuration.helperMessage,
                    isTitleRequired: configuration.isRequired
                )
                .disabled(configuration.isEnabled)
                .frame(width: UIScreen.main.bounds.size.width)
                .fixedSize()
                .background(.systemBackground)

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}

private extension Image {
    static let mock: Image = Image(systemName: "checkmark")
}
