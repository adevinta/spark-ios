//
//  ProgressTrackerGetSpacingsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ProgressTrackerGetSpacingsUseCaseTests: XCTestCase {

    // MARK: Properties
    var sut: ProgressTrackerGetSpacingsUseCase!
    var spacing: LayoutSpacing!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.spacing = LayoutSpacingGeneratedMock.mocked()
        self.sut = ProgressTrackerGetSpacingsUseCase()
    }

    // MARK: - Tests
    func test_horizontal_spacing() {
        let spacing = self.sut.execute(spacing: self.spacing, orientation: .horizontal)

        XCTAssertEqual(spacing, .init(trackIndicatorSpacing: 3.0, minLabelSpacing: 5.0))
    }

    func test_vertical_spacing() {
        let spacing = self.sut.execute(spacing: self.spacing, orientation: .vertical)

        XCTAssertEqual(spacing, .init(trackIndicatorSpacing: 3.0, minLabelSpacing: 5.0))
    }
}
