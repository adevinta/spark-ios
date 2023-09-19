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

        self.sut = TabUIView(theme: SparkTheme.shared, titles: ["Tab 1", "Tab 2", "Tab 3"])
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

    func test_set_attributes_should_work() {
        // Given
        let image = UIImage()
        // When
        self.sut.setTitle("Hello", forSegmentAt: 2)
        self.sut.setImage(image, forSegmentAt: 2)

        XCTAssertEqual(self.sut.segments[2].title, "Hello", "Expected title on tab to be set correctly")
        XCTAssertEqual(self.sut.segments[2].icon, image, "Expected icon on tab to be set correctly")

        XCTAssertEqual(self.sut.titleForSegment(at: 2), "Hello", "Expected same result as accessing text of element directly")
        XCTAssertEqual(self.sut.imageForSegment(at: 2), image, "Expected same result as accessing icon of element directly")
    }

    func test_tab_change_is_published() {
        // Given
        let expect = expectation(description: "Expect publisher to publish new selected tab")
        var tabTapped = 0
        self.sut.publisher.sink { selectedTab in
            tabTapped = selectedTab
            expect.fulfill()
        }.store(in: &self.subscriptions)

        // When
        self.sut.segments[2].touchesEnded([UITouch()], with: nil)

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(tabTapped, 2, "Expected tapped tab to be 2.")
    }

    func test_tab_change_is_not_published_when_set() {
        // Given
        let expect = expectation(description: "Expect publisher not to be called")
        expect.isInverted = true

        self.sut.publisher.sink { (selectedTab: Int) in
            expect.fulfill()
        }.store(in: &self.subscriptions)

        // When
        self.sut.selectedSegmentIndex = 2

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_tab_change_is_sent_to_delegate() {
        // Given
        let delegate = TabUIViewDelegateGeneratedMock()
        self.sut.delegate = delegate

        // When
        self.sut.segments[2].touchesEnded([UITouch()], with: nil)

        // Then
        XCTAssertEqual(
            delegate.segmentSelectedWithIndexAndSenderCallsCount,
            1,
            "Expected delegate to be called.")
        XCTAssertEqual(
            delegate.segmentSelectedWithIndexAndSenderReceivedArguments?.index,
            2,
            "Expected delegate to have correct arguments"
        )
    }

    func test_tab_change_action_value_changed() {
        // Given
        let expect = expectation(description: "Expect action to be executed")

        let action = UIAction { _ in
            expect.fulfill()
        }

        self.sut.addAction(action, for: .valueChanged)

        // When
        self.sut.segments[2].touchesEnded([UITouch()], with: nil)

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(self.sut.selectedSegmentIndex, 2, "Selected segment should be 2")
    }

    func test_setting_selected_state_on_tab_unselects_other() {
        // Given
        let expect = expectation(description: "Expect action to be executed")

        let action = UIAction { _ in
            expect.fulfill()
        }

        self.sut.segments[2].addAction(action, for: .otherSegmentSelected)

        // When
        self.sut.segments[2].isSelected = true

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertFalse(self.sut.segments[0].isSelected, "Segment 0 should not be selected")
        XCTAssertTrue(self.sut.segments[2].isSelected, "Segment 2 should be selected")
        XCTAssertEqual(self.sut.selectedSegmentIndex, 2, "Selected item should be 2")
    }

    func test_action_is_executed() {
        // Given
        let expect = expectation(description: "Expect action to be executed")
        let action = UIAction { _ in
            expect.fulfill()
        }

        self.sut.setAction(action, forSegmentAt: 2)

        // When
        self.sut.segments[2].touchesEnded([UITouch()], with: nil)

        // Then
        waitForExpectations(timeout: 1)
        XCTAssertIdentical(self.sut.actionForSegment(at: 2), action, "Action should be set")
        XCTAssertEqual(self.sut.segmentIndex(identifiedBy: action.identifier), 2, "Expect correct segment to be identified.")
    }

    func test_insert_with_image() {
        // Given
        let image = UIImage()

        // When
        self.sut.insertSegment(with: image, at: 0)

        XCTAssertIdentical(self.sut.imageForSegment(at: 0), image, "Should contain new segment")
        XCTAssertEqual(self.sut.segments.count, 4, "An extra segment has been added.")
        XCTAssertTrue(self.sut.segment(at: 1)!.isSelected, "The old selected has moved.")
    }

    func test_insert_with_text() {
        // When
        self.sut.insertSegment(with: "New Tab", at: 0)

        XCTAssertEqual(self.sut.titleForSegment(at: 0), "New Tab", "Should contain new segment")
    }

    func test_insert_with_text_and_image() {
        // Given
        let image = UIImage()

        // When
        self.sut.insertSegment(withImage: image, andTitle: "New Tab", at: 0)

        XCTAssertEqual(self.sut.titleForSegment(at: 0), "New Tab", "Should contain new segment")
        XCTAssertIdentical(self.sut.imageForSegment(at: 0), image, "Should contain new segment")
    }

    func test_set_enabled() {
        // When
        self.sut.setEnabled(false, at: 0)

        XCTAssertFalse(self.sut.isEnabledForSegment(at: 0), "Segment 0 should be disabled")
    }

    func test_remove_all_segments() {
        // When
        self.sut.removeAllSegments()

        XCTAssertTrue(self.sut.segments.isEmpty, "Expected to have no segments")
    }

    func test_remove_first_segment() {
        // When
        self.sut.removeSegment(at: 0, animated: false)

        XCTAssertEqual(self.sut.segments.count, 2, "Segment expected to be removed")
    }
}

