//
//  ColorsSecondaryGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsSecondaryGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsSecondaryGeneratedMock {
        let mock = ColorsSecondaryGeneratedMock()

        mock.underlyingSecondary = ColorTokenGeneratedMock.random()
        mock.underlyingOnSecondary = ColorTokenGeneratedMock.random()

        mock.underlyingSecondaryVariant = ColorTokenGeneratedMock.random()
        mock.underlyingOnSecondaryVariant = ColorTokenGeneratedMock.random()
        
        mock.underlyingSecondaryContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnSecondaryContainer = ColorTokenGeneratedMock.random()

        return mock
    }
}
