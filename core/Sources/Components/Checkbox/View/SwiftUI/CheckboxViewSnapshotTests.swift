//
//  CheckboxViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by alican.aycil on 12.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

@testable import SparkCore

final class CheckboxViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    private var selectionState: CheckboxSelectionState = .selected

    private lazy var _selectionState: Binding<CheckboxSelectionState> = {
        return Binding<CheckboxSelectionState>(
            get: { return self.selectionState },
            set: { newValue, transaction in
                self.selectionState = newValue
            }
        )
    }()

    // MARK: - Tests

    func test() {
        let scenarios = CheckboxScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration(isSwiftUIComponent: true)

            for configuration in configurations {
                self.selectionState = configuration.selectionState

                let view = CheckboxView(
                    text: configuration.text,
                    checkedImage: configuration.image,
                    alignment: configuration.alignment,
                    theme: self.theme,
                    intent: configuration.intent,
                    isEnabled: configuration.state == .disabled ? false : true,
                    selectionState: self._selectionState
                )
                .background(Color.systemBackground)
                .if(configuration.text != "Hello World") { view in
                    VStack {
                        view
                    }
                    .frame(width: UIScreen.main.bounds.width)
                } else: { view in
                    view.fixedSize()
                }

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
