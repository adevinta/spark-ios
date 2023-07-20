//
//  GetDisplayedTextTypeUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class GetDisplayedTextTypeUseCaseTests: XCTestCase {

    // MARK: - Tests Execute with text and attributedText

    func test_execute_with_text_and_attributedText_parameters() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            text: "Hello",
            attributedText: .left(.init(string: "Holà"))
        )

        // THEN
        XCTAssertEqual(displayedTextType, .attributedText)
    }

    func test_execute_with_text_and_nil_attributedText_parameters() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            text: "Hello",
            attributedText: nil
        )

        // THEN
        XCTAssertEqual(displayedTextType, .text)
    }

    func test_execute_with_nil_text_and_attributedText_parameters() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            text: nil,
            attributedText: .left(.init(string: "Holà"))
        )

        // THEN
        XCTAssertEqual(displayedTextType, .attributedText)
    }

    func test_execute_with_nil_text_and_nil_attributedText_parameters() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            text: nil,
            attributedText: nil
        )

        // THEN
        XCTAssertEqual(displayedTextType, .none)
    }

    // MARK: - Tests Execute with only text

    func test_execute_with_text_parameter() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            text: "Hello"
        )

        // THEN
        XCTAssertEqual(displayedTextType, .text)
    }

    func test_execute_with_nil_text_parameter() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            text: nil
        )

        // THEN
        XCTAssertEqual(displayedTextType, .none)
    }

    // MARK: - Tests Execute with only attributed text

    func test_execute_with_attributedText_parameter() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            attributedText: .left(.init(string: "Holà"))
        )

        // THEN
        XCTAssertEqual(displayedTextType, .attributedText)
    }

    func test_execute_with_nil_attributedText_parameter() {
        // GIVEN
        let useCase = GetDisplayedTextTypeUseCase()

        // WHEN
        let displayedTextType = useCase.execute(
            attributedText: nil
        )

        // THEN
        XCTAssertEqual(displayedTextType, .none)
    }
}
