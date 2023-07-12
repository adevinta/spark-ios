//
//  TagColors+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 07/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension TagColors {

    // MARK: - Properties

    static func mocked(
        backgroundColor: any ColorToken = ColorTokenGeneratedMock.random(),
        borderColor: any ColorToken = ColorTokenGeneratedMock.random(),
        foregroundColor: any ColorToken = ColorTokenGeneratedMock.random()
    ) -> Self {
        return .init(
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            foregroundColor: foregroundColor
        )
    }
}
