//
//  CheckboxGroupViewTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 27.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import Spark
@testable import SparkCore

final class CheckboxGroupViewTests: SwiftUIComponentTestCase {
    // MARK: - Container View

    private struct GroupView: View {
        let position: CheckboxPosition

        let theme: Theme = SparkTheme.shared

        let checkedImage = IconographyTests.shared.checkmark

        @State private var items: [any CheckboxGroupItemProtocol] = [
            CheckboxGroupItem(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
            CheckboxGroupItem(title: "Cake", id: "2", selectionState: .indeterminate),
            CheckboxGroupItem(title: "Fish", id: "3", selectionState: .unselected),
            CheckboxGroupItem(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
            CheckboxGroupItem(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
        ]

        var body: some View {
            CheckboxGroupView(
                checkedImage: self.checkedImage,
                items: self.$items,
                checkboxPosition: self.position,
                theme: self.theme,
                accessibilityIdentifierPrefix: "group"
            ).fixedSize()
        }
    }

    // MARK: - Tests

    func test_left_layout() throws {
        let group = GroupView(position: .left)
        assertSnapshotInDarkAndLight(matching: group)
    }

    func test_right_layout() throws {
        let group = GroupView(position: .right)
        assertSnapshotInDarkAndLight(matching: group)
    }
}
