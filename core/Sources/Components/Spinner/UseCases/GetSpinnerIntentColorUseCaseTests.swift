//
//  GetSpinnerIntentColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 11.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class GetSpinnerIntentColorUseCaseTests: TestCase {

    // MARK: - Private properties
    private var sut: GetSpinnerIntentColorUseCase!
    private var colors: ColorsGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.sut = GetSpinnerIntentColorUseCase()
        self.colors = ColorsGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_execute_primary() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .primary).color, self.colors.primary.primary.color)
    }

    func test_execute_secondary() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .secondary).color, self.colors.secondary.secondary.color)
    }

    func test_execute_alert() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .alert).color, self.colors.feedback.alert.color)
    }

    func test_execute_error() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .error).color, self.colors.feedback.error.color)
    }

    func test_execute_info() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .info).color, self.colors.feedback.info.color)
    }

    func test_execute_neutral() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .neutral).color, self.colors.feedback.neutral.color)
    }

    func test_execute_success() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .success).color, self.colors.feedback.success.color)
    }
}
