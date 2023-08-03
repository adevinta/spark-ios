//
//  ColorsBasicGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsBasicGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsBasicGeneratedMock {
        let mock = ColorsBasicGeneratedMock()

        mock.underlyingBasic = ColorTokenGeneratedMock.random()
        mock.underlyingOnBasic = ColorTokenGeneratedMock.random()

        mock.underlyingBasicContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnBasicContainer = ColorTokenGeneratedMock.random()

        return mock
    }
}
