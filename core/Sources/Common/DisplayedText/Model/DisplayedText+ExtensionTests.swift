//
//  DisplayedText+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension DisplayedText {

    // MARK: - Properties

    static func mocked(
        text: String = "My text"
    ) -> Self {
        return .init(
            text: text
        )
    }
}
