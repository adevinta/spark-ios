//
//  SliderUIControlSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by louis.borlee on 14/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class SliderUIControlSnapshotTests: UIKitComponentSnapshotTestCase {

    private let theme = SparkTheme.shared

    private func _test(scenario: SliderScenario) {
        let configurations = self.createConfigurations(from: scenario)
        for configuration in configurations {
            self.assertSnapshot(matching: configuration.view, modes: scenario.modes, sizes: [.medium], testName: configuration.testName)
        }
    }

    func test1() {
        self._test(scenario: SliderScenario.test1)
    }

    func test2() {
        self._test(scenario: SliderScenario.test2)
    }

    func test3() {
        self._test(scenario: SliderScenario.test3)
    }

    func test4() {
        self._test(scenario: SliderScenario.test4)
    }

    private func createConfigurations(from scenario: SliderScenario) -> [(testName: String, view: SliderUIControl<Float>)] {
        var sliders = [(testName: String, view: SliderUIControl<Float>)]()
        for intent in scenario.intents {
            for state in scenario.states {
                for value in scenario.values {
                    let slider = SliderUIControl<Float>(
                        theme: self.theme,
                        shape: scenario.shape,
                        intent: intent
                    )
                    slider.backgroundColor = .systemBackground
                    slider.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        slider.heightAnchor.constraint(equalToConstant: 44),
                        slider.widthAnchor.constraint(equalToConstant: 200)
                   ])
                    slider.setValue(value.rawValue)
                    switch state {
                    case .normal: slider.isEnabled = true
                    case .disabled: slider.isEnabled = false
                    case .highlighted: slider.isHighlighted = true
                    }
                    let testName = scenario.getTestName(intent: intent, state: state, value: value)
                    sliders.append((testName: testName, view: slider))
                }
            }
        }
        return sliders
    }
}
