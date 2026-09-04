//
//  XXXGetContentColorsUseCaseTests.swift
//  SparkComponentXXXTests
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

@testable import SparkComponentXXX
@_spi(SI_SPI) import SparkTheming
@_spi(SI_SPI) import SparkThemingTesting
import Testing

@Suite("XXX Get Content Colors Use Case Tests")
struct XXXGetContentColorsUseCaseTests {

    // MARK: - Properties

    let sut: XXXGetContentColorsUseCase
    let theme: ThemeGeneratedMock

    // MARK: - Initialization

    init() {
        self.theme = .mocked()
        self.sut = XXXGetContentColorsUseCase()
    }

    // MARK: - Tests

    @Test("Is pressed false")
    func isPressedFalse() throws {
        // GIVEN / WHEN
        let colors = sut.execute(theme: self.theme, intent: .support, isSelected: true, isPressed: false)

        // THEN
        #expect(colors.backgroundColorToken.equals(ColorTokenClear()))
    }

    @Test("Is pressed true")
    func isPressedTrue() throws {
        // GIVEN / WHEN
        let colors = sut.execute(theme: self.theme, intent: .support, isSelected: true, isPressed: true)

        // THEN
        #expect(colors.backgroundColorToken.equals(self.theme.colors.states.surfacePressed))
    }

    @Test("Is selected false")
    func isSelectedFalse() throws {
        // GIVEN / WHEN
        let colors = sut.execute(theme: self.theme, intent: .support, isSelected: false, isPressed: false)

        // THEN
        #expect(colors.tintColorToken.equals(self.theme.colors.base.onSurface))
    }

    @Test("Is selected true intent main")
    func isSelectedTrueIntentMain() throws {
        // GIVEN / WHEN
        let colors = sut.execute(theme: self.theme, intent: .main, isSelected: true, isPressed: false)

        // THEN
        #expect(colors.tintColorToken.equals(self.theme.colors.main.main))
    }

    @Test("Is selected true intent support")
    func isSelectedTrueIntentSupport() throws {
        // GIVEN / WHEN
        let colors = sut.execute(theme: self.theme, intent: .support, isSelected: true, isPressed: false)

        // THEN
        #expect(colors.tintColorToken.equals(self.theme.colors.support.support))
    }
}
