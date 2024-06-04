//
//  SliderColorsTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import SparkThemingTesting

final class SliderColorsTests: XCTestCase {

    private let colors: Colors = ColorsGeneratedMock.mocked()
    private let dims: Dims = DimsGeneratedMock.mocked()

    func test_withOpacity() {
        // GIVEN
        let track = self.colors.feedback.alertContainer
        let indicator = self.colors.states.accentVariantPressed.opacity(self.dims.dim5)
        let handle = self.colors.main.onMainContainer
        let handleActiveIndicator = self.colors.base.surface
        let sut = SliderColors(
            track: track,
            indicator: indicator,
            handle: handle,
            handleActiveIndicator: handleActiveIndicator
        )
        let dim = self.dims.dim3
        let expectedResult = SliderColors(
            track: track.opacity(dim),
            indicator: indicator.opacity(dim),
            handle: handle.opacity(dim),
            handleActiveIndicator: handleActiveIndicator.opacity(dim)
        )

        // WHEN
        let result = sut.withOpacity(dim)

        // THEN
        XCTAssertEqual(result, expectedResult)
    }

}
