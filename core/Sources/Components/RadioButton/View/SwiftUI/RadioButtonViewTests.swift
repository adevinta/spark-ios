//
//  RadioButtonViewTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 14.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
@testable import Spark
@testable import SparkCore
import SwiftUI
import XCTest

final class RadioButtonViewTests: SwiftUIComponentTestCase {

    // MARK: - Properties
    var boundSelectedID = 0

    // MARK: - Tests
    func test_multiline_label() throws {
        let view = sut(state: .enabled, isSelected: false, label: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.").frame(width: 300, height: 300)

        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_enabled_selected() throws {
        let view = sut(state: .enabled, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_enabled_not_selected() throws {
        let view = sut(state: .enabled, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_disabled_not_selected() throws {
        let view = sut(state: .disabled, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_disabled_selected() throws {
        let view = sut(state: .disabled, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_success_not_selected() throws {
        let view = sut(state: .success(message: "Message"), isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_success_selected() throws {
        let view = sut(state: .success(message: "Message"), isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_warning_not_selected() throws {
        let view = sut(state: .warning(message: "Message"), isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_warning_selected() throws {
        let view = sut(state: .warning(message: "Message"), isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_error_not_selected() throws {
        let view = sut(state: .error(message: "Message"), isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_error_selected() throws {
        let view = sut(state: .error(message: "Message"), isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    // MARK: - Private Helper Functions
    func sut(state: SparkSelectButtonState, isSelected: Bool, label: String? = nil) -> RadioButtonView<Int> {
        let selectedID = Binding<Int> (
            get: { return self.boundSelectedID },
            set: { self.boundSelectedID = $0 }
        )

        return RadioButtonView(
            theme: SparkTheme.shared,
            id: isSelected ? self.boundSelectedID : 1,
            label: label ?? state.label(isSelected: isSelected),
            selectedID: selectedID,
            state: state
        )
    }
}

private extension SparkSelectButtonState {
    func label(isSelected: Bool) -> String {
        let selected = isSelected ? "Selected" : "Not Selected"

        switch self {
        case .enabled: return "Enabled / " + selected
        case .disabled: return "Disabled / " + selected
        case .error: return "Error / " + selected
        case .success: return "Success / " + selected
        case .warning: return "Warning / " + selected
        }
    }
}
