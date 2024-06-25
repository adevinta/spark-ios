//
//  CheckboxScenarioSnapshotTests.swift
//  Spark
//
//  Created by alican.aycil on 12.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

enum CheckboxScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3
    case test4

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool = false) -> [CheckboxConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1()
        case .test2:
            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
        case .test3:
            return self.test3()
        case .test4:
            return self.test4()
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intent: all
    ///  - selectionState: selected
    ///  - state: enabled
    ///  - alignment: left
    ///  - text: normal text
    ///  - modes: all
    ///  - sizes (accessibility): default
    private func test1() -> [CheckboxConfigurationSnapshotTests] {
        let intents = CheckboxIntent.allCases

        return intents.map { intent in
            return .init(
                scenario: self,
                intent: intent,
                selectionState: .selected,
                state: .enabled,
                alignment: .left,
                text: "Hello World",
                image: UIImage.mock,
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }

    /// Test 2
    ///
    /// Description: To test all states (content and component)
    ///
    /// Content:
    ///  - intent: all
    ///  - selectionState: selected
    ///  - state: enabled
    ///  - alignment: left
    ///  - text: normal text
    ///  - modes: all
    ///  - sizes (accessibility): default
    private func test2(isSwiftUIComponent: Bool) -> [CheckboxConfigurationSnapshotTests] {
        let selectionStates = CheckboxSelectionState.allCases
        let states = isSwiftUIComponent ? [.enabled, .disabled] : CheckboxState.allCases

        return selectionStates.flatMap { selectionState in
            states.map { state in
                return CheckboxConfigurationSnapshotTests.init(
                    scenario: self,
                    intent: .basic,
                    selectionState: selectionState,
                    state: state,
                    alignment: .left,
                    text: "Hello World",
                    image: UIImage.mock,
                    modes: Constants.Modes.all,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }

    /// Test 3
    ///
    /// Description: To test label resilience
    ///
    /// Content:
    ///  - intent: all
    ///  - selectionState: selected
    ///  - state: enabled
    ///  - alignment: left
    ///  - text: normal text
    ///  - modes: all
    ///  - sizes (accessibility): default
    private func test3() -> [CheckboxConfigurationSnapshotTests] {
        let texts = ["Hello World", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."]
        let alignments = CheckboxAlignment.allCases

        return texts.flatMap { text in
            alignments.map { alignment in
                return CheckboxConfigurationSnapshotTests.init(
                    scenario: self,
                    intent: .main,
                    selectionState: .selected,
                    state: .enabled,
                    alignment: alignment,
                    text: text,
                    image: UIImage.mock,
                    modes: Constants.Modes.default,
                    sizes: Constants.Sizes.default
                )
            }
        }
    }

    /// Test 4
    ///
    /// Description: To test a11y sizes
    ///
    /// Content:
    ///  - intent: all
    ///  - selectionState: selected
    ///  - state: enabled
    ///  - alignment: left
    ///  - text: normal text
    ///  - modes: all
    ///  - sizes (accessibility): default
    private func test4() -> [CheckboxConfigurationSnapshotTests] {
        let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."

        return [.init(
            scenario: self,
            intent: .main,
            selectionState: .unselected,
            state: .enabled,
            alignment: .right,
            text: text,
            image: UIImage.mock,
            modes: Constants.Modes.default,
            sizes: Constants.Sizes.all
        )]
    }
}

private extension UIImage {
    static let mock: UIImage = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
}
