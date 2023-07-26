//
//  ColorsMainGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsMainGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsMainGeneratedMock {
        let mock = ColorsMainGeneratedMock()

        mock.underlyingMain = ColorTokenGeneratedMock.random()
        mock.underlyingOnMain = ColorTokenGeneratedMock.random()

        mock.underlyingMainVariant = ColorTokenGeneratedMock.random()
        mock.underlyingOnMainVariant = ColorTokenGeneratedMock.random()

        mock.underlyingMainContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnMainContainer = ColorTokenGeneratedMock.random()

        return mock
    }
}
