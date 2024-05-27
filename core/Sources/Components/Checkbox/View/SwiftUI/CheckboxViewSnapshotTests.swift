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

                let checkboxView = CheckboxView(
                    text: configuration.text,
                    checkedImage: Image(uiImage: configuration.image),
                    alignment: configuration.alignment,
                    theme: self.theme,
                    intent: configuration.intent,
                    isEnabled: configuration.state == .disabled ? false : true,
                    selectionState: self._selectionState
                )
                .background(Color.systemBackground)

                let view = self.view(text: configuration.text, checkbox: checkboxView)

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }

    func view(text: String, checkbox: some View) -> AnyView {
        if text != "Hello World" {
            let view = VStack { checkbox }
                .frame(width: UIScreen.main.bounds.width)
            return AnyView(view)
        } else {
            return AnyView(checkbox.fixedSize())
        }

    }
}
