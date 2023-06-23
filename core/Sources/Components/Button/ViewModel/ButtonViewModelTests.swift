//
//  ButtonViewModelTests.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 25.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class ButtonViewModelTests: XCTestCase {

    // MARK: - Properties
    var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mock
    }

    // MARK: - Tests
    func test_init() throws {
        let variants = [ButtonVariant.filled, .filled, .contrast, .ghost, .outlined, .tinted]
        let states = [ButtonState.enabled, .disabled]

        for state in states {
            for variant in variants {
                // Given
                let viewModel = sut(state: state, variant: variant)

                // Then
                XCTAssertEqual(variant, viewModel.variant, "wrong state")
                XCTAssertEqual(viewModel.intentColor, .primary, "wrong intent color")
                XCTAssertNotNil(viewModel.theme, "no theme set")
                XCTAssertNotNil(viewModel.colors, "no colors set")

                XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                                   self.theme,
                                   "Wrong typography value")

                XCTAssertEqual(viewModel.text, "Text", "text does not match")
            }
        }
    }

    func test_has_icon() throws {
        let image = UIImage()
        let icons = [ButtonIcon.none, .iconOnly(icon: image), .leading(icon: image), .trailing(icon: image)]
        let values = icons.map {
            let viewModel = sut(state: .enabled, variant: .filled)
            viewModel.icon = $0
            return viewModel.hasIcon
        }
        XCTAssertEqual(values, [false, true, true, true])
    }

    func test_has_text() throws {
        let image = UIImage()
        let icons = [ButtonIcon.none, .iconOnly(icon: image), .leading(icon: image), .trailing(icon: image)]
        let values = icons.map {
            let viewModel = sut(state: .enabled, variant: .filled)
            viewModel.icon = $0
            return viewModel.hasText
        }
        XCTAssertEqual(values, [true, false, true, true])
    }

    func test_opacity() throws {
        // Given
        let opacities = self.sutValues(for: \.opacity)

        // Then
        XCTAssertEqual(opacities, [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3], "opacity does not match")
    }

    func test_interactionEnabled() {
        // Given
        let disabledStates = self.sutValues(for: \.interactionEnabled)

        // Then
        XCTAssertEqual(disabledStates, [true, true, true, true, true, true, false, false, false, false, false, false], "interaction enabled does not match")
    }

    // MARK: - Private Helper Functions
    private func sutValues<T>(for keyPath: KeyPath<ButtonViewModel, T>) -> [T] {
        return allButtonConfigurations()
            .map(sut(state:variant:))
            .map{ $0[keyPath: keyPath] }
    }

    private func allButtonConfigurations() -> [(ButtonState, ButtonVariant)] {
        let statesToTest = [ButtonState.enabled, .disabled]
        let variantsToTest = [ButtonVariant.filled, .filled, .contrast, .ghost, .outlined, .tinted]

        var tuples: [(ButtonState, ButtonVariant)] = []
        for state in statesToTest {
            for variant in variantsToTest {
                tuples.append((state, variant))
            }
        }
        return tuples
    }

    private func sut(state: ButtonState, variant: ButtonVariant) -> ButtonViewModel {
        return ButtonViewModel(text: "Text", icon: .none, theme: self.theme, state: state, intentColor: .primary, variant: variant)
    }
}

// MARK: - Mock Theme

private extension Theme where Self == ThemeGeneratedMock {
    static var mock: Self {
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock()

        colors.states = ColorsStatesGeneratedMock.mocked()
        colors.base = ColorsBaseGeneratedMock.mocked()
        colors.primary = ColorsPrimaryGeneratedMock.mocked()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()
        theme.colors = colors
        theme.dims = DimsGeneratedMock.mocked()

        return theme
    }
}
