//
//  TabItemUIViewTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class TabItemUIViewTests: TestCase {

    let theme = SparkTheme.shared
    var sut: TabItemUIView!
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        self.sut = TabItemUIView(
            theme: theme,
            intent: .main,
            content: .init(icon: .init(systemName: "trash"),
                           title: "Label")
        )
    }

    func test_theme_change_triggers_attributes_change() {
        // Given
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2

        self.sut.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
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

        self.sut.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
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

        self.sut.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.tabSize = .xs

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_setting_selected_triggers_other_segment_selected() {
        // Given
        let badge = UIView()
        self.sut.badge = badge
        let expect = expectation(description: "Content not to be changed")

        let action = UIAction{ _ in
            expect.fulfill()
        }

        self.sut.addAction(action, for: .otherSegmentSelected)

        // When
        self.sut.isSelected = true

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_setting_not_selected_doesnt_trigger_other_segment_selected() {
        // Given
        let badge = UIView()
        self.sut.badge = badge
        let expect = expectation(description: "Content not to be changed")
        expect.isInverted = true

        let action = UIAction{ _ in
            expect.fulfill()
        }

        self.sut.addAction(action, for: .otherSegmentSelected)

        // When
        self.sut.isSelected = false

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_set_enabled_triggers_attributes_change() {
        // Given
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2
        self.sut.isEnabled = false

        self.sut.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.isEnabled = true

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_when_pressed_attributes_change() {
        // Given
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2

        self.sut.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.isHighlighted = true

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_when_pressed_action_sent() {
        // Given
        let touchDownExpectation = expectation(description: "TouchDown action sent")
        let action = UIAction{ _ in
            touchDownExpectation.fulfill()
        }

        self.sut.addAction(action, for: .touchDown)

        // When
        self.sut.sendActions(for: .touchDown)

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_when_touch_ends_attributes_change() {
        // Given
        self.sut.viewModel.isPressed = true
        let expect = expectation(description: "Attributes should be changed")
        expect.expectedFulfillmentCount = 2

        self.sut.viewModel.$tabStateAttributes.subscribe(in: &self.subscriptions) { _ in
            expect.fulfill()
        }

        // When
        self.sut.isHighlighted = false

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_when_touch_ends_action_sent() {
        // Given
        let touchDownExpectation = expectation(description: "TouchDown action sent")
        let action = UIAction{ _ in
            touchDownExpectation.fulfill()
        }
        let actionExpectation = expectation(description: "Class action sent")
        
        self.sut.action = UIAction{ _ in
            actionExpectation.fulfill()
        }

        self.sut.addAction(action, for: .touchUpInside)

        // When
        self.sut.sendActions(for: .touchUpInside)

        // Then
        waitForExpectations(timeout: 1)
    }

    func test_when_touch_cancelled_action_sent() {
        // Given
        let expect = expectation(description: "Touch cancel action sent")
        let action = UIAction{ _ in
            expect.fulfill()
        }

        self.sut.addAction(action, for: .touchCancel)

        // When
        self.sut.sendActions(for: .touchCancel)

        // Then
        waitForExpectations(timeout: 1)
    }
}
