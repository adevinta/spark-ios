//
//  RadioButtonUIItemTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 31.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class RadioButtonUIItemTests: XCTestCase {

    // MARK: - Tests
    func test_equal() {
        let sut = RadioButtonUIItem(id: 1, label: "Label")

        XCTAssertEqual(sut, RadioButtonUIItem(id: 1, label: "Label"))
    }

    func test_equal_attributed() {
        let sut = RadioButtonUIItem(id: 1, label: NSAttributedString(string: "Label"))

        XCTAssertEqual(sut, RadioButtonUIItem(id: 1, label: "Label"))
    }

    func test_not_equal_different_ids() {
        let sut = RadioButtonUIItem(id: 1, label: "Label")

        XCTAssertNotEqual(sut, RadioButtonUIItem(id: 2, label: "Label"))
    }

    func test_not_equal_different_labels() {
        let sut = RadioButtonUIItem(id: 1, label: "Label")

        XCTAssertNotEqual(sut, RadioButtonUIItem(id: 2, label: ""))
    }
}
