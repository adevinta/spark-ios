//
//  ButtonUIViewSnapshotTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 11.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore

final class ButtonUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test_uikit_button_colors() {
        let suts = ButtonSutSnapshotTests.allColorsCases()
        self.test(suts: suts)
    }

    func test_uikit_button_styles() {
        let suts = ButtonSutSnapshotTests.allStylesCases()
        self.test(suts: suts)
    }

    func test_uikit_button_contents() {
        let suts = ButtonSutSnapshotTests.allContentCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }
}

// MARK: - Testing

private extension ButtonUIViewSnapshotTests {

    func test(suts: [ButtonSutSnapshotTests], function: String = #function) {
        for sut in suts {
            var view: ButtonUIViewDeprecated!

            // Icon + Title ?
            if let iconImage = sut.iconImage, let title = sut.title {
                view = ButtonUIViewDeprecated(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    iconImage: iconImage.leftValue,
                    text: title,
                    isEnabled: sut.isEnabled
                )

            } else if let iconImage = sut.iconImage, let attributedTitle = sut.attributedTitle { // Icon + Attributed Title
                view = ButtonUIViewDeprecated(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    iconImage: iconImage.leftValue,
                    attributedText: attributedTitle.leftValue,
                    isEnabled: sut.isEnabled
                )

            } else if let iconImage = sut.iconImage { // Only Icon
                view = ButtonUIViewDeprecated(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    iconImage: iconImage.leftValue,
                    isEnabled: sut.isEnabled
                )

            } else if let title = sut.title { // Only Title
                view = ButtonUIViewDeprecated(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    text: title,
                    isEnabled: sut.isEnabled
                )

            } else if let attributedTitle = sut.attributedTitle { // Only Attributed Title
                view = ButtonUIViewDeprecated(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    attributedText: attributedTitle.leftValue,
                    isEnabled: sut.isEnabled
                )
            } else {
                XCTFail("View should be init")
            }

            view.backgroundColor = self.theme.colors.base.background.uiColor

            // Is pressed ?
            if sut.isPressed {
                view.testPressedAction()
            }

            self.assertSnapshotInDarkAndLight(
                matching: view,
                testName: sut.testName(on: function)
            )
        }
    }
}
