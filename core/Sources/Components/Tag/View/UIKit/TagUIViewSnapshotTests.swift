//
//  TagUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 04/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SparkCore

final class TagUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let strategies = TagSutSnapshotStrategy.allCases

        for strategy in strategies {
            let suts = TagSutSnapshotTests.test(
                for: strategy,
                isSwiftUIComponent: false
            )
            for sut in suts {

                var view: TagUIView?
                switch (sut.iconImage, sut.text) {
                case (nil, nil):
                    XCTFail("Icon or text should be set")

                case (let iconImage?, nil):
                    view = TagUIView(
                        theme: self.theme,
                        intent: sut.intent,
                        variant: sut.variant,
                        iconImage: iconImage.leftValue
                    )
                case (nil, let text?):
                    view = TagUIView(
                        theme: self.theme,
                        intent: sut.intent,
                        variant: sut.variant,
                        text: text
                    )
                case let (iconImage?, text?):
                    view = TagUIView(
                        theme: self.theme,
                        intent: sut.intent,
                        variant: sut.variant,
                        iconImage: iconImage.leftValue,
                        text: text
                    )
                }

                guard let view else {
                    return
                }

                view.translatesAutoresizingMaskIntoConstraints = false
                if let width = sut.width {
                    view.widthAnchor.constraint(equalToConstant: width).isActive = true
                }

                self.assertSnapshot(
                    matching: view,
                    modes: sut.modes,
                    sizes: sut.sizes,
                    testName: sut.testName()
                )
            }
        }
    }
}
