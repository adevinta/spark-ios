//
//  TabItemUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 02.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import Spark
@testable import SparkCore
import XCTest

final class TabItemUIViewSnapshotTests: UIKitComponentTestCase {
    let theme = SparkTheme.shared

    func test_selected_tab() throws {
        let sut = TabItemUIView(
            theme: theme,
            intent: .main,
            icon: UIImage(systemName: "fleuron.fill"))

        assertSnapshotInDarkAndLight(matching: sut)
    }
}
