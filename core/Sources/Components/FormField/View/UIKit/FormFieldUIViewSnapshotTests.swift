//
//  FormFieldUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 14.04.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

final class FormFieldUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = FormfieldScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {

                let component = UISwitch()
                component.setOn(true, animated: false)

                let view = FormFieldUIView(
                    theme: self.theme,
                    component: component,
                    feedbackState: configuration.feedbackState,
                    title: configuration.label,
                    description: configuration.helperMessage,
                    isTitleRequired: configuration.isRequired,
                    isEnabled: configuration.isEnabled
                )
                view.backgroundColor = UIColor.systemBackground
                view.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width)
                ])

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }

    static func makeSingleCheckbox() -> UIControl {
        return CheckboxUIView(
            theme: SparkTheme.shared,
            text: "Hello World",
            checkedImage: UIImage.mock,
            selectionState: .unselected,
            alignment: .left
        )
    }

    static func makeVerticalCheckbox() -> UIControl {
        let view = CheckboxGroupUIView(
            checkedImage: UIImage.mock,
            items: [
                CheckboxGroupItemDefault(title: "Checkbox 1", id: "1", selectionState: .unselected, isEnabled: true),
                CheckboxGroupItemDefault(title: "Checkbox 2", id: "2", selectionState: .selected, isEnabled: true),
            ],
            theme: SparkTheme.shared,
            intent: .success,
            accessibilityIdentifierPrefix: "checkbox"
        )
        view.layout = .vertical
        return view
    }

    static func makeSingleRadioButton() -> UIControl {
        return RadioButtonUIView(
            theme: SparkTheme.shared,
            intent: .info,
            id: "radiobutton",
            label: NSAttributedString(string: "Hello World"),
            isSelected: true
        )
    }

    static func makeVerticalRadioButton() -> UIControl {
        return RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            intent: .danger,
            selectedID: "radiobutton",
            items: [
                RadioButtonUIItem(id: "1", label: "Radio Button 1"),
                RadioButtonUIItem(id: "2", label: "Radio Button 2"),
            ],
            groupLayout: .vertical
        )
    }
}

private extension UIImage {
    static let mock: UIImage = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
}
