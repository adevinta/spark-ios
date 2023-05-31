//
//  SparkCheckboxView.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import Spark
@testable import SparkCore

final class CheckboxViewTests: SwiftUIComponentTestCase {
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

            assertSnapshotInDarkAndLight(matching: view, named: state.identifier)
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

            assertSnapshotInDarkAndLight(matching: view, named: state.identifier)
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

            assertSnapshotInDarkAndLight(matching: view, named: state.identifier)
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

            assertSnapshotInDarkAndLight(matching: view, named: state.identifier)
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

            assertSnapshotInDarkAndLight(matching: view, named: state.identifier)
        }
    }
}

// MARK: - Mock used for testing

final class CheckboxGroupItem: CheckboxGroupItemProtocol, Hashable {
    static func == (lhs: CheckboxGroupItem, rhs: CheckboxGroupItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    var title: String
    var id: String
    var selectionState: CheckboxSelectionState
    var state: SelectButtonState

    init(
        title: String,
        id: String,
        selectionState: CheckboxSelectionState,
        state: SelectButtonState = .enabled
    ) {
        self.title = title
        self.id = id
        self.selectionState = selectionState
        self.state = state
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
        }
    }
}
