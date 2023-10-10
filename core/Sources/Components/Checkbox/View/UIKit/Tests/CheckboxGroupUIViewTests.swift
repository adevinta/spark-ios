//
//  CheckboxGroupUIViewTests.swift
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

final class CheckboxGroupUIViewTests: UIKitComponentTestCase {
    private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItem(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItem(title: "Cake", id: "2", selectionState: .indeterminate),
        CheckboxGroupItem(title: "Fish", id: "3", selectionState: .unselected),
        CheckboxGroupItem(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItem(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
    ]

    private func createGroupView(position: checkboxAlignment) -> UIView {
        let theme = SparkTheme.shared
        let checkedImage = IconographyTests.shared.checkmark

        let groupView = CheckboxGroupUIView(
            checkedImage: checkedImage,
            items: self.items,
            layout: .vertical,
            checkboxAlignment: position,
            theme: theme,
            accessibilityIdentifierPrefix: "abc"
        )
        groupView.translatesAutoresizingMaskIntoConstraints = false
        return groupView
    }

    // MARK: - Tests

    func test_left_layout() throws {
        let group = self.createGroupView(position: .left)
        assertSnapshotInDarkAndLight(matching: group)
    }

    func test_right_layout() throws {
        let group = self.createGroupView(position: .right)
        assertSnapshotInDarkAndLight(matching: group)
    }
}
