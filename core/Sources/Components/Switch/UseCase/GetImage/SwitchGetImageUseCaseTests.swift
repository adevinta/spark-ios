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

    private let onImageMock = Image(systemName: "square.and.arrow.up")
    private let offImageMock = Image(systemName: "square.and.arrow.down")

    private let onUIImageMock = IconographyTests.shared.switchOn
    private let offUIImageMock = IconographyTests.shared.switchOff

    private lazy var variantMock: SwitchVariant = {
        return .init(
            onImage: self.onImageMock,
            offImage: self.offImageMock
        )
    }()
    private lazy var variantUIMock: SwitchVariant = {
        return .init(
            onImage: self.onUIImageMock,
            offImage: self.offUIImageMock
        )
    }()

    private lazy var expectedOnImage: SwitchImage = {
        return .init(
            image: self.onImageMock,
            uiImage: self.onUIImageMock
        )
    }()
    private lazy var expectedOffImage: SwitchImage = {
        return .init(
            image: self.offImageMock,
            uiImage: self.offUIImageMock
        )
    }()

    // MARK: - SwiftUI Variant Tests

    func test_execute_when_isOn_is_true_and_variant_is_set_with_swiftUI_variant_images() throws {
        try self.testExecute(
            givenIsOn: true,
            givenVariant: self.variantMock,
            expectedImage: self.expectedOnImage
        )
    }

    func test_execute_when_isOn_is_false_and_variant_is_set_with_swiftUI_variant_images() throws {
        try self.testExecute(
            givenIsOn: false,
            givenVariant: self.variantMock,
            expectedImage: self.expectedOffImage
        )
    }

    // MARK: - UIKit Variant Tests

    func test_execute_when_isOn_is_true_and_variant_is_set_with_UIKit_variant_images() throws {
        try self.testExecute(
            givenIsOn: true,
            givenVariant: self.variantUIMock,
            expectedImage: self.expectedOnImage
        )
    }

    func test_execute_when_isOn_is_false_and_variant_is_set_with_UIKit_variant_images() throws {
        try self.testExecute(
            givenIsOn: false,
            givenVariant: self.variantUIMock,
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
                XCTAssertEqual(image.image,
                               givenVariant?.onImage,
                               "Wrong on image" + errorPrefixMessage)
                XCTAssertEqual(image.uiImage,
                               givenVariant?.onUIImage,
                               "Wrong on UIImage" + errorPrefixMessage)
            } else {
                XCTAssertEqual(image.image,
                               givenVariant?.offImage,
                               "Wrong off image" + errorPrefixMessage)
                XCTAssertEqual(image.uiImage,
                               givenVariant?.offUIImage,
                               "Wrong off UIImage" + errorPrefixMessage)
            }
        } else {
            XCTAssertNil(expectedImage,
                         "Image should be nil" + errorPrefixMessage)
        }
    }
}
