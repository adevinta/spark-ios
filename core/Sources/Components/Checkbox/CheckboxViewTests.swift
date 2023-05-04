//
//  SparkCheckboxView.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI

@testable import SparkCore
@testable import Spark

final class CheckboxViewTests: TestCase {
    let theme: Theme = SparkTheme()

    func test_checkbox_selected() throws {
        let view = CheckboxView(
            text: "Selected checkbox.",
            theme: self.theme,
            selectionState: .init(get: { .selected }, set: { _ in })
        ).fixedSize().environment(\.sizeCategory, .medium)

        sparktAssertSnapshot(matching: view, as: .image)
    }

    func test_checkbox_unselected() throws {
        let view = CheckboxView(
            text: "Unselected checkbox.",
            theme: self.theme,
            selectionState: .init(get: { .unselected }, set: { _ in })
        ).fixedSize().environment(\.sizeCategory, .medium)

        sparktAssertSnapshot(matching: view, as: .image)
    }

    func test_checkbox_indeterminate() throws {
        let view = CheckboxView(
            text: "Indeterminate checkbox.",
            theme: self.theme,
            selectionState: .init(get: { .indeterminate }, set: { _ in })
        )
        .fixedSize().environment(\.sizeCategory, .medium)

        sparktAssertSnapshot(matching: view, as: .image)
    }

    func test_checkbox_multiline() throws {
        let view = CheckboxView(
            text: "Multiline checkbox.\nMore text.",
            theme: self.theme,
            selectionState: .init(get: { .unselected }, set: { _ in })
        ).fixedSize().environment(\.sizeCategory, .medium)

        sparktAssertSnapshot(matching: view, as: .image)
    }
}
