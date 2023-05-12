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

final class RadioButtonUIGroupViewTests: TestCase {
    var backingSelectedID = "1"

    lazy var selectedID: Binding<String> = {
        Binding(
            get: { return self.backingSelectedID },
            set: { self.backingSelectedID = $0 }
        )
    }()


    func test_radioButtonGroup() throws {
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

        sut.frame = CGRect(x: 0, y: 0, width: 353, height: 523)
        sut.backgroundColor = SparkTheme.shared.colors.base.background.uiColor

        assertSnapshotInDarkAndLight(matching: sut)
    }

}

public func assertSnapshotInDarkAndLight(
    matching view: @autoclosure () -> some UIView,
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
        named: name,
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
        named: name,
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
            .init(userInterfaceStyle: .dark),
        ])
}
