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

    // MARK: - Tests

    func test() {
        let scenarios = CheckboxGroupScenarioSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {

                let view = CheckboxGroupContainerView(configuration: configuration)
                .fixedSize()

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

private struct CheckboxGroupContainerView: View {

    private let theme: Theme = SparkTheme.shared
    let configuration: CheckboxGroupConfigurationSnapshotTests

    @Binding var items: [any CheckboxGroupItemProtocol]
    @State var viewHeight: CGFloat = 0

    init(configuration: CheckboxGroupConfigurationSnapshotTests) {
        self.configuration = configuration
        self._items = .constant(configuration.items)
    }

    var body: some View {
        VStack {
            CheckboxGroupView(
                checkedImage: Image(uiImage: configuration.image),
                items: self.$items,
                layout: configuration.axis,
                alignment: configuration.alignment,
                theme: self.theme,
                intent: configuration.intent,
                accessibilityIdentifierPrefix: "id"
            )
            .background(Color.systemBackground)
            .frame(width: UIScreen.main.bounds.width)
            .overlay(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        self.viewHeight = geo.size.height
                    }
                }
            )
        }
        .frame(height: self.viewHeight)
    }
}
