//
//  SwitchGetImageUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 13/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetImageUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let onImageMock = IconographyTests.shared.switchOn
    private let offImageMock = IconographyTests.shared.switchOff

    private lazy var variantMock: SwitchVariant = {
        return .init(images: SwitchUIVariantImages(
            on: self.onImageMock,
            off: self.offImageMock
        ))!
    }()

    private lazy var expectedOnImage: SwitchImage = {
        return .left(self.onImageMock)
    }()
    private lazy var expectedOffImage: SwitchImage = {
        return .left(self.offImageMock)
    }()

    // MARK: - With Variant Tests

    func test_execute_when_isOn_is_true_and_variant_is_set_with_UIKit_variant_images() throws {
        try self.testExecute(
            givenIsOn: true,
            givenVariant: self.variantMock,
            expectedImage: self.expectedOnImage
        )
    }

    func test_execute_when_isOn_is_false_and_variant_is_set_with_UIKit_variant_images() throws {
        try self.testExecute(
            givenIsOn: false,
            givenVariant: self.variantMock,
            expectedImage: self.expectedOffImage
        )
    }

    // MARK: - UIKit Variant Tests

    func test_execute_when_isOn_is_true_and_variant_is_set_without_variant() throws {
        try self.testExecute(
            givenIsOn: true,
            givenVariant: nil,
            expectedImage: nil
        )
    }

    func test_execute_when_isOn_is_false_and_variant_is_set_without_variant() throws {
        try self.testExecute(
            givenIsOn: true,
            givenVariant: nil,
            expectedImage: nil
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetImageUseCaseTests {

    func testExecute(
        givenIsOn: Bool,
        givenVariant: SwitchVariant?,
        expectedImage: SwitchImage?
    ) throws {
        // GIVEN
        let errorPrefixMessage = " for \(givenIsOn) isOn"

        let useCase = SwitchGetImageUseCase()

        // WHEN
        let image = useCase.execute(
            forIsOn: givenIsOn,
            variant: givenVariant
        )

        // THEN
        if let image = image {
            if givenIsOn {
                XCTAssertEqual(image.leftValue,
                               givenVariant?.onImage.leftValue,
                               "Wrong on image" + errorPrefixMessage)
            } else {
                XCTAssertEqual(image.leftValue,
                               givenVariant?.offImage.leftValue,
                               "Wrong off image" + errorPrefixMessage)
            }
        } else {
            XCTAssertNil(expectedImage,
                         "Image should be nil" + errorPrefixMessage)
        }
    }
}
