//
//  SwitchStatusColors+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 07/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SparkThemingTesting

extension SwitchStatusColors {

    // MARK: - Properties

    static func mocked(
        onColorToken: any ColorToken = ColorTokenGeneratedMock.random(),
        offColorToken: any ColorToken = ColorTokenGeneratedMock.random()
    ) -> Self {
        return .init(
            onColorToken: onColorToken,
            offColorToken: offColorToken
        )
    }
}
