//
//  SwitchImages+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 03/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

extension SwitchImages: Equatable {

    public static func == (lhs: SwitchImages, rhs: SwitchImages) -> Bool {
        return lhs.on == rhs.on && lhs.off == rhs.off
    }
}

final class SwitchImagesExtensionTests: XCTestCase {

    // MARK: - Tests

    func test_either_when_images_is_set() {
        // GIVEN/WHEN
        let images: SwitchImages? = .init(
            on: .init("arrow"),
            off: .init("arrow")
        )

        // WHEN
        let either = images.either

        // THEN
        XCTAssertEqual(either?.rightValue, images, "Wrong either value")
    }

    func test_either_when_images_is_nil() {
        // GIVEN/WHEN
        let image: SwitchImages? = nil

        // WHEN
        let either = image.either

        // THEN
        XCTAssertNil(either, "Wrong either value")
    }
}
