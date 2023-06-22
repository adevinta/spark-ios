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

    // MARK: - Tests

    func test_execute_for_all_cases() throws {
        // GIVEN / WHEN
        let onImageMock = Image(systemName: "square.and.arrow.up")
        let offImageMock = Image(systemName: "square.and.arrow.down")

        let onUIImageMock = IconographyTests.shared.switchOn
        let offUIImageMock = IconographyTests.shared.switchOff

        let variantMock = SwitchVariant(
            onImage: onImageMock,
            offImage: offImageMock
        )
        let variantUIMock = SwitchVariant(
            onImage: onUIImageMock,
            offImage: offUIImageMock
        )

        let expectedOnImage = SwitchImage(
            image: onImageMock,
            uiImage: onUIImageMock
        )
        let expectedOffImage = SwitchImage(
            image: offImageMock,
            uiImage: offUIImageMock
        )

        let items: [(
            givenIsOn: Bool,
            givenVariant: SwitchVariant?,
            expectedImage: SwitchImage?
        )] = [
            // **
            // SwitfUI Variant
            (
                givenIsOn: true,
                givenVariant: variantMock,
                expectedImage: expectedOnImage
            ),
            (
                givenIsOn: false,
                givenVariant: variantMock,
                expectedImage: expectedOffImage
            ),
            // **

            // **
            // UIKit Variant
            (
                givenIsOn: true,
                givenVariant: variantUIMock,
                expectedImage: expectedOnImage
            ),
            (
                givenIsOn: false,
                givenVariant: variantUIMock,
                expectedImage: expectedOffImage
            ),
            // **

            // **
            // Without Variant
            (
                givenIsOn: true,
                givenVariant: nil,
                expectedImage: nil
            ),
            (
                givenIsOn: false,
                givenVariant: nil,
                expectedImage: nil
            )
            // **
        ]

        for item in items {
            let errorPrefixMessage = " for \(item.givenIsOn) isOn"

            let useCase = SwitchGetImageUseCase()
            let image = useCase.execute(
                forIsOn: item.givenIsOn,
                variant: item.givenVariant
            )

            // THEN
            if let image = image {
                if item.givenIsOn {
                    XCTAssertEqual(image.image,
                                   item.givenVariant?.onImage,
                                   "Wrong on image" + errorPrefixMessage)
                    XCTAssertEqual(image.uiImage,
                                   item.givenVariant?.onUIImage,
                                   "Wrong on UIImage" + errorPrefixMessage)
                } else {
                    XCTAssertEqual(image.image,
                                   item.givenVariant?.offImage,
                                   "Wrong off image" + errorPrefixMessage)
                    XCTAssertEqual(image.uiImage,
                                   item.givenVariant?.offUIImage,
                                   "Wrong off UIImage" + errorPrefixMessage)
                }
            } else {
                XCTAssertNil(item.expectedImage,
                             "Image should be nil" + errorPrefixMessage)
            }
        }
    }
}
