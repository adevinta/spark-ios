//
//  ProgressTrackerGetColorsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 18.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import XCTest
@testable import SparkCore
import SparkThemingTesting

final class ProgressTrackerGetColorsUseCaseTests: XCTestCase {

    var sut: ProgressTrackerGetColorsUseCase!
    var theme: ThemeGeneratedMock!
    var outlinedUseCase: ProgressTrackerGetVariantColorsUseCaseableGeneratedMock!
    var tintedUseCase: ProgressTrackerGetVariantColorsUseCaseableGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()
        self.outlinedUseCase = ProgressTrackerGetVariantColorsUseCaseableGeneratedMock()
        self.tintedUseCase = ProgressTrackerGetVariantColorsUseCaseableGeneratedMock()
        let sut = ProgressTrackerGetColorsUseCase(
            getTintedColorsUseCase: self.tintedUseCase,
            getOutlinedColorsUseCase: self.outlinedUseCase
        )

        self.sut = sut
    }

    // MARK: - Tests
    func test_tinted_colors() {
        // GIVEN
        let colors = self.theme.colors
        let expectedColors = ProgressTrackerColors(
            background: colors.main.mainContainer,
            outline: colors.main.mainContainer,
            content: colors.main.onMainContainer)

        self.tintedUseCase.executeWithColorsAndIntentAndStateReturnValue = expectedColors

        // WHEN
        let tabColors = self.sut.execute(
            colors: colors,
            intent: .basic,
            variant: .tinted,
            state: .normal)

        // THEN
        XCTAssertEqual(tabColors, expectedColors)
    }

    func test_outlined_colors() {
        // GIVEN
        let colors = self.theme.colors
        let expectedColors = ProgressTrackerColors(
            background: colors.main.mainContainer,
            outline: colors.main.main,
            content: colors.main.main)

        self.outlinedUseCase.executeWithColorsAndIntentAndStateReturnValue = expectedColors

        // WHEN
        let tabColors = self.sut.execute(
            colors: colors,
            intent: .basic,
            variant: .outlined,
            state: .normal)

        // THEN
        XCTAssertEqual(tabColors, expectedColors)
    }
}
