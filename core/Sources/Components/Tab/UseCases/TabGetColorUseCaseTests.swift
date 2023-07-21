//
//  TabGetColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by alican.aycil on 21.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class TabGetColorUseCaseTests: TestCase {
    
    // MARK: - Private properties
    private var sut: TabGetColorUseCase!
    private var colors: ColorsGeneratedMock!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.sut = TabGetColorUseCase()
        self.colors = ColorsGeneratedMock.mocked()
    }
    
    // MARK: - Tests
    func test_execute_primary() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .primary).color, self.colors.primary.primary.color)
    }
    
    func test_execute_secondary() {
        XCTAssertEqual(self.sut.execute(colors: self.colors, intent: .secondary).color, self.colors.secondary.secondary.color)
    }
}
