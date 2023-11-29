//
//  ControlStateImageTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI

@testable import SparkCore

final class ControlStateImageTests: XCTestCase {

    // MARK: - Tests

    func test_default_image() {
        // GIVEN / WHEN
        let controlStateImage = ControlStateImage()

        // THEN
        XCTAssertNil(controlStateImage.image)
    }

    func test_setImage() {
        // GIVEN
        let givenImage = Image("arrow")

        let controlStateImage = ControlStateImage()

        let statesMock = ControlPropertyStates<Image>()
        statesMock.setValue(
            givenImage,
            for: .normal
        )

        // WHEN
        controlStateImage.setImage(
            givenImage,
            for: .normal,
            on: .init()
        )

        // THEN
        XCTAssertEqual(
            controlStateImage.image,
            statesMock.value(for: .normal)
        )
    }

    func test_updateContent() {
        // GIVEN
        let givenDisabledImage = Image("switchOff")

        let control = Control(isDisabled: true)

        let controlStateImage = ControlStateImage()

        let statesMock = ControlPropertyStates<Image>()

        controlStateImage.setImage(
            givenDisabledImage,
            for: .disabled,
            on: .init()
        )
        statesMock.setValue(
            givenDisabledImage,
            for: .disabled
        )

        // WHEN
        controlStateImage.updateContent(from: control)

        // THEN
        XCTAssertEqual(
            controlStateImage.image,
            statesMock.value(for: .disabled)
        )
    }
}
