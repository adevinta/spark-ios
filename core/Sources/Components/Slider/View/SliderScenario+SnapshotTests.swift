//
//  SliderScenario+SnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by louis.borlee on 14/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting

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

    enum Value: Float {
        case min = 0
        case medium = 0.5
        case max = 1.0
    }

    static let test1 = SliderScenario(
        description: "Test1",
        intents: SliderIntent.allCases,
        states: [.highlighted],
        shape: .square,
        modes: ComponentSnapshotTestConstants.Modes.all,
        values: [.medium]
    )

    static let test2 = SliderScenario(
        description: "Test2",
        intents: [.basic],
        states: [.normal],
        shape: .square,
        modes: ComponentSnapshotTestConstants.Modes.default,
        values: [.min, .max]
    )

    static let test3 = SliderScenario(
        description: "Test3",
        intents: [.basic],
        states: State.allCases,
        shape: .square,
        modes: ComponentSnapshotTestConstants.Modes.all,
        values: [.medium]
    )

    static let test4 = SliderScenario(
        description: "Test4",
        intents: [.basic],
        states: [.normal],
        shape: .rounded,
        modes: ComponentSnapshotTestConstants.Modes.default,
        values: [.medium]
    )

    func getTestName(intent: SliderIntent, state: State, value: Value) -> String {
        return "\(self)-\(intent)-\(state)-\(self.shape)-\(value)"
    }
}
