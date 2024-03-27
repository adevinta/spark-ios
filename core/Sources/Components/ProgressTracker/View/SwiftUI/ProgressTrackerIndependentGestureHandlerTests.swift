//
//  ProgressTrackerIndependentGestureHandlerTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 27.03.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI
import XCTest

@testable import SparkCore

final class ProgressTrackerIndependentGestureHandlerTests: XCTestCase {

    var _currentPageIndex: Int = 0

    lazy var currentPageIndex = Binding<Int>(
        get: { return self._currentPageIndex },
        set: { self._currentPageIndex = $0 }
    )

    private var _currentTouchedPageIndex: Int? = nil

    lazy var currentTouchedPageIndex = Binding<Int?>(
        get: { return self._currentTouchedPageIndex },
        set: { self._currentTouchedPageIndex = $0 }
    )

    private var indicators = (0...3).map{ CGRect(x: $0 * 40, y: 0, width: 40, height: 40)}

    private var disabledIndices = Set<Int>()

    // MARK: - Tests
    func test_index_0_is_current_3_may_be_selected() {
        // Given
        self._currentPageIndex = 0
        let sut = self.sut()

        // When
        sut.onChanged(location: CGPoint(x: 140, y: 0))

        // Then
        XCTAssertEqual(self._currentTouchedPageIndex, 3, "Next select page is 1")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")

        // When
        sut.onEnded(location: CGPoint(x: 140, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Next select page is nil")
        XCTAssertEqual(self._currentPageIndex, 3, "Current page is not updated")
    }

    func test_index_3_is_current_0_may_be_selected() {
        // Given
        self._currentPageIndex = 3
        let sut = self.sut()

        // When
        sut.onChanged(location: CGPoint(x: 0, y: 0))

        // Then
        XCTAssertEqual(self._currentTouchedPageIndex, 0, "Next select page is 1")
        XCTAssertEqual(self._currentPageIndex, 3, "Current page is not updated")

        // When
        sut.onEnded(location: CGPoint(x: 0, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Next select page is nil")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")
    }

    func test_can_skip_disabled() {
        // Given
        self._currentPageIndex = 0
        self.disabledIndices.insert(1)
        let sut = self.sut()

        // When
        sut.onChanged(location: CGPoint(x: 81, y: 0))

        // Then
        XCTAssertEqual(self._currentTouchedPageIndex, 2, "Current touched page is 2")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")

        // When
        sut.onEnded(location: CGPoint(x: 81, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Next select page is nil")
        XCTAssertEqual(self._currentPageIndex, 2, "Current page is not updated")
    }

    func test_touch_outside_frame_ignored() {
        // Given
        self._currentPageIndex = 0
        self.disabledIndices.insert(1)
        let sut = self.sut()

        // When
        sut.onChanged(location: CGPoint(x: 161, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Current touched page is nil")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")

        // When
        sut.onEnded(location: CGPoint(x: 161, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Next select page is nil")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")
    }

    func test_disabled_cant_be_selected() {
        // Given
        self._currentPageIndex = 0
        self.disabledIndices.insert(2)
        let sut = self.sut()

        // When
        sut.onChanged(location: CGPoint(x: 81, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Current touched page is nil")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")

        // When
        sut.onEnded(location: CGPoint(x: 81, y: 0))

        // Then
        XCTAssertNil(self._currentTouchedPageIndex, "Next select page is nil")
        XCTAssertEqual(self._currentPageIndex, 0, "Current page is not updated")
    }

    // MARK: Private helpers
    private func sut() -> ProgressTrackerIndependentGestureHandler {
        return .init(
            currentPageIndex: self.currentPageIndex,
            currentTouchedPageIndex: self.currentTouchedPageIndex,
            indicators: self.indicators,
            frame: CGRect(x: 0, y: 0, width: self.indicators.count * 40, height: 40),
            disabledIndices: self.disabledIndices)
    }
}
