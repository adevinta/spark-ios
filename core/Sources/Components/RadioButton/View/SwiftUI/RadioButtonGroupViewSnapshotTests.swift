//
//  RadioButtonGroupViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 26.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import SparkCore

final class RadioButtonGroupViewSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties
    var backingSelectedID = 1
    lazy var selectedID: Binding<Int> = {
        Binding<Int>(
            get: { return self.backingSelectedID},
            set: { self.backingSelectedID = $0 }
        )
    }()

    private let items = [
        RadioButtonItem(id: 1,
                        label: "Label 1"),
        RadioButtonItem(id: 2,
                        label: "Label 2")
    ]

    private var allItems = [
        RadioButtonItem(id: 1,
                        label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        RadioButtonItem(id: 2,
                        label: "2 Radio button"),
        RadioButtonItem(id: 3,
                        label: "3 Radio button"),
        RadioButtonItem(id: 4,
                        label: "4 Radio button"),
        RadioButtonItem(id: 5,
                        label: "5 Radio button"),
        RadioButtonItem(id: 6,
                        label: "6 Radio button")
    ]

    // MARK: - Tests
    func test_group_all_states() {
        for state in RadioButtonGroupState.allCases {
            let sut = RadioButtonGroupView(
                theme: SparkTheme.shared,
                title: "Radio Button Group (SwiftUI)",
                selectedID: self.selectedID,
                items: self.allItems,
                state: state,
                supplementaryLabel: state.supplementaryText)
                .frame(width: 400)
                .fixedSize(horizontal: false, vertical: true)

            assertSnapshotInDarkAndLight(matching: sut)
        }
    }

    // MARK: - Tests
    func test_group_left_label() {
        let sut = RadioButtonGroupView(
            theme: SparkTheme.shared,
            title: "Radio Button Group (SwiftUI)",
            selectedID: self.selectedID,
            items: self.allItems,
            radioButtonLabelPosition: .left)
            .frame(width: 400)
            .fixedSize(horizontal: false, vertical: true)

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_horizontal_group_with_title() {
        let sut = RadioButtonGroupView(
            theme: SparkTheme.shared,
            title: "Radio Button Horizontal Group (SwiftUI)",
            selectedID: self.selectedID,
            items: self.items,
            groupLayout: .horizontal
        ).fixedSize()

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_horizontal_group_no_title() {
        let sut = RadioButtonGroupView(
            theme: SparkTheme.shared,
            selectedID: self.selectedID,
            items: self.items,
            groupLayout: .horizontal
        ).fixedSize()

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_vertical_group_no_title_left_label() {
        let sut = RadioButtonGroupView(
            theme: SparkTheme.shared,
            selectedID: self.selectedID,
            items: self.items,
            radioButtonLabelPosition: .left,
            groupLayout: .vertical
        ).fixedSize()

        assertSnapshotInDarkAndLight(matching: sut)
    }
}

private extension RadioButtonGroupState {
    var supplementaryText: String? {
        switch self {
        case .disabled: return nil
        case .enabled: return nil
        case .error: return "Error"
        case .warning: return "Warning"
        case .success: return "Success"
        case .accent: return "Accent"
        case .basic: return "Basic"
        }
    }
}
