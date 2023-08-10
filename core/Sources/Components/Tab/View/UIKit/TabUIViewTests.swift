//
//  TabUIViewTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import Spark
@testable import SparkCore
import XCTest

final class TabUIViewTests: TestCase {
    var sut: TabUIView!
    var subscriptions = Set<AnyCancellable>()

    override func setUp()  {
        super.setUp()

        self.sut = TabUIView(theme: SparkTheme.shared, texts: ["Tab 1", "Tab 2", "Tab 3"])
    }

    func test_theme_change_triggers_attributes_change() {
        // Given
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2

        self.sut.segments[0].viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.theme = SparkTheme.shared

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_intent_change_triggers_attributes_change() {
        // Given
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2

        self.sut.segments[0].viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.intent = .support

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_size_change_triggers_attributes_change() {
        // Given
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2

        self.sut.segments[0].viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.tabSize = .xs

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_set_enable_sets_state_for_each_segment() {
        // When
        self.sut.isEnabled = false

        XCTAssertFalse(self.sut.segments[0].isEnabled, "Segment 1 should be disabled")
        XCTAssertFalse(self.sut.segments[1].isEnabled, "Segment 2 should be disabled")
        XCTAssertFalse(self.sut.segments[2].isEnabled, "Segment 3 should be disabled")
    }
}
