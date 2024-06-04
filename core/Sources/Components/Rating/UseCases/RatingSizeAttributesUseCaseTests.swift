//
//  RatingSizeAttributesUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import SparkThemingTesting

final class RatingSizeAttributesUseCaseTests: XCTestCase {

    var spacing: LayoutSpacingGeneratedMock!
    var sut: RatingSizeAttributesUseCase!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.spacing = LayoutSpacingGeneratedMock.mocked()
        self.sut = RatingSizeAttributesUseCase()
    }

    // MARK: - Tests
    func test_small() {
        // When
        let sizes = sut.execute(spacing: self.spacing, size: .small)

        // Then
        XCTAssertEqual(sizes, .init(borderWidth: 1.0, height: 12.0, spacing: 3.0))
    }

    func test_medium() {
        // When
        let sizes = sut.execute(spacing: self.spacing, size: .medium)

        // Then
        XCTAssertEqual(sizes, .init(borderWidth: 1.33, height: 16.0, spacing: 3.0))
    }

    func test_large() {
        // When
        let sizes = sut.execute(spacing: self.spacing, size: .large)

        // Then
        XCTAssertEqual(sizes, .init(borderWidth: 2.0, height: 24.0, spacing: 3.0))
    }

    func test_input() {
        // When
        let sizes = sut.execute(spacing: self.spacing, size: .input)

        // Then
        XCTAssertEqual(sizes, .init(borderWidth: 3.33, height: 40.0, spacing: 5.0))
    }
}
