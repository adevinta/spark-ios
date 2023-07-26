//
//  UIImage+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 26/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class UIImageExtensionTests: XCTestCase {

    // MARK: - Tests

    func test_either_when_image_is_set() {
        // GIVEN/WHEN
        let image: UIImage? = IconographyTests.shared.arrow

        // WHEN
        let either = image.either

        // THEN
        XCTAssertEqual(either?.leftValue, image, "Wrong either value")
    }

    func test_either_when_image_is_nil() {
        // GIVEN/WHEN
        let image: UIImage? = nil

        // WHEN
        let either = image.either

        // THEN
        XCTAssertNil(either, "Wrong either value")
    }
}
