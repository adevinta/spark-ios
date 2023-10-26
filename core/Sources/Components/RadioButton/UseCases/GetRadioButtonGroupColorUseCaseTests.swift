//
//  GetRadioButtonGroupColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 06.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class GetRadioButtonGroupColorUseCaseTests: XCTestCase {

    var sut: GetRadioButtonGroupColorUseCase!
    var colors: ColorsGeneratedMock!

    override func setUp() {
        super.setUp()

        self.sut = GetRadioButtonGroupColorUseCase()
        self.colors = ColorsGeneratedMock.mocked()
    }
    // MARK: - Tests

    func test_alert() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .alert)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.alert.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.alert.color)
    }

    func test_danger() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .danger)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.error.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.error.color)
    }

    func test_success() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .success)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.success.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.success.color)
    }

    func test_basic() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .basic)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.basic.basic.uiColor)
        XCTAssertEqual(colorToken.color, colors.basic.basic.color)
    }

    func test_accent() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .accent)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.accent.accent.uiColor)
        XCTAssertEqual(colorToken.color, colors.accent.accent.color)
    }

    func test_main() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .main)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.main.main.uiColor)
        XCTAssertEqual(colorToken.color, colors.main.main.color)
    }

    func test_support() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .support)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.support.support.uiColor)
        XCTAssertEqual(colorToken.color, colors.support.support.color)
    }

    func test_info() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .info)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.info.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.info.color)
    }

    func test_neutral() {
        // When
        let colorToken = sut.execute(colors: colors, intent: .neutral)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.neutral.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.neutral.color)
    }

}
