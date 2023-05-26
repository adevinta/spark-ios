//
//  RadioButtonUIGroupViewTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 25.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

import SnapshotTesting
@testable import Spark
@testable import SparkCore
import SwiftUI
import XCTest

final class RadioButtonUIGroupViewTests: UIKitComponentTestCase {

    // MARK: - Properties

    var backingSelectedID = "1"

    lazy var selectedID: Binding<String> = {
        Binding(
            get: { return self.backingSelectedID },
            set: { self.backingSelectedID = $0 }
        )
    }()

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
}
