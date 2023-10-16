//
//  RadioButtonUIGroupViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 25.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import SparkCore

final class RadioButtonUIGroupViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    var selectedID = "1"

    let items: [RadioButtonUIItem<String>] = [
        RadioButtonUIItem(id: "1",
                          label: "Label 1"),
        RadioButtonUIItem(id: "2",
                          label: "Label 2"),
        RadioButtonUIItem(id: "3",
                          label: "Label 3")
    ]

    // MARK: - Tests

    func test_uikit_radioButtonGroup() throws {
        let items: [RadioButtonUIItem<String>] = [
            RadioButtonUIItem(id: "1",
                              label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
            RadioButtonUIItem(id: "2",
                              label: "2 Radio button"),
            RadioButtonUIItem(id: "3",
                              label: "3 Radio button"),
            RadioButtonUIItem(id: "4",
                              label: "4 Radio button"),
            RadioButtonUIItem(id: "5",
                              label: "5 Radio button"),
            RadioButtonUIItem(id: "6",
                              label: "6 Radio button")
        ]

        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            title: "Radio Button Group (UIKit)",
            selectedID: self.selectedID,
            items: items)

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 400, height: 800))

        scrollView.addSubview(sut)

        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 400),
            sut.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            sut.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            sut.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            sut.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])

        assertSnapshotInDarkAndLight(matching: scrollView)
    }

    func test_uikit_radioButtonGroup_horizontal() throws {
        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            selectedID: self.selectedID,
            items: self.items,
            groupLayout: .horizontal
        )

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_uikit_radioButtonGroup_horizontal_with_title() throws {
        for state in RadioButtonGroupState.allCases {
            let sut = RadioButtonUIGroupView(
                theme: SparkTheme.shared,
                title: "Title",
                selectedID: self.selectedID,
                items: self.items,
                groupLayout: .horizontal,
                state: state,
                supplementaryText: state.supplementaryText
            )

            sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
            sut.translatesAutoresizingMaskIntoConstraints = false

            assertSnapshotInDarkAndLight(matching: sut)
        }
    }


    func test_uikit_radioButtonGroup_vertical_with_title() throws {
        for state in RadioButtonGroupState.allCases {
            let sut = RadioButtonUIGroupView(
                theme: SparkTheme.shared,
                title: "Title",
                selectedID: self.selectedID,
                items: self.items,
                groupLayout: .vertical,
                state: state,
                supplementaryText: state.supplementaryText
            )

            sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
            sut.translatesAutoresizingMaskIntoConstraints = false

            assertSnapshotInDarkAndLight(matching: sut)
        }
    }

    func test_uikit_radioButtonGroup_label_left() throws {
        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            selectedID: self.selectedID,
            items: self.items,
            radioButtonLabelPosition: .left,
            groupLayout: .vertical
        )

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_uikit_radioButtonGroup_label_left_with_title() throws {
        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            title: "Title",
            selectedID: self.selectedID,
            items: self.items,
            radioButtonLabelPosition: .left,
            groupLayout: .vertical
        )

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_uikit_radioButtonGroup_all_states() {
        for state in RadioButtonGroupState.allCases {
            let sut = RadioButtonUIGroupView(
                theme: SparkTheme.shared,
                title: "Title",
                selectedID: self.selectedID,
                items: self.items,
                state: state,
                supplementaryText: state.supplementaryText)

            sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
            sut.translatesAutoresizingMaskIntoConstraints = false

            assertSnapshotInDarkAndLight(matching: sut)
        }
    }

    func test_accessibility_idetifier_propagated_to_items() {
        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            title: "Title",
            selectedID: self.selectedID,
            items: self.items,
            state: .enabled)

        sut.accessibilityIdentifier = "XXX"
        let radioButtonView = sut.subviews.first { view in
            return (view is RadioButtonUIView<String>)
        }
        XCTAssertEqual(radioButtonView?.accessibilityIdentifier, "XXX-0")
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
        case .accent: return nil
        case .basic: return nil
        }
    }
}
