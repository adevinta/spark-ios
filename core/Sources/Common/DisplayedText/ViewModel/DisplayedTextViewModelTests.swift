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
        let displayedTextTypeMock: DisplayedTextType = .text

        let getDisplayedTextTypeUseCaseMock = GetDisplayedTextTypeUseCaseableGeneratedMock()
        getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReturnValue = displayedTextTypeMock

        // WHEN
        let viewModel = DisplayedTextViewModelDefault(
            text: textMock,
            attributedText: attributedTextMock,
            getDisplayedTextTypeUseCase: getDisplayedTextTypeUseCaseMock
        )
        
        // THEN
        XCTAssertEqual(viewModel.displayedTextType,
                       displayedTextTypeMock,
                       "Wrong displayedTextType value")
        XCTAssertEqual(viewModel.displayedText?.text,
                       textMock,
                       "Wrong displayedTextType text value")
        XCTAssertEqual(viewModel.displayedText?.attributedText,
                       attributedTextMock,
                       "Wrong displayedTextType attributedText value")
        XCTAssertEqual(viewModel.containsText,
                       displayedTextTypeMock.containsText,
                       "Wrong containsText value")
        

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
        let displayedTextTypeMock: DisplayedTextType = .text
        let newText = "Hey"
        let textMock = "Hello"

        let getDisplayedTextTypeUseCaseMock = GetDisplayedTextTypeUseCaseableGeneratedMock()
        getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReturnValue = displayedTextTypeMock
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

        XCTAssertEqual(viewModel.displayedText,
                       .init(text: givenGetDidDisplayedTextChange ? newText : textMock),
                       "Wrong displayedText value")
        XCTAssertEqual(viewModel.displayedTextType,
                       givenGetDidDisplayedTextChange ? .none : displayedTextTypeMock,
                       "Wrong displayedTextType value")
        XCTAssertEqual(viewModel.containsText,
                       givenGetDidDisplayedTextChange ? DisplayedTextType.none.containsText : displayedTextTypeMock.containsText,
                       "Wrong containsText value")

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
                       displayedTextTypeMock,
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
        let displayedTextTypeMock: DisplayedTextType = .attributedText
        let newAttributedTextMock: AttributedStringEither = .left(.init(string: "Hey"))
        let attributedTextMock: AttributedStringEither = .left(.init(string: "Hello"))

        let getDisplayedTextTypeUseCaseMock = GetDisplayedTextTypeUseCaseableGeneratedMock()
        getDisplayedTextTypeUseCaseMock.executeWithTextAndAttributedTextReturnValue = displayedTextTypeMock
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
        let attributedTextChanged = viewModel.attributedTextChanged(newAttributedTextMock)

        // THEN
        XCTAssertEqual(attributedTextChanged,
                       givenGetIsDisplayedAttributedTextChanged,
                       "Wrong attributedTextChanged value")

        XCTAssertEqual(viewModel.displayedText,
                       .init(attributedText: givenGetIsDisplayedAttributedTextChanged ? newAttributedTextMock : attributedTextMock),
                       "Wrong displayedText value")
        XCTAssertEqual(viewModel.displayedTextType,
                       givenGetIsDisplayedAttributedTextChanged ? .none : displayedTextTypeMock,
                       "Wrong displayedTextType value")
        XCTAssertEqual(viewModel.containsText,
                       givenGetIsDisplayedAttributedTextChanged ? DisplayedTextType.none.containsText : displayedTextTypeMock.containsText,
                       "Wrong containsText value")

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
                       newAttributedTextMock,
                       "Wrong newAttributedText parameter on execute on getDidDisplayedTextChangeUseCase")
        XCTAssertEqual(getDidDisplayedTextChangeUseCaseMockArgs?.displayedTextType,
                       displayedTextTypeMock,
                       "Wrong displayedTextType parameter on execute on getDidDisplayedTextChangeUseCase")
        // **

        // **
        // GetDisplayedTextTypeUseCase
        XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithAttributedTextCallsCount,
                       givenGetIsDisplayedAttributedTextChanged ? 1 : 0,
                       "Wrong call number on execute on getDisplayedTextTypeUseCase")

        if givenGetIsDisplayedAttributedTextChanged {
            XCTAssertEqual(getDisplayedTextTypeUseCaseMock.executeWithAttributedTextReceivedAttributedText,
                           newAttributedTextMock,
                           "Wrong attributedText parameter on execute on getDisplayedTextTypeUseCase")
        }
        // **
    }
}
