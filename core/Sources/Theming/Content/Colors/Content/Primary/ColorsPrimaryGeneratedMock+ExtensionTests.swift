//
//  ColorsPrimaryGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsPrimaryGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsPrimaryGeneratedMock {
        let mock = ColorsPrimaryGeneratedMock()

        mock.underlyingPrimary = ColorTokenGeneratedMock.random()
        mock.underlyingOnPrimary = ColorTokenGeneratedMock.random()

        mock.underlyingPrimaryVariant = ColorTokenGeneratedMock.random()
        mock.underlyingOnPrimaryVariant = ColorTokenGeneratedMock.random()

        mock.underlyingPrimaryContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnPrimaryContainer = ColorTokenGeneratedMock.random()

        return mock
    }
}
