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

@testable import SparkCore

final class CheckboxGroupUIViewSnapshotTests: UIKitComponentSnapshotTestCase {
    private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItemDefault(title: "Cake", id: "2", selectionState: .indeterminate),
        CheckboxGroupItemDefault(title: "Fish", id: "3", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItemDefault(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
    ]

    private func createGroupView(position: CheckboxPosition) -> UIView {
        let theme = SparkTheme.shared
        let checkedImage = IconographyTests.shared.checkmark

        let groupView = CheckboxGroupUIView(
            checkedImage: checkedImage,
            items: self.items,
            layout: .vertical,
            checkboxPosition: position,
            theme: theme,
            accessibilityIdentifierPrefix: "abc"
        )
        groupView.translatesAutoresizingMaskIntoConstraints = false
        return groupView
    }

    // MARK: - Tests

    func test_left_layout() throws {
        let group = self.createGroupView(position: .left)
        assertSnapshot(of: group)
    }

    func test_right_layout() throws {
        let group = self.createGroupView(position: .right)
        assertSnapshot(of: group)
    }
}
