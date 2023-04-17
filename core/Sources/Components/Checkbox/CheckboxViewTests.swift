//
//  SparkCheckboxView.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore
@testable import Spark

final class SparkCheckboxViewTests: TestCase {
    let theming = CheckboxTheming(theme: SparkTheme())

    func testCheckboxSelected() throws {
        let view = CheckboxView(
            text: "Selected checkbox.",
            theming: theming,
            selectionState: .init(get: { .selected }, set: { _ in }),
            accessibilityIdentifier: "test"
        ).fixedSize()

        sparktAssertSnapshot(matching: view, as: .image)
    }

    func testCheckboxUnselected() throws {
        let view = CheckboxView(
            text: "Unselected checkbox.",
            theming: theming,
            selectionState: .init(get: { .unselected }, set: { _ in }),
            accessibilityIdentifier: "test"
        ).fixedSize()

        sparktAssertSnapshot(matching: view, as: .image)
    }

    func testCheckboxIndeterminate() throws {
        let view = CheckboxView(
            text: "Indeterminate checkbox.",
            theming: theming,
            selectionState: .init(get: { .indeterminate }, set: { _ in }),
            accessibilityIdentifier: "test"
        ).fixedSize()

        sparktAssertSnapshot(matching: view, as: .image)
    }

    func testCheckboxMultiline() throws {
        let view = CheckboxView(
            text: "Multiline checkbox.\nMore text.",
            theming: theming,
            selectionState: .init(get: { .unselected }, set: { _ in }),
            accessibilityIdentifier: "test"
        ).fixedSize()

        sparktAssertSnapshot(matching: view, as: .image)
    }
}
