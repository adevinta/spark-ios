//
//  SwitchVariantTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 15/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
import UIKit
@testable import SparkCore

final class SwitchVariantTests: XCTestCase {

    // MARK: - Properties

    private let onImageMock = Image(systemName: "square.and.arrow.up")
    private let offImageMock = Image(systemName: "square.and.arrow.down")

    private let onUIImageMock = IconographyTests.shared.switchOn
    private let offUIImageMock = IconographyTests.shared.switchOff

    // MARK: - Tests

    func test_init_and_toImages_for_SwiftUI() {
        // GIVEN
        let variant = SwitchVariant(images: (
            on: self.onImageMock,
            off: self.offImageMock
        ))

        // WHEN
        let images = variant?.toImages()

        // THEN
        XCTAssertNotNil(variant, "Variant should not be nil")

        XCTAssertEqual(images?.on, self.onImageMock, "Wrong 'on' image")
        XCTAssertEqual(images?.on, self.onImageMock, "Wrong 'off' image")
    }

    func test_init_and_toUIImages_for_UIKit() {
        // GIVEN
        let variant = SwitchVariant(images: (
            on: self.onUIImageMock,
            off: self.offUIImageMock
        ))

        // WHEN
        let images = variant?.toUIImages()

        // THEN
        XCTAssertNotNil(variant, "Variant should not be nil")

        XCTAssertEqual(images?.on, self.onUIImageMock, "Wrong 'on' image")
        XCTAssertEqual(images?.on, self.onUIImageMock, "Wrong 'off' image")
    }
}
