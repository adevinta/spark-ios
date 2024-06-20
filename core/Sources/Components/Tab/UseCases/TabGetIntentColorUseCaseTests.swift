//
//  TabGetIntentColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class TabGetIntentColorUseCaseTests: XCTestCase {

    // MARK: - Private properties
    private var sut: TabGetIntentColorUseCase!
    private var colors: ColorsGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.sut = TabGetIntentColorUseCase()
        self.colors = ColorsGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_execute_main() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .main).color, self.colors.main.main.color)
    }

    func test_execute_support() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .support).color, self.colors.support.support.color)
    }

    func test_execute_basic() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .basic).color, self.colors.basic.basic.color)
    }
}
