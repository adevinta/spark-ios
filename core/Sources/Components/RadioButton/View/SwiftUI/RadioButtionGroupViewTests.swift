//
//  RadioButtionGroupViewTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 26.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
@testable import Spark
@testable import SparkCore
import SwiftUI
import XCTest

final class RadioButtionGroupViewTests: SwiftUIComponentTestCase {

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

    // MARK: - Tests
    func test_group() {
        let sut = RadioButtonGroupView(
            theme: SparkTheme.shared,
            title: "Radio Button Group (SwiftUI)",
            selectedID: self.selectedID,
            items: [
                RadioButtonItem(id: 1,
                                label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
                RadioButtonItem(id: 2,
                                label: "2 Radio button / Enabled",
                                state: .enabled),
                RadioButtonItem(id: 3,
                                label: "3 Radio button / Disabled",
                                state: .disabled),
                RadioButtonItem(id: 4,
                                label: "4 Radio button / Error",
                                state: .error(message: "Error")),
                RadioButtonItem(id: 5,
                                label: "5 Radio button / Success",
                                state: .success(message: "Success")),
                RadioButtonItem(id: 6,
                                label: "6 Radio button / Warning",
                                state: .warning(message: "Warning"))])
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
