//
//  TextFieldScenario+SnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by louis.borlee on 12/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore
import UIKit

struct TextFieldScenario: CustomStringConvertible {
    let description: String
    let statesArray: [TextFieldScenarioStates]
    let intents: [TextFieldIntent]
    let texts: [TextFieldScenarioText]
    let leftContents: [TextFieldScenarioSideContentOptionSet]
    let rightContents: [TextFieldScenarioSideContentOptionSet]
    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    static let test1: TextFieldScenario = .init(
        description: "Test1",
        statesArray: [
            .disabled,
            .focused,
            .readOnly,
            .`default`,
            .readyOnlyAndDisabled
        ],
        intents: [.neutral],
        texts: [.normal],
        leftContents: [.none],
        rightContents: [.none],
        modes: ComponentSnapshotTestConstants.Modes.all,
        sizes: ComponentSnapshotTestConstants.Sizes.default
    )

    static let test2: TextFieldScenario = .init(
        description: "Test2",
        statesArray: [.`default`],
        intents: [.neutral],
        texts: [.empty, .placeholder, .normal, .long],
        leftContents: [.none],
        rightContents: [.none],
        modes: [.light],
        sizes: ComponentSnapshotTestConstants.Sizes.default
    )

    static let test3: TextFieldScenario = .init(
        description: "Test3",
        statesArray: [.focused],
        intents: [.success],
        texts: [.normal],
        leftContents: [[.button], [.image]],
        rightContents: [[.button], [.image]],
        modes: [.light],
        sizes: [.extraSmall, .medium]
    )

    static let test4: TextFieldScenario = .init(
        description: "Test4",
        statesArray: [.disabled],
        intents: [.error],
        texts: [.placeholder, .long],
        leftContents: [[.button, .image]],
        rightContents: [[.button, .image]],
        modes: [.light],
        sizes: ComponentSnapshotTestConstants.Sizes.default
    )

    static let test5: TextFieldScenario = .init(
        description: "Test5",
        statesArray: [.`default`],
        intents: TextFieldIntent.allCases,
        texts: [.normal],
        leftContents: [.none],
        rightContents: [.none],
        modes: ComponentSnapshotTestConstants.Modes.all,
        sizes: [.medium, .accessibilityExtraExtraExtraLarge]
    )

    func getTestName(intent: TextFieldIntent, states: TextFieldScenarioStates, text: TextFieldScenarioText, leftContent: TextFieldScenarioSideContentOptionSet, rightContent: TextFieldScenarioSideContentOptionSet) -> String {
        var testName = "\(self)-\(intent)Intent-\(states.name)State-\(text.rawValue)Text"
        if leftContent.isEmpty == false {
            testName.append("-left\(leftContent.name)")
        }
        if rightContent.isEmpty == false {
            testName.append("-right\(rightContent.name)")
        }
        return testName
    }
}

struct TextFieldScenarioStates {
    let isEnabled: Bool
    let isFocused: Bool
    let isReadOnly: Bool
    let name: String

    static let disabled: TextFieldScenarioStates = .init(
        isEnabled: false,
        isFocused: false,
        isReadOnly: false,
        name: "disabled"
    )
    static let readOnly: TextFieldScenarioStates = .init(
        isEnabled: true,
        isFocused: false,
        isReadOnly: true,
        name: "readOnly"
    )
    static let focused: TextFieldScenarioStates = .init(
        isEnabled: true,
        isFocused: true,
        isReadOnly: false,
        name: "focused"
    )
    static let `default`: TextFieldScenarioStates = .init(
        isEnabled: true,
        isFocused: false,
        isReadOnly: false,
        name: "default"
    )
    static let readyOnlyAndDisabled: TextFieldScenarioStates = .init(
        isEnabled: false,
        isFocused: false,
        isReadOnly: true,
        name: "readyOnlyAndDisabled"
    )
}

enum TextFieldScenarioText: String {
    case empty
    case placeholder
    case normal
    case long

    var placeholder: String? {
        switch self {
        case .empty:
            return nil
        default:
            return "Placeholder"
        }
    }

    var text: String? {
        switch self {
        case .empty, .placeholder:
            return nil
        case .normal:
            return "Hello there"
        case .long:
            return """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac faucibus metus. Praesent feugiat commodo nibh, at placerat enim pharetra ac. Integer sed dictum eros.
            """
        }
    }
}

struct TextFieldScenarioSideContentOptionSet: OptionSet {
    let rawValue: UInt

    static let none = TextFieldScenarioSideContentOptionSet(rawValue: 1 << 0)
    static let button = TextFieldScenarioSideContentOptionSet(rawValue: 1 << 1)
    static let image = TextFieldScenarioSideContentOptionSet(rawValue: 1 << 2)

    var name: String {
        var contents = [String]()
        if self.contains(.none) {
            contents.append("None")
        }
        if self.contains(.button) {
            contents.append("Button")
        }
        if self.contains(.image) {
            contents.append("Image")
        }
        return contents.joined(separator: "_")
    }
}
