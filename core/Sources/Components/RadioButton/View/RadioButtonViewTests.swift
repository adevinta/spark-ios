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

final class RadioButtonViewTests: TestCase {

    var boundSelectedID = 0

    func x_test_multiline_label() throws {
        let view = sut(state: .enabled, isSelected: false, label: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.").frame(width: 300, height: 300)

        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_enabled_selected() throws {
        let view = sut(state: .enabled, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_enabled_not_selected() throws {
        let view = sut(state: .enabled, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_disabled_not_selected() throws {
        let view = sut(state: .disabled, isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_disabled_selected() throws {
        let view = sut(state: .disabled, isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_success_not_selected() throws {
        let view = sut(state: .success(message: "Message"), isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_success_selected() throws {
        let view = sut(state: .success(message: "Message"), isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_warning_not_selected() throws {
        let view = sut(state: .warning(message: "Message"), isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_warning_selected() throws {
        let view = sut(state: .warning(message: "Message"), isSelected: true).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_error_not_selected() throws {
        let view = sut(state: .error(message: "Message"), isSelected: false).fixedSize()
        assertSnapshotInDarkAndLight(matching: view)
    }

    func x_test_error_selected() throws {
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

public func assertSnapshotInDarkAndLight(
    matching view: @autoclosure () -> some View,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    sparktAssertSnapshot(
        matching: view(),
        as: .image(precision: 0.98,
                   perceptualPrecision: 0.98,
                   traits: .darkMode),
        named: name.map{ "\($0)-dark" } ?? "\(testName)-dark",
        record: recording,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
    )
    sparktAssertSnapshot(
        matching: view(),
        as: .image(precision: 0.98,
                   perceptualPrecision: 0.98),
        named: name.map{ "\($0)-light" } ?? "\(testName)-light",
        record: recording,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
    )

}

private extension UITraitCollection {
    static let darkMode: UITraitCollection = .init(
        traitsFrom: [
        .init(userInterfaceStyle: .dark)
        ])
}
