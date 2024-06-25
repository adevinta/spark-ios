//
//  ChipUIViewTests.swift
//  SparkCoreSnapshotTests
//
//  Created by michael.zimmermann on 11.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class ChipUIViewTests: TestCase {

    var sut: ChipUIView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = ChipUIView(theme: SparkTheme.shared,
                              intent: .basic,
                              variant: .outlined,
                              label: "Title")
    }

    func test_when_touch_action_set_then_has_action() throws {
        let action = UIAction{ _ in }

        self.sut.addAction(action, for: .touchUpInside)

        XCTAssertTrue(self.sut.hasAction)
    }

    func test_when_action_set_then_has_action() throws {
        // Given
        let actionExpectation = expectation(description: "Expect action to be executed")

        self.sut.action = {
            actionExpectation.fulfill()
        }

        // When
        sut.sendActions(for: .touchUpInside)

        // Then
        XCTAssertTrue(self.sut.hasAction)

        wait(for: [actionExpectation], timeout: 0.1)
    }

    func test_when_no_action_set_then_has_action() throws {
        sut.action = { }
        sut.action = nil
        XCTAssertFalse(self.sut.hasAction)
    }

}
