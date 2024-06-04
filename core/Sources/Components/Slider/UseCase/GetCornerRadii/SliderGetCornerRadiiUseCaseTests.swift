//
//  SliderGetCornerRadiiUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import SparkThemingTesting

final class SliderGetCornerRadiiUseCaseTests: XCTestCase {

    private let theme: Theme = ThemeGeneratedMock.mocked()

    func test_execute_shape_rounded() {
        // GIVEN
        let sut = SliderGetCornerRadiiUseCase()
        let expectedRadii = SliderRadii(
            trackRadius: self.theme.border.radius.small,
            indicatorRadius: self.theme.border.radius.small
        )

        // WHEN
        let radii = sut.execute(theme: self.theme, shape: .rounded)

        // THEN
        XCTAssertEqual(radii, expectedRadii)
    }

    func test_execute_shape_square() {
        // GIVEN
        let sut = SliderGetCornerRadiiUseCase()
        let expectedRadii = SliderRadii(
            trackRadius: self.theme.border.radius.none,
            indicatorRadius: self.theme.border.radius.none
        )

        // WHEN
        let radii = sut.execute(theme: self.theme, shape: .square)

        // THEN
        XCTAssertEqual(radii, expectedRadii)
    }
}
