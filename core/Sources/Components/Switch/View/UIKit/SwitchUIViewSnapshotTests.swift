//
//  SwitchUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting // TODO: remove SnapshotTesting
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting
import SparkTheme

final class SwitchUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test_uikit_switch_colors() throws {
        let suts = try SwitchSutSnapshotTests.allColorsCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }

    func test_uikit_switch_contens() throws {
        let suts = try SwitchSutSnapshotTests.allContentsCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }

    func test_uikit_switch_positions() throws {
        let suts = try SwitchSutSnapshotTests.allPositionsCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }
}

// MARK: - Testing

private extension SwitchUIViewSnapshotTests {

    func test(suts: [SwitchSutSnapshotTests], function: String = #function) {
        for sut in suts {
            var view: SwitchUIView!

            // Images + Text
            if let images = sut.images, let text = sut.text {
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intent: sut.intent,
                    isEnabled: sut.isEnabled,
                    images: images.leftValue,
                    text: text
                )
            } else if let images = sut.images, let attributedText = sut.attributedText { // Images + Attributed Text
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intent: sut.intent,
                    isEnabled: sut.isEnabled,
                    images: images.leftValue,
                    attributedText: attributedText.leftValue
                )
            } else if let text = sut.text { // Only Text
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intent: sut.intent,
                    isEnabled: sut.isEnabled,
                    text: text
                )
            } else if let attributedText = sut.attributedText { // Only Attributed Text
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intent: sut.intent,
                    isEnabled: sut.isEnabled,
                    attributedText: attributedText.leftValue
                )
            } else { // Without image and text
                view = SwitchUIView(
                    theme: self.theme,
                    isOn: sut.isOn,
                    alignment: sut.alignment,
                    intent: sut.intent,
                    isEnabled: sut.isEnabled
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
