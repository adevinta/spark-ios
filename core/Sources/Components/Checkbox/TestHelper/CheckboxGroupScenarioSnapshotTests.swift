//
//  CheckboxGroupScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 16.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//
import UIKit
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting

enum CheckboxGroupScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4
    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration() -> [CheckboxGroupConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return self.test2()
        case .test3:
            return self.test3()
        case .test4:
            return self.test4()
        case .test5:
            return self.test5()
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test spacing
    ///
    /// Content:
    ///  - intent: basic
    ///  - alignment: all
    ///  - axis: vertical
    ///  - items: contents of single checkbox component
    ///  - image: checkbox checked image
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test1() -> [CheckboxGroupConfigurationSnapshotTests] {

        let alignments = CheckboxAlignment.allCases
        let items = [
            CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .selected, isEnabled: true),
            CheckboxGroupItemDefault(title: "This is the way.", id: "2", selectionState: .selected, isEnabled: true)
        ]

        return alignments.map { alignment in
            .init(
                scenario: self,
                intent: .basic,
                alignment: alignment,
                axis: .vertical,
                items: items,
                image: UIImage.mock,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test all aliggnments
    ///
    /// Content:
    ///  - intent: accent
    ///  - alignment: all
    ///  - axis: all
    ///  - items: contents of single checkbox component
    ///  - image: checkbox checked image
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test2() -> [CheckboxGroupConfigurationSnapshotTests] {

        let alignments = CheckboxAlignment.allCases
        let layouts: [CheckboxGroupLayout] = [.vertical, .horizontal]
        let items = [
            CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .unselected, isEnabled: true),
            CheckboxGroupItemDefault(title: "This is the way.", id: "2", selectionState: .unselected, isEnabled: true)
        ]

        return alignments.flatMap { alignment in
            layouts.map { layout in
                return .init(
                    scenario: self,
                    intent: .accent,
                    alignment: alignment,
                    axis: layout,
                    items: items,
                    image: UIImage.mock,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }

    /// Test 3
    ///
    /// Description: To test labels content resilience (label of checkboxes)
    ///
    /// Content:
    ///  - intent: accent
    ///  - alignment: all
    ///  - axis: all
    ///  - items: contents of single checkbox component
    ///  - image: checkbox checked image
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test3() -> [CheckboxGroupConfigurationSnapshotTests] {

        let alignments = CheckboxAlignment.allCases
        let layouts: [CheckboxGroupLayout] = [.vertical, .horizontal]
        let items = [
            CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .indeterminate, isEnabled: true),
            CheckboxGroupItemDefault(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", id: "2", selectionState: .indeterminate, isEnabled: true)
        ]

        return alignments.flatMap { alignment in
            layouts.map { layout in
                return .init(
                    scenario: self,
                    intent: .main,
                    alignment: alignment,
                    axis: layout,
                    items: items,
                    image: UIImage.mock,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }

    /// Test 4
    ///
    /// Description: To test label group content resilience
    ///
    /// Content:
    ///  - intent: support
    ///  - alignment: left
    ///  - axis: all
    ///  - items: contents of single checkbox component
    ///  - image: checkbox checked image
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test4() -> [CheckboxGroupConfigurationSnapshotTests] {
        let layouts: [CheckboxGroupLayout] = [.vertical, .horizontal]
        let itemsArray = [[CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .selected, isEnabled: true),
            CheckboxGroupItemDefault(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", id: "2", selectionState: .selected, isEnabled: true)],
            [CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .selected, isEnabled: true),
            CheckboxGroupItemDefault(title: "This is the way.", id: "2", selectionState: .selected, isEnabled: true)]]

        return layouts.flatMap { layout in
            itemsArray.map { items in
                return .init(
                    scenario: self,
                    intent: .support,
                    alignment: .left,
                    axis: layout,
                    items: items,
                    image: UIImage.mock,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }
    
    /// Test 5
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    ///  - intent: support
    ///  - alignment: left
    ///  - axis: all
    ///  - items: contents of single checkbox component
    ///  - image: checkbox checked image
    ///  - modes: light
    ///  - sizes (accessibility): default
    private func test5() -> [CheckboxGroupConfigurationSnapshotTests] {
        let layouts: [CheckboxGroupLayout] = [.vertical, .horizontal]
        let items = [CheckboxGroupItemDefault(title: "Hello World", id: "1", selectionState: .selected, isEnabled: true), CheckboxGroupItemDefault(title: "This is the way.", id: "2", selectionState: .selected, isEnabled: true)]

        return layouts.map { layout in
            .init(
                scenario: self,
                intent: .support,
                alignment: .left,
                axis: layout,
                items: items,
                image: UIImage.mock,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )
        }
    }

}

private extension UIImage {
    static let mock: UIImage = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
}
