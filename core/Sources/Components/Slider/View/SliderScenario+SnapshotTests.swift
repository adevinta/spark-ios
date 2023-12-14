//
//  SliderScenario+SnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by louis.borlee on 14/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

struct SliderScenario: CustomStringConvertible {
    let description: String
    let intents: [SliderIntent]
    let states: [State]
    let shape: SliderShape
    let modes: [ComponentSnapshotTestMode]
    let values: [Value]

    enum State: CaseIterable {
        case normal, disabled, highlighted
    }

    enum Value {
        case min, medium, max
    }

    static let test1 = SliderScenario(
        description: "Test1",
        intents: SliderIntent.allCases,
        states: [.highlighted],
        shape: .square,
        modes: ComponentSnapshotTestMode.allCases,
        values: [.medium]
    )

    static let test2 = SliderScenario(
        description: "Test2",
        intents: [.basic],
        states: [.normal],
        shape: .square,
        modes: [.light],
        values: [.min, .max]
    )

    static let test3 = SliderScenario(
        description: "Test3",
        intents: [.basic],
        states: State.allCases,
        shape: .square,
        modes: ComponentSnapshotTestMode.allCases,
        values: [.medium]
    )

    static let test4 = SliderScenario(
        description: "Test4",
        intents: [.basic],
        states: [.normal],
        shape: .rounded,
        modes: [.light],
        values: [.medium]
    )
}
