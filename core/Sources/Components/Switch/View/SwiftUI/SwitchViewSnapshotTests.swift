//
//  SwitchViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SparkTheme
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommon

final class SwitchViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test_swiftUI_switch_colors() throws {
        let suts = try SwitchSutSnapshotTests.allColorsCases(isSwiftUIComponent: true)
        self.test(suts: suts)
    }

    func test_swiftUI_switch_contens() throws {
        let suts = try SwitchSutSnapshotTests.allContentsCases(isSwiftUIComponent: true)
        self.test(suts: suts)
    }

    func test_swiftUI_switch_positions() throws {
        let suts = try SwitchSutSnapshotTests.allPositionsCases(isSwiftUIComponent: true)
        self.test(suts: suts)
    }
}

// MARK: - Testing

private extension SwitchViewSnapshotTests {

    func test(suts: [SwitchSutSnapshotTests], function: String = #function) {
        for sut in suts {
            var view = SwitchView(
                theme: self.theme,
                intent: sut.intent,
                alignment: sut.alignment,
                isOn: .constant(sut.isOn)
            )
                .disabled(!sut.isEnabled)

            // Images + Text
            if let images = sut.images, let text = sut.text {
                view = view
                    .images(images.rightValue)
                    .text(text)
            } else if let images = sut.images, let attributedText = sut.attributedText { // Images + Attributed Text
                view = view
                    .images(images.rightValue)
                    .attributedText(attributedText.rightValue)
            } else if let text = sut.text { // Only Text
                view = view
                    .text(text)
            } else if let attributedText = sut.attributedText { // Only Attributed Text
                view = view
                    .attributedText(attributedText.rightValue)
            }

            self.assertSnapshotInDarkAndLight(
                matching: view
                    .background(self.theme.colors.base.background.color)
                    .fixedSize(),
                testName: sut.testName(on: function)
            )
        }
    }
}
