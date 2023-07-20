//
//  GetDidDisplayedTextChangeUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class GetDidDisplayedTextChangeUseCaseTests: XCTestCase {

    // MARK: - Tests Execute with text

    func test_execute_when_currentText_is_equal_to_newText_and_displayedTextType_is_none() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: "Hello",
            newText: "Hello",
            displayedTextType: .none
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentText_is_equal_to_newText_and_displayedTextType_is_text() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: "Hello",
            newText: "Hello",
            displayedTextType: .text
        )

        // THEN
        XCTAssertFalse(isChanged)
    }

    func test_execute_when_currentText_is_equal_to_newText_and_displayedTextType_is_attributedText() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: "Hello",
            newText: "Hello",
            displayedTextType: .attributedText
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentText_is_not_equal_to_newText_and_displayedTextType_is_none() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: "Hello",
            newText: "Bye",
            displayedTextType: .none
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentText_is_not_equal_to_newText_and_displayedTextType_is_text() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: "Hello",
            newText: "Bye",
            displayedTextType: .text
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentText_is_not_equal_to_newText_and_displayedTextType_is_attributedText() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: "Hello",
            newText: "Bye",
            displayedTextType: .attributedText
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentText_and_newText_are_nil_and_displayedTextType_is_none() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: nil,
            newText: nil,
            displayedTextType: .none
        )

        // THEN
        XCTAssertFalse(isChanged)
    }

    func test_execute_when_currentText_and_newText_are_nil_and_displayedTextType_is_text() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: nil,
            newText: nil,
            displayedTextType: .text
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentText_and_newText_are_nil_and_displayedTextType_is_attributedText() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentText: nil,
            newText: nil,
            displayedTextType: .attributedText
        )

        // THEN
        XCTAssertFalse(isChanged)
    }
    
    // MARK: - Tests Execute with attributed text

    func test_execute_when_currentAttributedText_is_equal_to_newAttributedText_and_displayedTextType_is_none() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: .left(NSAttributedString(string: "Hello")),
            newAttributedText: .left(NSAttributedString(string: "Hello")),
            displayedTextType: .none
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentAttributedText_is_equal_to_newAttributedText_and_displayedTextType_is_text() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: .left(NSAttributedString(string: "Hello")),
            newAttributedText: .left(NSAttributedString(string: "Hello")),
            displayedTextType: .text
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentAttributedText_is_equal_to_newAttributedText_and_displayedTextType_is_attributedText() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: .left(NSAttributedString(string: "Hello")),
            newAttributedText: .left(NSAttributedString(string: "Hello")),
            displayedTextType: .attributedText
        )

        // THEN
        XCTAssertFalse(isChanged)
    }

    func test_execute_when_currentAttributedText_is_not_equal_to_newAttributedText_and_displayedTextType_is_none() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: .left(NSAttributedString(string: "Hello")),
            newAttributedText: .left(NSAttributedString(string: "Bye")),
            displayedTextType: .none
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentAttributedText_is_not_equal_to_newAttributedText_and_displayedTextType_is_text() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: .left(NSAttributedString(string: "Hello")),
            newAttributedText: .left(NSAttributedString(string: "Bye")),
            displayedTextType: .text
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentAttributedText_is_not_equal_to_newAttributedText_and_displayedTextType_is_attributedText() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: .left(NSAttributedString(string: "Hello")),
            newAttributedText: .left(NSAttributedString(string: "Bye")),
            displayedTextType: .attributedText
        )

        // THEN
        XCTAssertTrue(isChanged)
    }

    func test_execute_when_currentAttributedText_and_newAttributedText_are_nil_and_displayedTextType_is_none() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: nil,
            newAttributedText: nil,
            displayedTextType: .none
        )

        // THEN
        XCTAssertFalse(isChanged)
    }

    func test_execute_when_currentAttributedText_and_newAttributedText_are_nil_and_displayedTextType_is_text() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: nil,
            newAttributedText: nil,
            displayedTextType: .text
        )

        // THEN
        XCTAssertFalse(isChanged)
    }

    func test_execute_when_currentAttributedText_and_newAttributedText_are_nil_and_displayedTextType_is_attributedText() {
        // GIVEN
        let useCase = GetDidDisplayedTextChangeUseCase()

        // WHEN
        let isChanged = useCase.execute(
            currentAttributedText: nil,
            newAttributedText: nil,
            displayedTextType: .attributedText
        )

        // THEN
        XCTAssertTrue(isChanged)
    }
}
