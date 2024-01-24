//
//  CheckboxGroupViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 16.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

@testable import SparkCore

final class CheckboxGroupViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    private var items: [any CheckboxGroupItemProtocol] = []

    private lazy var _items: Binding<[any CheckboxGroupItemProtocol]> = {
        return Binding<[any CheckboxGroupItemProtocol]>(
            get: { return self.items },
            set: { newValue, transaction in
                self.items = newValue
            }
        )
    }()

    // MARK: - Tests

    func test() {
        let scenarios = CheckboxGroupScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for (index, configuration) in configurations.enumerated() {
                self.items = configuration.items

                var view = CheckboxGroupView(
                    checkedImage: configuration.image,
                    items: self._items,
                    layout: configuration.axis,
                    alignment: configuration.alignment,
                    theme: self.theme,
                    intent: configuration.intent,
                    accessibilityIdentifierPrefix: "\(index)"
                )
                .frame(width: UIScreen.main.bounds.width)
                .background(Color.systemBackground)

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    record: true,
                    testName: configuration.testName()
                )
            }
        }
    }
}
