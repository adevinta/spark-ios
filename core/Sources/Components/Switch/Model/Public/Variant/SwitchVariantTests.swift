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

    // MARK: - Equatable

    func test_equatable() {
        // GIVEN
        let onImageMock = Image(systemName: "square.and.arrow.up")
        let offImageMock = Image(systemName: "square.and.arrow.down")

        let badOnImage2Mock = Image(systemName: "scribble")
        let badOffImage2Mock = Image(systemName: "pencil")

        let onUIImageMock = IconographyTests.shared.switchOn
        let offUIImageMock = IconographyTests.shared.switchOff

        let badOnUIImage2Mock = IconographyTests.shared.checkmark
        let badOffUIImage2Mock = IconographyTests.shared.checkmark

        // WHEN
        let variant = SwitchVariant(onImage: onImageMock, offImage: offImageMock)
        let variant2 = SwitchVariant(onImage: onImageMock, offImage: badOffImage2Mock) // Only onImage is equals
        let variant3 = SwitchVariant(onImage: badOnImage2Mock, offImage: offImageMock) // Only offImage is equals
        let variant4 = SwitchVariant(onImage: badOnImage2Mock, offImage: badOffImage2Mock) // None images are equals

        let uiKitVariant = SwitchVariant(onImage: onUIImageMock, offImage: offUIImageMock)
        let uiKitVariant2 = SwitchVariant(onImage: onUIImageMock, offImage: badOffUIImage2Mock) // Only onImage is equals
        let uiKitVariant3 = SwitchVariant(onImage: badOnUIImage2Mock, offImage: offUIImageMock) // Only offImage is equals
        let uiKitVariant4 = SwitchVariant(onImage: badOnUIImage2Mock, offImage: badOffUIImage2Mock) // None images are equals

        // THEN
        XCTAssertEqual(variant,
                       .init(onImage: onImageMock, offImage: offImageMock),
                       "variants should be equal")
        XCTAssertNotEqual(variant,
                          variant2,
                          "variant should no be equal to variant2")
        XCTAssertNotEqual(variant,
                          variant3,
                          "variant should no be equal to variant3")
        XCTAssertNotEqual(variant,
                          variant4,
                          "variant should no be equal to variant4")

        XCTAssertEqual(uiKitVariant,
                       .init(onImage: onUIImageMock, offImage: offUIImageMock),
                       "uiKitVariants should be equal")
        XCTAssertNotEqual(uiKitVariant,
                          uiKitVariant2,
                          "uiKitVariant should no be equal to uiKitVariant2")
        XCTAssertNotEqual(uiKitVariant,
                          uiKitVariant3,
                          "uiKitVariant should no be equal to uiKitVariant3")
        XCTAssertNotEqual(uiKitVariant,
                          uiKitVariant4,
                          "uiKitVariant should no be equal to uiKitVariant4")
    }
}
