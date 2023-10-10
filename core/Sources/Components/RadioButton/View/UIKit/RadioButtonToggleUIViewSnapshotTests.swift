//
//  RadioButtonToggleUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 06.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import SparkCore

final class RadioButtonToggleUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    func test_not_pressed() {
        let sut = RadioButtonToggleUIView(haloColor: .gray, buttonColor: .blue, fillColor: .green)
        sut.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshot(matching: sut)
    }

    func test_pressed() {
        let sut = RadioButtonToggleUIView(haloColor: .gray, buttonColor: .red, fillColor: .orange)
        sut.isPressed = true
        sut.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshot(matching: sut)
    }

}
