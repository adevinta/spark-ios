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

    // MARK: - Tests

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set_and_containsText_is_false() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: self.imageMock,
            givenContainsText: false,
            expectedContent: .init(
                shouldShowIconImage: true,
                isIconImageTrailing: false,
                iconImage: .left(self.imageMock),
                shouldShowText: false
            )
        )
    }

    func test_execute_when_alignment_is_trailingIcon_and_image_is_set_and_containsText_is_false() {
        self.testExecute(
            givenAlignment: .trailingIcon,
            givenIconImage: self.imageMock,
            givenContainsText: false,
            expectedContent: .init(
                shouldShowIconImage: true,
                isIconImageTrailing: true,
                iconImage: .left(self.imageMock),
                shouldShowText: false
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set_and_containsText_is_true() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: self.imageMock,
            givenContainsText: true,
            expectedContent: .init(
                shouldShowIconImage: true,
                isIconImageTrailing: false,
                iconImage: .left(self.imageMock),
                shouldShowText: true
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_containsText_is_true() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenIconImage: nil,
            givenContainsText: true,
            expectedContent: .init(
                shouldShowIconImage: false,
                isIconImageTrailing: false,
                iconImage: nil,
                shouldShowText: true
            )
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetContentUseCaseTests {

    func testExecute(
        givenAlignment: ButtonAlignment,
        givenIconImage: UIImage?,
        givenContainsText: Bool,
        expectedContent: ButtonContent
    ) {
        // GIVEN
        var errorSuffixMessage = " for \(givenAlignment) alignment case"
        if givenIconImage != nil {
            errorSuffixMessage += " - with icon image"
        }
        if givenContainsText {
            errorSuffixMessage += " - with displayed text"
        }

        let useCase = ButtonGetContentUseCase()

        let iconImage: ImageEither?
        if let givenIconImage {
            iconImage = .left(givenIconImage)
        } else {
            iconImage = nil
        }

        // GIVEN
        let content = useCase.execute(
            alignment: givenAlignment,
            iconImage: iconImage,
            containsText: givenContainsText
        )

        // THEN
        XCTAssertEqual(content.shouldShowIconImage,
                       expectedContent.shouldShowIconImage,
                       "Wrong shouldShowIconImage" + errorSuffixMessage)
        XCTAssertEqual(content.isIconImageTrailing,
                       expectedContent.isIconImageTrailing,
                       "Wrong isIconImageTrailing" + errorSuffixMessage)
        XCTAssertEqual(content.iconImage?.leftValue,
                       expectedContent.iconImage?.leftValue,
                       "Wrong iconImage" + errorSuffixMessage)

        XCTAssertEqual(content.shouldShowText,
                       expectedContent.shouldShowText,
                       "Wrong shouldShowText" + errorSuffixMessage)
    }
}
