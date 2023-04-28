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

final class CheckboxGroupUIViewTests: TestCase {
    private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItem(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItem(title: "Cake", id: "2", selectionState: .indeterminate),
        CheckboxGroupItem(title: "Fish", id: "3", selectionState: .unselected),
        CheckboxGroupItem(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItem(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
    ]

    private func createGroupView(position: CheckboxPosition) -> UIView {
        let theming = SparkTheme.shared

        let groupView = CheckboxGroupUIView(
            items: .init(
                get: { [weak self] in
                    self?.items ?? []
                },
                set: { [weak self] in
                    self?.items = $0
                }
            ),
            layout: .vertical,
            checkboxPosition: position,
            theming: theming,
            accessibilityIdentifierPrefix: "abc"
        )
        groupView.translatesAutoresizingMaskIntoConstraints = false
        return groupView
    }

    func test_left_layout() throws {
        let group = self.createGroupView(position: .left)
        sparktAssertSnapshot(matching: group, as: .image)
    }

    func test_right_layout() throws {
        let group = self.createGroupView(position: .right)
        sparktAssertSnapshot(matching: group, as: .image)
    }

    func test_left_layout_dark_mode() throws {
        let group = self.createGroupView(position: .left)
        group.overrideUserInterfaceStyle = .dark
        sparktAssertSnapshot(matching: group, as: .image)
    }

    func test_right_layout_dark_mode() throws {
        let group = self.createGroupView(position: .right)
        group.overrideUserInterfaceStyle = .dark
        sparktAssertSnapshot(matching: group, as: .image)
    }
}
