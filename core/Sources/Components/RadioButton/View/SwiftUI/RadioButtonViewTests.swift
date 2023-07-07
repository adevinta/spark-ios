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
        let view = sut(groupState: .enabled, isSelected: false, label: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.").frame(width: 300, height: 300)

        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_enabled_selected() throws {
        let view = sut(groupState: .enabled, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_enabled_not_selected() throws {
        let view = sut(groupState: .enabled, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_disabled_not_selected() throws {
        let view = sut(groupState: .disabled, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_disabled_selected() throws {
        let view = sut(groupState: .disabled, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_success_not_selected() throws {
        let view = sut(groupState: .success, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_success_selected() throws {
        let view = sut(groupState: .success, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_warning_not_selected() throws {
        let view = sut(groupState: .warning, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_warning_selected() throws {
        let view = sut(groupState: .warning, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_error_not_selected() throws {
        let view = sut(groupState: .error, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_error_selected() throws {
        let view = sut(groupState: .error, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func test_label_left() throws {
        let view = sut(groupState: .enabled, isSelected: true, label: "Label")
            .labelPosition(.left)
            .fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    // MARK: - Private Helper Functions
    func sut(groupState: RadioButtonGroupState, isSelected: Bool, label: String? = nil) -> RadioButtonView<Int> {

        let selectedID = Binding<Int> (
            get: { return self.boundSelectedID },
            set: { self.boundSelectedID = $0 }
        )

        return RadioButtonView(
            theme: SparkTheme.shared,
            id: isSelected ? self.boundSelectedID : 1,
            label: label ?? groupState.label(isSelected: isSelected),
            selectedID: selectedID,
            groupState: groupState
        )
    }
}

private extension RadioButtonGroupState {
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
