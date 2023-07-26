//
//  SwitchUIImages+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

extension SwitchUIImages: Equatable {

    public static func == (lhs: SwitchUIImages, rhs: SwitchUIImages) -> Bool {
        return lhs.on == rhs.on && lhs.off == rhs.off
    }
}

final class SwitchUIImagesExtensionTests: XCTestCase {

    // MARK: - Tests

    func test_either_when_images_is_set() {
        // GIVEN/WHEN
        let images: SwitchUIImages? = .init(
            on: IconographyTests.shared.arrow,
            off: IconographyTests.shared.arrow
        )

        // WHEN
        let either = images.either

        // THEN
        XCTAssertEqual(either?.leftValue, images, "Wrong either value")
    }

    func test_either_when_images_is_nil() {
        // GIVEN/WHEN
        let image: SwitchUIImages? = nil

        // WHEN
        let either = image.either

        // THEN
        XCTAssertNil(either, "Wrong either value")
    }
}
