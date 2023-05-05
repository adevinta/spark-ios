//
//  CheckboxUIViewTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 25.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import Spark
@testable import SparkCore

final class CheckboxUIViewTests: TestCase {
    let theme: Theme = SparkTheme.shared

    let states = [SelectButtonState.disabled, .enabled, .success(message: "Success message!"), .warning(message: "Warning message!"), .error(message: "Error message!")]

    override class func setUp() {
        super.setUp()
    }

    func test_right_aligned() throws {
        for state in self.states {
            let checkbox = CheckboxUIView(
                theme: self.theme,
                text: "Selected checkbox.",
                state: state,
                selectionState: .selected,
                checkboxPosition: .right
            )

            sparktAssertSnapshot(matching: checkbox, as: .image, named: state.identifier)
        }
    }

    func test_checkbox_selected() throws {
        for state in self.states {
            let checkbox = CheckboxUIView(
                theme: self.theme,
                text: "Selected checkbox.",
                state: state,
                selectionState: .selected,
                checkboxPosition: .left
            )

            sparktAssertSnapshot(matching: checkbox, as: .image, named: state.identifier)
        }
    }

    func test_checkbox_unselected() throws {
        for state in self.states {
            let checkbox = CheckboxUIView(
                theme: self.theme,
                text: "Unselected checkbox.",
                state: state,
                selectionState: .unselected,
                checkboxPosition: .left
            )

            sparktAssertSnapshot(matching: checkbox, as: .image, named: state.identifier)
        }
    }

    func test_checkbox_indeterminate() throws {
        for state in self.states {
            let checkbox = CheckboxUIView(
                theme: self.theme,
                text: "Indeterminate checkbox.",
                state: state,
                selectionState: .indeterminate,
                checkboxPosition: .left
            )

            sparktAssertSnapshot(matching: checkbox, as: .image, named: state.identifier)
        }
    }

    func test_checkbox_multiline() throws {
        for state in self.states {
            let view = CheckboxUIView(
                theme: self.theme,
                text: "Multiline checkbox.\nMore text.",
                state: state,
                selectionState: .selected,
                checkboxPosition: .left
            )

            sparktAssertSnapshot(matching: view, as: .image, named: state.identifier)
        }
    }
}
