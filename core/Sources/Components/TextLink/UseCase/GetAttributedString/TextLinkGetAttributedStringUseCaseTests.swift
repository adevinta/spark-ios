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

    // MARK: - UIKit Tests

    func test_execute_for_UIKit_without_range() {
        // GIVEN
        let stub = Stub()
        let useCase = stub.useCase

        let expectedAttributedString = NSAttributedString(
            string: stub.textMock,
            attributes: .highlightAttributes(from: stub)
        )

        // WHEN
        let attributedString = useCase.execute(
            frameworkType: .uiKit,
            text: stub.textMock,
            textColorToken: stub.colorTokenMock,
            textHighlightRange: nil,
            isHighlighted: stub.isHighlightedMock,
            variant: stub.variantMock,
            typographies: stub.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.leftValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: stub)
    }

    func test_execute_for_UIKit_with_range() {
        // GIVEN
        let stub = Stub()
        let useCase = stub.useCase

        let expectedAttributedString = NSMutableAttributedString(
            string: stub.textMock,
            attributes: .normalAttributes(from: stub)
        )

        expectedAttributedString.addAttributes(
            .highlightAttributes(from: stub),
            range: stub.textHighlightRangeMock
        )

        // WHEN
        let attributedString = useCase.execute(
            frameworkType: .uiKit,
            text: stub.textMock,
            textColorToken: stub.colorTokenMock,
            textHighlightRange: stub.textHighlightRangeMock,
            isHighlighted: stub.isHighlightedMock,
            variant: stub.variantMock,
            typographies: stub.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.leftValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: stub)
    }

    // MARK: - SwiftUI Test

    func test_execute_for_SwiftUI_without_range() {
        // GIVEN
        let stub = Stub()
        let useCase = stub.useCase

        var expectedAttributedString = AttributedString(stub.textMock)
        expectedAttributedString.addHighlightAttributes(from: stub)

        // WHEN
        let attributedString = useCase.execute(
            frameworkType: .swiftUI,
            text: stub.textMock,
            textColorToken: stub.colorTokenMock,
            textHighlightRange: nil,
            isHighlighted: stub.isHighlightedMock,
            variant: stub.variantMock,
            typographies: stub.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.rightValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: stub)
    }

    func test_execute_for_SwiftUI_with_range() throws {
        // GIVEN
        let stub = Stub()
        let useCase = stub.useCase

        var expectedAttributedString = AttributedString(stub.textMock)
        expectedAttributedString.addNormalAttributes(from: stub)

        let textHighlightRange = try XCTUnwrap(
            Range(stub.textHighlightRangeMock, in: expectedAttributedString),
            "Range should not be nil"
        )
        expectedAttributedString[textHighlightRange].font = stub.typographiesMock.highlight.font
        expectedAttributedString[textHighlightRange].underlineStyle = stub.underlineStyleMock

        // WHEN
        let attributedString = useCase.execute(
            frameworkType: .swiftUI,
            text: stub.textMock,
            textColorToken: stub.colorTokenMock,
            textHighlightRange: stub.textHighlightRangeMock,
            isHighlighted: stub.isHighlightedMock,
            variant: stub.variantMock,
            typographies: stub.typographiesMock
        )

        // THEN
        XCTAssertEqual(
            attributedString.rightValue,
            expectedAttributedString,
            "Wrong attributed string"
        )

        // Use Case
        self.testUseCase(from: stub)
    }
}

// MARK: - Use Case Testing

private extension TextLinkGetAttributedStringTests {

    func testUseCase(from stub: Stub) {
        TextLinkGetUnderlineUseCaseableMockTest.XCTAssert(
            stub.getUnderlineUseCaseMock,
            expectedNumberOfCalls: 1,
            givenVariant: stub.variantMock,
            givenIsHighlighted: stub.isHighlightedMock,
            expectedReturnValue: stub.underlineStyleMock
        )
    }
}

// MARK: - Stub

private final class Stub {

    // MARK: - Properties

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

    lazy var useCase: TextLinkGetAttributedStringUseCase = {
        return .init(getUnderlineUseCaseable: self.getUnderlineUseCaseMock)
    }()
}

// MARK: - Extension

private extension [NSAttributedString.Key : Any]  {

    static func highlightAttributes(from stub: Stub) -> Self {
        return [
            .foregroundColor: stub.colorTokenMock.uiColor,
            .font: stub.typographiesMock.highlight.uiFont,
            .underlineStyle: stub.underlineStyleMock.rawValue,
            .underlineColor: stub.colorTokenMock.uiColor,
        ]
    }

    static func normalAttributes(from stub: Stub) -> Self {
        return [
            .foregroundColor: stub.colorTokenMock.uiColor,
            .font: stub.typographiesMock.normal.uiFont
        ]
    }
}

private extension AttributedString {

    mutating func addHighlightAttributes(from stub: Stub) {
        self.foregroundColor = stub.colorTokenMock.color
        self.font = stub.typographiesMock.highlight.font
        self.underlineStyle = stub.underlineStyleMock
    }

    mutating func addNormalAttributes(from stub: Stub) {
        self.foregroundColor = stub.colorTokenMock.color
        self.font = stub.typographiesMock.normal.font
    }
}
