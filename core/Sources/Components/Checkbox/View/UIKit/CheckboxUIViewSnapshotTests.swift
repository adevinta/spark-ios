//
//  CheckboxUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 12.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

@testable import SparkCore

final class CheckboxUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = CheckboxScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: false)
            for configuration in configurations {
                let view = CheckboxUIView(
                    theme: self.theme,
                    intent: configuration.intent,
                    text: configuration.text,
                    checkedImage: configuration.image,
                    isEnabled: configuration.selectionState == .selected ? true : false,
                    selectionState: configuration.selectionState,
                    alignment: configuration.alignment
                )

                view.backgroundColor = UIColor.systemBackground

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    record: false,
                    testName: configuration.testName()
                )
            }
        }
    }
}
