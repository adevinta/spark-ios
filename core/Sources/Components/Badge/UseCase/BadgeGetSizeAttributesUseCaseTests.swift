//
//  BadgeGetSizeAttributesUseCase.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 03.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class BadgeGetSizeAttributesUseCaseTests: XCTestCase {

    // MARK: - Properties
    var sut: BadgeGetSizeAttributesUseCase!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUp()  {
        super.setUp()
        self.theme = .mocked()
        self.sut = BadgeGetSizeAttributesUseCase()
    }

    // MARK: - Tests
    func test_size_small() throws {
        let attributes = sut.execute(theme: self.theme, size: .small)

        let expectedAttributes = BadgeSizeDependentAttributes(
            offset: .init(vertical: 0, horizontal: 3),
            height: 16,
            font: self.theme.typography.smallHighlight)

        XCTAssertEqual(attributes, expectedAttributes)
    }

    func test_size_normal() throws {
        let attributes = sut.execute(theme: self.theme, size: .medium)

        let expectedAttributes = BadgeSizeDependentAttributes(
            offset: .init(vertical: 3, horizontal: 5),
            height: 24,
            font: self.theme.typography.captionHighlight)

        XCTAssertEqual(attributes, expectedAttributes)
    }
}
