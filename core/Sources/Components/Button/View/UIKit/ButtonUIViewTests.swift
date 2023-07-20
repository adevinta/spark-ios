//
//  ButtonUIViewTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 11.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore
@testable import Spark

final class ButtonUIViewTests: UIKitComponentTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test_uikit_switch_colors() {
        let suts = ButtonSutTests.allColorsCases()
        self.test(suts: suts)
    }

    func test_uikit_switch_styles() {
        let suts = ButtonSutTests.allStylesCases()
        self.test(suts: suts)
    }

    func test_uikit_switch_contents() {
        let suts = ButtonSutTests.allContentCases(isSwiftUIComponent: false)
        self.test(suts: suts)
    }
}

// MARK: - Testing

private extension ButtonUIViewTests {

    func test(suts: [ButtonSutTests], function: String = #function) {
        for sut in suts {
            var view: ButtonUIView!

            // Icon + Text ?
            if let iconImage = sut.iconImage, let text = sut.text {
                view = ButtonUIView(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    iconImage: iconImage.leftValue,
                    text: text,
                    isEnabled: sut.isEnabled
                )

            } else if let iconImage = sut.iconImage, let attributedText = sut.attributedText { // Icon + Attributed Text
                view = ButtonUIView(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    iconImage: iconImage.leftValue,
                    attributedText: attributedText.leftValue,
                    isEnabled: sut.isEnabled
                )

            } else if let iconImage = sut.iconImage { // Only Icon
                view = ButtonUIView(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    iconImage: iconImage.leftValue,
                    isEnabled: sut.isEnabled
                )

            } else if let text = sut.text { // Only Text
                view = ButtonUIView(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    text: text,
                    isEnabled: sut.isEnabled
                )

            } else if let attributedText = sut.attributedText { // Only Attributed Text
                view = ButtonUIView(
                    theme: self.theme,
                    intent: sut.intent,
                    variant: sut.variant,
                    size: sut.size,
                    shape: sut.shape,
                    alignment: sut.alignment,
                    attributedText: attributedText.leftValue,
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
