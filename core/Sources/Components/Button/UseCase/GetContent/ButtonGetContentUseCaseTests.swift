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

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set_and_containsTitle_is_false() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenImage: self.imageMock,
            givenContainsTitle: false,
            expectedContent: .init(
                shouldShowIconImage: true,
                isIconImageTrailing: false,
                iconImage: .left(self.imageMock),
                shouldShowTitle: false
            )
        )
    }

    func test_execute_when_alignment_is_trailingIcon_and_image_is_set_and_containsTitle_is_false() {
        self.testExecute(
            givenAlignment: .trailingIcon,
            givenImage: self.imageMock,
            givenContainsTitle: false,
            expectedContent: .init(
                shouldShowIconImage: true,
                isIconImageTrailing: true,
                iconImage: .left(self.imageMock),
                shouldShowTitle: false
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_image_is_set_and_containsTitle_is_true() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenImage: self.imageMock,
            givenContainsTitle: true,
            expectedContent: .init(
                shouldShowIconImage: true,
                isIconImageTrailing: false,
                iconImage: .left(self.imageMock),
                shouldShowTitle: true
            )
        )
    }

    func test_execute_when_alignment_is_leadingIcon_and_containsTitle_is_true() {
        self.testExecute(
            givenAlignment: .leadingIcon,
            givenImage: nil,
            givenContainsTitle: true,
            expectedContent: .init(
                shouldShowIconImage: false,
                isIconImageTrailing: false,
                iconImage: nil,
                shouldShowTitle: true
            )
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetContentUseCaseTests {

    func testExecute(
        givenAlignment: ButtonAlignmentDeprecated,
        givenImage: UIImage?,
        givenContainsTitle: Bool,
        expectedContent: ButtonContent
    ) {
        // GIVEN
        var errorSuffixMessage = " for \(givenAlignment) alignment case"
        if givenImage != nil {
            errorSuffixMessage += " - with icon image"
        }
        if givenContainsTitle {
            errorSuffixMessage += " - with displayed text"
        }

        let useCase = ButtonGetContentUseCase()

        let iconImage: ImageEither?
        if let givenImage {
            iconImage = .left(givenImage)
        } else {
            iconImage = nil
        }

        // GIVEN
        let content = useCase.execute(
            alignment: givenAlignment,
            iconImage: iconImage,
            containsTitle: givenContainsTitle
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

        XCTAssertEqual(content.shouldShowTitle,
                       expectedContent.shouldShowTitle,
                       "Wrong shouldShowTitle" + errorSuffixMessage)
    }
}
