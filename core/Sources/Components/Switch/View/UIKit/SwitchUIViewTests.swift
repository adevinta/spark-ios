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

    func test_uikit_switch() throws {
        let suts = try SwitchSutTests.allCases(isSwiftUIComponent: false)
        for sut in suts {

            let view: SwitchUIView

            if let variant = sut.variant {
                    view = SwitchUIView(
                        theme: self.theme,
                        isOn: sut.isOn,
                        alignment: sut.alignment,
                        intentColor: sut.intentColor,
                        isEnabled: sut.isEnabled,
                        variant: variant.toUIImages(),
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
                testName: sut.testName()
            )
        }
    }
}
