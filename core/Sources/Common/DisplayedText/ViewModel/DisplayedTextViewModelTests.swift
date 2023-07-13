//
//  DisplayedTextViewModelTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class DisplayedTextViewModelTests: XCTestCase {
    
    // MARK: - Tests Init
    
    func test_properties_after_init() {
        // GIVEN
        let textMock = "Hello"
        let attributedTextMock: AttributedStringEither = .left(.init(string: "Holà"))

        let getDisplayedTextTypeUseCaseMock = GetDisplayedTextTypeUseCaseableGeneratedMock()
        getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReturnValue = .text
        
        // WHEN
        let viewModel = DisplayedTextViewModelDefault(
            text: textMock,
            attributedText: attributedTextMock,
            getDisplayedTextTypeUseCase: getDisplayedTextTypeUseCaseMock
        )
        
        // THEN
        XCTAssertEqual(viewModel.text,
                       textMock,
                       "Wrong text value")
        XCTAssertEqual(viewModel.attributedText,
                       attributedTextMock,
                       "Wrong attributed text value")

        // **
        // GetDisplayedTextTypeUseCase
        XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextCallsCount,
                       1,
                       "Wrong call number on execute with text and attributedText parameters on getDisplayedTextTypeUseCase")

        let getDisplayedTextTypeUseCaseArgs = getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReceivedArguments
        XCTAssertEqual(getDisplayedTextTypeUseCaseArgs?.text,
                       textMock,
                       "Wrong text parameter on execute on getDisplayedTextTypeUseCase")
        XCTAssertEqual(getDisplayedTextTypeUseCaseArgs?.attributedText,
                       attributedTextMock,
                       "Wrong attributedText parameter on execute on getDisplayedTextTypeUseCase")
        // **
    }

    // MARK: - Tests TextChanged

    func test_textChanged_when_getDidDisplayedTextChangeUseCase_return_true() {
        self.testTextChanged(givenGetDidDisplayedTextChange: true)
    }

    func test_textChanged_when_getDidDisplayedTextChangeUseCase_return_false() {
        self.testTextChanged(givenGetDidDisplayedTextChange: false)
    }

    func testTextChanged(
        givenGetDidDisplayedTextChange: Bool
    ) {
        // GIVEN
        let displayedTextType: DisplayedTextType = .text
        let newText = "Hey"
        let textMock = "Hello"

        let getDisplayedTextTypeUseCaseMock = GetDisplayedTextTypeUseCaseableGeneratedMock()
        getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReturnValue = displayedTextType
        getDisplayedTextTypeUseCaseMock.executeWithTextReturnValue = DisplayedTextType.none

        let getDidDisplayedTextChangeUseCaseMock = GetDidDisplayedTextChangeUseCaseableGeneratedMock()
        getDidDisplayedTextChangeUseCaseMock.executeWithCurrentTextAndNewTextAndDisplayedTextTypeReturnValue = givenGetDidDisplayedTextChange

        let viewModel = DisplayedTextViewModelDefault(
            text: textMock,
            attributedText: nil,
            getDisplayedTextTypeUseCase: getDisplayedTextTypeUseCaseMock,
            getDidDisplayedTextChangeUseCase: getDidDisplayedTextChangeUseCaseMock
        )

        // WHEN
        let textChanged = viewModel.textChanged(newText)

        // THEN
        XCTAssertEqual(textChanged,
                       givenGetDidDisplayedTextChange,
                      "Wrong textChanged value")

        XCTAssertEqual(viewModel.text,
                       givenGetDidDisplayedTextChange ? newText : textMock,
                       "Wrong text value")

        // **
        // GetDidDisplayedTextChangeUseCase
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMock.executeWithCurrentTextAndNewTextAndDisplayedTextTypeCallsCount,
                       1,
                       "Wrong call number on execute parameters on getDidDisplayedTextChangeUseCase")

        let getDidDisplayedTextChangeUseCaseMockArgs = getDidDisplayedTextChangeUseCaseMock.executeWithCurrentTextAndNewTextAndDisplayedTextTypeReceivedArguments

        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.currentText,
                       textMock,
                       "Wrong currentText parameter on execute on getDidDisplayedTextChangeUseCase")
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.newText,
                       newText,
                       "Wrong newText parameter on execute on getDidDisplayedTextChangeUseCase")
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.displayedTextType,
                       displayedTextType,
                       "Wrong displayedTextType parameter on execute on getDidDisplayedTextChangeUseCase")
        // **

        // **
        // GetDisplayedTextTypeUseCase
        XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithTextCallsCount,
                       givenGetDidDisplayedTextChange ? 1 : 0,
                       "Wrong call number on execute on getDisplayedTextTypeUseCase")

        if givenGetDidDisplayedTextChange {
            XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithTextReceivedText,
                           newText,
                           "Wrong text parameter on execute on getDisplayedTextTypeUseCase")
        }
        // **
    }

    // MARK: - Tests AttributedTextChanged

    func test_attributedTextChanged_when_getIsDisplayedAttributedTextChangedUseCase_return_true() {
        self.testAttributedTextChanged(givenGetIsDisplayedAttributedTextChanged: true)
    }

    func test_attributedTextChanged_when_getIsDisplayedAttributedTextChangedUseCase_return_false() {
        self.testAttributedTextChanged(givenGetIsDisplayedAttributedTextChanged: false)
    }

    func testAttributedTextChanged(
        givenGetIsDisplayedAttributedTextChanged: Bool
    ) {
        // GIVEN
        let displayedTextType: DisplayedTextType = .attributedText
        let newAttributedText: AttributedStringEither = .left(.init(string: "Hey"))
        let attributedTextMock: AttributedStringEither = .left(.init(string: "Hello"))

        let getDisplayedTextTypeUseCaseMock = GetDisplayedTextTypeUseCaseableGeneratedMock()
        getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReturnValue = displayedTextType
        getDisplayedTextTypeUseCaseMock.executeWithAttributedTextReturnValue = DisplayedTextType.none

        let getDidDisplayedTextChangeUseCaseMock = GetDidDisplayedTextChangeUseCaseableGeneratedMock()
        getDidDisplayedTextChangeUseCaseMock.executeWithCurrentAttributedTextAndNewAttributedTextAndDisplayedTextTypeReturnValue = givenGetIsDisplayedAttributedTextChanged

        let viewModel = DisplayedTextViewModelDefault(
            text: nil,
            attributedText: attributedTextMock,
            getDisplayedTextTypeUseCase: getDisplayedTextTypeUseCaseMock,
            getDidDisplayedTextChangeUseCase: getDidDisplayedTextChangeUseCaseMock
        )

        // WHEN
        let attributedTextChanged = viewModel.attributedTextChanged(newAttributedText)

        // THEN
        XCTAssertEqual(attributedTextChanged,
                       givenGetIsDisplayedAttributedTextChanged,
                      "Wrong attributedTextChanged value")

        XCTAssertEqual(viewModel.attributedText,
                       givenGetIsDisplayedAttributedTextChanged ? newAttributedText : attributedTextMock,
                       "Wrong attributedText value")

        // **
        // GetDidDisplayedTextChangeUseCase
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMock.executeWithCurrentAttributedTextAndNewAttributedTextAndDisplayedTextTypeCallsCount,
                       1,
                       "Wrong call number on execute parameters on getDidDisplayedTextChangeUseCase")

        let getDidDisplayedTextChangeUseCaseMockArgs = getDidDisplayedTextChangeUseCaseMock.executeWithCurrentAttributedTextAndNewAttributedTextAndDisplayedTextTypeReceivedArguments
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.currentAttributedText,
                       attributedTextMock,
                       "Wrong currentAttributedText parameter on execute on getDidDisplayedTextChangeUseCase")
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.newAttributedText,
                       newAttributedText,
                       "Wrong newAttributedText parameter on execute on getDidDisplayedTextChangeUseCase")
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.displayedTextType,
                       displayedTextType,
                       "Wrong displayedTextType parameter on execute on getDidDisplayedTextChangeUseCase")
        // **

        // **
        // GetDisplayedTextTypeUseCase
        XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithAttributedTextCallsCount,
                       givenGetIsDisplayedAttributedTextChanged ? 1 : 0,
                       "Wrong call number on execute on getDisplayedTextTypeUseCase")

        if givenGetIsDisplayedAttributedTextChanged {
            XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithAttributedTextReceivedAttributedText,
                           newAttributedText,
                           "Wrong attributedText parameter on execute on getDisplayedTextTypeUseCase")
        }
        // **
    }
}
