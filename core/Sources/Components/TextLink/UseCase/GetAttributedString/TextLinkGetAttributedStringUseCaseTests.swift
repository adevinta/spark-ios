//
//  TextLinkGetAttributedStringTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class TextLinkGetAttributedStringTests: XCTestCase {

    // MARK: - Properties

    private var mocks = Mocks()
    private var useCase = TextLinkGetAttributedStringUseCase()

    // MARK: - Setupt

    override func setUp() {
        super.setUp()

        self.mocks = Mocks()
        self.useCase = TextLinkGetAttributedStringUseCase(
            getUnderlineUseCaseable: self.mocks.getUnderlineUseCaseMock
        )
    }

    // MARK: - UIKit Tests

    func test_execute_for_UIKit_without_range() {
        // GIVEN
        let expectedAttributedString = NSMutableAttributedString(
            mocks: self.mocks,
            isRange: false
        )

        // WHEN
        let attributedString = self.useCase.execute(
            frameworkType: .uiKit,
            text: self.mocks.textMock,
            textColorToken: self.mocks.colorTokenMock,
            textHighlightRange: nil,
            isHighlighted: self.mocks.isHighlightedMock,
            variant: self.mocks.variantMock,
            typographies: self.mocks.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.leftValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: self.mocks)
    }

    func test_execute_for_UIKit_with_range() {
        // GIVEN
        let expectedAttributedString = NSMutableAttributedString(
            mocks: self.mocks,
            isRange: true
        )

        // WHEN
        let attributedString = self.useCase.execute(
            frameworkType: .uiKit,
            text: self.mocks.textMock,
            textColorToken: self.mocks.colorTokenMock,
            textHighlightRange: self.mocks.textHighlightRangeMock,
            isHighlighted: self.mocks.isHighlightedMock,
            variant: self.mocks.variantMock,
            typographies: self.mocks.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.leftValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: self.mocks)
    }

    // MARK: - SwiftUI Test

    func test_execute_for_SwiftUI_without_range() {
        // GIVEN
        var expectedAttributedString = AttributedString(
            mocks: self.mocks,
            isRange: false
        )

        // WHEN
        let attributedString = self.useCase.execute(
            frameworkType: .swiftUI,
            text: self.mocks.textMock,
            textColorToken: self.mocks.colorTokenMock,
            textHighlightRange: nil,
            isHighlighted: self.mocks.isHighlightedMock,
            variant: self.mocks.variantMock,
            typographies: self.mocks.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.rightValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: self.mocks)
    }

    func test_execute_for_SwiftUI_with_range() throws {
        // GIVEN
        var expectedAttributedString = AttributedString(
            mocks: self.mocks,
            isRange: true
        )

        let textHighlightRange = try XCTUnwrap(
            Range(self.mocks.textHighlightRangeMock, in: expectedAttributedString),
            "Range should not be nil"
        )
        expectedAttributedString[textHighlightRange].font = self.mocks.typographiesMock.highlight.font
        expectedAttributedString[textHighlightRange].underlineStyle = self.mocks.underlineStyleMock

        // WHEN
        let attributedString = self.useCase.execute(
            frameworkType: .swiftUI,
            text: self.mocks.textMock,
            textColorToken: self.mocks.colorTokenMock,
            textHighlightRange: self.mocks.textHighlightRangeMock,
            isHighlighted: self.mocks.isHighlightedMock,
            variant: self.mocks.variantMock,
            typographies: self.mocks.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.rightValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: self.mocks)
    }
}

// MARK: - Use Case Testing

private extension TextLinkGetAttributedStringTests {

    func testUseCase(from mocks: Mocks) {
        TextLinkGetUnderlineUseCaseableMockTest.XCTAssert(
            mocks.getUnderlineUseCaseMock,
            expectedNumberOfCalls: 1,
            givenVariant: mocks.variantMock,
            givenIsHighlighted: mocks.isHighlightedMock,
            expectedReturnValue: mocks.underlineStyleMock
        )
    }
}

// MARK: - Mocks

private final class Mocks {

    let textMock = "My Text"
    let textHighlightRangeMock = NSRange(location: 0, length: 2)
    let variantMock: TextLinkVariant = .underline
    let typographiesMock: TextLinkTypographies = .mocked()
    let isHighlightedMock: Bool = true
    let colorTokenMock = ColorTokenGeneratedMock()

    let underlineStyleMock: NSUnderlineStyle = .double

    lazy var getUnderlineUseCaseMock: TextLinkGetUnderlineUseCaseableGeneratedMock = {
        let mock = TextLinkGetUnderlineUseCaseableGeneratedMock()
        mock.executeWithVariantAndIsHighlightedReturnValue = self.underlineStyleMock
        return mock
    }()
}

// MARK: - Extension

private extension NSMutableAttributedString {

    convenience init(mocks: Mocks, isRange: Bool) {
        let highlightAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: mocks.colorTokenMock.uiColor,
            .font: mocks.typographiesMock.highlight.uiFont,
            .underlineStyle: mocks.underlineStyleMock.rawValue,
            .underlineColor: mocks.colorTokenMock.uiColor,
        ]

        let attributes: [NSAttributedString.Key: Any]
        if isRange {
            attributes = [
                .foregroundColor: mocks.colorTokenMock.uiColor,
                .font: mocks.typographiesMock.normal.uiFont
            ]
        } else {
            attributes = highlightAttributes
        }

        self.init(
            string: mocks.textMock,
            attributes: attributes
        )

        if isRange {
            self.addAttributes(
                highlightAttributes,
                range: mocks.textHighlightRangeMock
            )
        }
    }
}

private extension AttributedString {

    init(mocks: Mocks, isRange: Bool) {
        self.init(mocks.textMock)

        if isRange {
            self.foregroundColor = mocks.colorTokenMock.color
            self.font = mocks.typographiesMock.normal.font
        } else {
            self.foregroundColor = mocks.colorTokenMock.color
            self.font = mocks.typographiesMock.highlight.font
            self.underlineStyle = mocks.underlineStyleMock
        }
    }
}
