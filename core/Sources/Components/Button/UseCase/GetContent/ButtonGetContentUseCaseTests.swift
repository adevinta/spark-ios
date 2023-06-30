//
//  ButtonGetContentUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetContentUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let imageMock = IconographyTests.shared.switchOn
    private let textMock = "My Text"
    private let attributedText = NSAttributedString(string: "My attributed String")

    // MARK: - Tests

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: self.imageMock,
            givenText: nil,
            givenAttributedText: nil,
            expectedContent: .init(
                showIconImage: true,
                isIconImageOnRight: false,
                iconImage: .left(self.imageMock),
                showText: false
            )
        )
    }

    func test_execute_when_alignment_is_trailingIcon_and_image_is_set() {
        self.testExecute(
            givenAlignment: .trailingIcon,
            givenIconImage: self.imageMock,
            givenText: nil,
            givenAttributedText: nil,
            expectedContent: .init(
                showIconImage: true,
                isIconImageOnRight: true,
                iconImage: .left(self.imageMock),
                showText: false
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set_and_text_is_set() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: self.imageMock,
            givenText: self.textMock,
            givenAttributedText: nil,
            expectedContent: .init(
                showIconImage: true,
                isIconImageOnRight: false,
                iconImage: .left(self.imageMock),
                showText: true
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set_and_attributedText_is_set() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: self.imageMock,
            givenText: nil,
            givenAttributedText: self.attributedText,
            expectedContent: .init(
                showIconImage: true,
                isIconImageOnRight: false,
                iconImage: .left(self.imageMock),
                showText: true
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_text_is_set() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: nil,
            givenText: self.textMock,
            givenAttributedText: nil,
            expectedContent: .init(
                showIconImage: false,
                isIconImageOnRight: false,
                iconImage: nil,
                showText: true
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_attributedText_is_set() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: nil,
            givenText: nil,
            givenAttributedText: self.attributedText,
            expectedContent: .init(
                showIconImage: false,
                isIconImageOnRight: false,
                iconImage: nil,
                showText: true
            )
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetContentUseCaseTests {

    func testExecute(
        givenAlignment: ButtonAlignment,
        givenIconImage: UIImage?,
        givenText: String?,
        givenAttributedText: NSAttributedString?,
        expectedContent: ButtonContentDefault
    ) {
        // GIVEN
        var errorSuffixMessage = " for \(givenAlignment) alignment case"
        if givenIconImage != nil {
            errorSuffixMessage += " - with icon image"
        }
        if givenText != nil {
            errorSuffixMessage += " - with text"
        }
        if givenAttributedText != nil {
            errorSuffixMessage += " - with attributed text"
        }

        let useCase = ButtonGetContentUseCase()

        let iconImage: ImageEither?
        if let givenIconImage {
            iconImage = .left(givenIconImage)
        } else {
            iconImage = nil
        }

        let attributedString: AttributedStringEither?
        if let givenAttributedText {
            attributedString = .left(givenAttributedText)
        } else {
            attributedString = nil
        }

        // GIVEN
        let content = useCase.execute(
            forAlignment: givenAlignment,
            iconImage: iconImage,
            text: givenText,
            attributedText: attributedString
        )

        // THEN
        XCTAssertEqual(content.showIconImage,
                       expectedContent.showIconImage,
                       "Wrong showIconImage" + errorSuffixMessage)
        XCTAssertEqual(content.isIconImageOnRight,
                       expectedContent.isIconImageOnRight,
                       "Wrong isIconImageOnRight" + errorSuffixMessage)
        XCTAssertEqual(content.iconImage?.leftValue,
                       expectedContent.iconImage?.leftValue,
                       "Wrong iconImage" + errorSuffixMessage)

        XCTAssertEqual(content.showText,
                       expectedContent.showText,
                       "Wrong showText" + errorSuffixMessage)
    }
}
