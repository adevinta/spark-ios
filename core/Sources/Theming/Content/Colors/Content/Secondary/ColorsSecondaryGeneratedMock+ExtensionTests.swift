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

        mock.underlyingSecondary = ColorTokenGeneratedMock()
        mock.underlyingOnSecondary = ColorTokenGeneratedMock()

        mock.underlyingSecondaryVariant = ColorTokenGeneratedMock()
        mock.underlyingOnSecondaryVariant = ColorTokenGeneratedMock()
        
        mock.underlyingSecondaryContainer = ColorTokenGeneratedMock()
        mock.underlyingOnSecondaryContainer = ColorTokenGeneratedMock()

        return mock
    }
}
