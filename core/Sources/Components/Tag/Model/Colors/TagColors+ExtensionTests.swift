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

    static func mocked() -> Self {
        return .init(
            backgroundColor: ColorTokenGeneratedMock.random(),
            borderColor: ColorTokenGeneratedMock.random(),
            foregroundColor: ColorTokenGeneratedMock.random()
        )
    }
}
