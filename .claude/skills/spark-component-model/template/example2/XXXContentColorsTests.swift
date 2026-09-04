//
//  XXXContentColorsTests.swift
//  SparkComponentXXXTests
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import SwiftUI
import Testing
@testable import SparkComponentXXX
@_spi(SI_SPI) import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting

@Suite("XXX Content Colors Tests")
struct XXXContentColorsTests {

    // MARK: - Tests

    @Test("Default initialization")
    func defaultInitialization() {
        // GIVEN / WHEN
        let colors = XXXContentColors()

        // THEN
        #expect(colors.tintColorToken.equals(ColorTokenClear()))
        #expect(colors.backgroundColorToken.equals(ColorTokenClear()))
    }

    @Test("Equality when same colors")
    func equalityWhenSameColors() {
        // GIVEN / WHEN
        let tintColorToken = ColorTokenGeneratedMock.random()
        let backgroundColorToken = ColorTokenGeneratedMock.random()

        let colors1 = XXXContentColors(
            tintColorToken: tintColorToken,
            backgroundColorToken: backgroundColorToken
        )

        let colors2 = XXXContentColors(
            tintColorToken: tintColorToken,
            backgroundColorToken: backgroundColorToken
        )

        // THEN
        #expect(colors1 == colors2)
    }

    @Test("Inequality when different tint color token")
    func inequalityWhenDifferentTintColorToken() {
        // GIVEN / WHEN
        let tintColorToken1 = ColorTokenGeneratedMock.random()
        let tintColorToken2 = ColorTokenGeneratedMock.random()
        let backgroundColorToken = ColorTokenGeneratedMock.random()

        let colors1 = XXXContentColors(
            tintColorToken: tintColorToken1,
            backgroundColorToken: backgroundColorToken
        )

        let colors2 = XXXContentColors(
            tintColorToken: tintColorToken2,
            backgroundColorToken: backgroundColorToken
        )

        // THEN
        #expect(colors1 != colors2)
    }

    @Test("Inequality when different background color token")
    func inequalityWhenDifferentBackgroundColorToken() {
        // GIVEN / WHEN
        let tintColorToken = ColorTokenGeneratedMock.random()
        let backgroundColorToken1 = ColorTokenGeneratedMock.random()
        let backgroundColorToken2 = ColorTokenGeneratedMock.random()

        let colors1 = XXXContentColors(
            tintColorToken: tintColorToken,
            backgroundColorToken: backgroundColorToken1
        )

        let colors2 = XXXContentColors(
            tintColorToken: tintColorToken,
            backgroundColorToken: backgroundColorToken2
        )

        // THEN
        #expect(colors1 != colors2)
    }
}
