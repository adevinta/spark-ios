//
//  SwitchUIViewTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore
@testable import Spark

final class SwitchUIViewTests: UIKitComponentTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test_uikit_switch_colors() throws {
        let suts = try SwitchSutTests.allColorsCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }

    func test_uikit_switch_contens() throws {
        let suts = try SwitchSutTests.allContentsCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }

    func test_uikit_switch_positions() throws {
        let suts = try SwitchSutTests.allPositionsCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }
}

// MARK: - Testing

private extension SwitchUIViewTests {

    func test(suts: [SwitchSutTests], function: String = #function) {
        for sut in suts {
            let view: SwitchUIView

            if let images = sut.images {
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intentColor: sut.intentColor,
                    isEnabled: sut.isEnabled,
                    images: images.leftValue,
                    text: sut.text
                )
            } else {
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intentColor: sut.intentColor,
                    isEnabled: sut.isEnabled,
                    text: sut.text
                )
            }

            view.backgroundColor = self.theme.colors.base.background.uiColor

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName(on: function)
            )
        }
    }
}
