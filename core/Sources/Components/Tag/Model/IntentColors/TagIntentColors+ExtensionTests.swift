//
//  TagIntentColors+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 07/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension TagIntentColors {

    // MARK: - Properties

    static func mocked() -> Self {
        return .init(
            color: ColorTokenGeneratedMock.random(),
            onColor: ColorTokenGeneratedMock.random(),
            containerColor: ColorTokenGeneratedMock.random(),
            onContainerColor: ColorTokenGeneratedMock.random(),
            surfaceColor: ColorTokenGeneratedMock.random()
        )
    }
}
