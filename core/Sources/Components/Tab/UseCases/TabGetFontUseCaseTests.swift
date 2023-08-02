//
//  TabGetFontUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 02.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class TabGetFontUseCaseTests: TestCase {

    // MARK: - Properties
    var typography: TypographyGeneratedMock!
    var sut: TabGetFontUseCase!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.typography = TypographyGeneratedMock.mocked()
        self.sut = TabGetFontUseCase()
    }

    // MARK: - Tests
    func test_size_md() throws {
        let font = sut.execute(typography: self.typography, size: .md)

        XCTAssertEqual(font.font, typography.body1.font)
    }

    func test_size_xs() throws {
        let font = sut.execute(typography: self.typography, size: .xs)

        XCTAssertEqual(font.font, typography.caption.font)
    }

    func test_size_sm() throws {
        let font = sut.execute(typography: self.typography, size: .sm)

        XCTAssertEqual(font.font, typography.body2.font)
    }

}
