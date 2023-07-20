//
//  ButtonCurrentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ButtonCurrentColors {

    // MARK: - Properties

    static func mocked(
        foregroundColor: any ColorToken = ColorTokenGeneratedMock.random(),
        backgroundColor: any ColorToken = ColorTokenGeneratedMock.random(),
        borderColor: any ColorToken = ColorTokenGeneratedMock.random()
    ) -> Self {
        return .init(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            borderColor: borderColor
        )
    }
}
