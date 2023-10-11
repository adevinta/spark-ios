//
//  ChipStateTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 23.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class ChipStateTests: XCTestCase {

    func test_default() {
        let sut = ChipState.default

        XCTAssertTrue(sut.isEnabled, "By default enabled should be true.")
        XCTAssertFalse(sut.isDisabled, "Expected isDisabled to be the oposite of enabled.")
        XCTAssertFalse(sut.isPressed, "By default, the pressed state is not set")
        XCTAssertFalse(sut.isSelected, "By default, the selected state is not set")
    }

    func test_disabled() {
        let sut = ChipState(isEnabled: false, isPressed: true, isSelected: false)

        XCTAssertFalse(sut.isEnabled, "Expected the state not to be enabled.")
        XCTAssertTrue(sut.isDisabled, "Expected the state to be disabled.")
        XCTAssertTrue(sut.isPressed, "The pressed state should be true.")
    }

}
