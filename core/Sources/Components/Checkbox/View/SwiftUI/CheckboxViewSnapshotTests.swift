//
//  CheckboxViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import SparkCore

final class CheckboxViewSnapshotTests: SwiftUIComponentSnapshotTestCase {
    let theme: Theme = SparkTheme()

    let checkedImage = IconographyTests.shared.checkmark

    let states = [SelectButtonState.disabled, .enabled, .success(message: "Success message!"), .warning(message: "Warning message!"), .error(message: "Error message!")]

    // MARK: - Tests

    func test_right_aligned() throws {
        for state in self.states {
            let view = CheckboxView(
                text: "Selected checkbox.",
                checkedImage: self.checkedImage,
                checkboxPosition: .right,
                theme: self.theme,
                state: state,
                selectionState: .init(
                    get: { .selected },
                    set: { _ in }
                )
            ).fixedSize()

            assertSnapshot(of: view, named: state.identifier)
        }
    }

    func test_checkbox_selected() throws {
        for state in self.states {
            let view = CheckboxView(
                text: "Selected checkbox.",
                checkedImage: self.checkedImage,
                theme: self.theme,
                state: state,
                selectionState: .init(
                    get: { .selected },
                    set: { _ in }
                )
            ).fixedSize().environment(\.sizeCategory, .medium)

            assertSnapshot(of: view, named: state.identifier)
        }
    }

    func test_checkbox_unselected() throws {
        for state in self.states {
            let view = CheckboxView(
                text: "Unselected checkbox.",
                checkedImage: self.checkedImage,
                theme: self.theme,
                state: state,
                selectionState: .init(
                    get: { .unselected },
                    set: { _ in }
                )
            ).fixedSize().environment(\.sizeCategory, .medium)

            assertSnapshot(of: view, named: state.identifier)
        }
    }

    func test_checkbox_indeterminate() throws {
        for state in self.states {
            let view = CheckboxView(
                text: "Indeterminate checkbox.",
                checkedImage: self.checkedImage,
                theme: self.theme,
                state: state,
                selectionState: .init(
                    get: { .indeterminate },
                    set: { _ in }
                )
            ).fixedSize().environment(\.sizeCategory, .medium)

            assertSnapshot(of: view, named: state.identifier)
        }
    }

    func test_checkbox_multiline() throws {
        for state in self.states {
            let view = CheckboxView(
                text: "Multiline checkbox.\nMore text.",
                checkedImage: self.checkedImage,
                theme: self.theme,
                state: state,
                selectionState: .init(
                    get: { .unselected },
                    set: { _ in }
                )
            ).fixedSize().environment(\.sizeCategory, .medium)

            assertSnapshot(of: view, named: state.identifier)
        }
    }
}

// MARK: - Private extension

extension SelectButtonState {
    var identifier: String {
        switch self {
        case .disabled:
            return "disabled"
        case .enabled:
            return "enabled"
        case .warning:
            return "warning"
        case .error:
            return "error"
        case .success:
            return "success"
        case .accent:
            return "accent"
        case .basic:
            return "basic"
        }
    }
}
