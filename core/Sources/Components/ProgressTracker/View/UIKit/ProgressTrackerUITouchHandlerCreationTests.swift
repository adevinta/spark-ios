//
//  ProgressTrackerUITouchHandlerCreationTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ProgressTrackerUITouchHandlerCreationTests: XCTestCase {
    var controls: [UIControl]!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.controls = (0...4)
            .map { index in
                return CGRect(x: index * 50, y: 0, width: 50, height: 50)
            }
            .map(UIControl.init(frame:))
    }

    // MARK: - Tests
    func test_setup_none() {
        let sut = ProgressTrackerInteractionState.none.touchHandler(currentPageIndex: 0, indicatorViews: self.controls)

        XCTAssertTrue(sut is ProgressTrackerNoneUITouchHandler)
    }

    func test_setup_discrete() {
        let sut = ProgressTrackerInteractionState.discrete.touchHandler(currentPageIndex: 0, indicatorViews: self.controls)

        XCTAssertTrue(sut is ProgressTrackerDiscreteUITouchHandler)
    }

    func test_setup_continuous() {
        let sut = ProgressTrackerInteractionState.continuous.touchHandler(currentPageIndex: 0, indicatorViews: self.controls)

        XCTAssertTrue(sut is ProgressTrackerContinuousUITouchHandler)
    }

    func test_setup_independent() {
        let sut = ProgressTrackerInteractionState.independent.touchHandler(currentPageIndex: 0, indicatorViews: self.controls)

        XCTAssertTrue(sut is ProgressTrackerIndependentUITouchHandler)
    }

}
