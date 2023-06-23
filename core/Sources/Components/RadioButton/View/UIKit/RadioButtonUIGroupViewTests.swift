//
//  RadioButtonUIGroupViewTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 25.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import Spark
@testable import SparkCore

final class RadioButtonUIGroupViewTests: UIKitComponentTestCase {

    // MARK: - Properties

    var selectedID = "1"

    let items: [RadioButtonItem<String>] = [
        RadioButtonItem(id: "1",
                        label: "Label 1"),
        RadioButtonItem(id: "2",
                        label: "Label 2"),
        RadioButtonItem(id: "3",
                        label: "Label 3")
    ]

    // MARK: - Tests

    func test_uikit_radioButtonGroup() throws {
        let items: [RadioButtonItem<String>] = [
            RadioButtonItem(id: "1",
                            label: "1 Lorem Ipsum is dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
            RadioButtonItem(id: "2",
                            label: "2 Radio button / Enabled",
                            state: .enabled),
            RadioButtonItem(id: "3",
                            label: "3 Radio button / Disabled",
                            state: .disabled),
            RadioButtonItem(id: "4",
                            label: "4 Radio button / Error",
                            state: .error(message: "Error")),
            RadioButtonItem(id: "5",
                            label: "5 Radio button / Success",
                            state: .success(message: "Success")),
            RadioButtonItem(id: "6",
                            label: "6 Radio button / Warning",
                            state: .warning(message: "Warning")),
        ]

        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            title: "Radio Button Group (UIKit)",
            selectedID: self.selectedID,
            items: items,
            isAutoscalingEnabled: true)

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
            groupLayout: .horizontal,
            isAutoscalingEnabled: true
        )

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_uikit_radioButtonGroup_horizontal_with_title() throws {
        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            title: "Title",
            selectedID: self.selectedID,
            items: self.items,
            groupLayout: .horizontal,
            isAutoscalingEnabled: true
        )

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshotInDarkAndLight(matching: sut)
    }

    func test_uikit_radioButtonGroup_label_left() throws {
        let sut = RadioButtonUIGroupView(
            theme: SparkTheme.shared,
            selectedID: self.selectedID,
            items: self.items,
            radioButtonLabelPosition: .left,
            groupLayout: .vertical,
            isAutoscalingEnabled: true
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
            groupLayout: .vertical,
            isAutoscalingEnabled: true
        )

        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor
        sut.translatesAutoresizingMaskIntoConstraints = false

        assertSnapshotInDarkAndLight(matching: sut)
    }

}
