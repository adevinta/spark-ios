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
            theme: self.theme,
            intent: .basic,
            variant: .tinted,
            state: .default)

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
            theme: self.theme,
            intent: .basic,
            variant: .outlined,
            state: .default)

        // THEN
        XCTAssertEqual(tabColors, expectedColors)
    }

    func test_colors_disabled() {
        // GIVEN
        let colors = self.theme.colors
        let dims = self.theme.dims

        let useCaseColors = ProgressTrackerColors(
            background: colors.main.mainContainer,
            outline: colors.main.main,
            content: colors.main.main)

        let expectedColors = ProgressTrackerColors(
            background: useCaseColors.background.opacity(dims.dim2),
            outline: useCaseColors.outline.opacity(dims.dim2),
            content: useCaseColors.content.opacity(dims.dim2)
        )

        self.outlinedUseCase.executeWithColorsAndIntentAndStateReturnValue = useCaseColors

        // WHEN
        let tabColors = self.sut.execute(
            theme: self.theme,
            intent: .basic,
            variant: .outlined,
            state: .disabled)

        // THEN
        XCTAssertEqual(tabColors, expectedColors)
    }

}
