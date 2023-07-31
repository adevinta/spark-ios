//
//  ColorsSupportGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsSupportGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsSupportGeneratedMock {
        let mock = ColorsSupportGeneratedMock()

        mock.underlyingSupport = ColorTokenGeneratedMock.random()
        mock.underlyingOnSupport = ColorTokenGeneratedMock.random()

        mock.underlyingSupportVariant = ColorTokenGeneratedMock.random()
        mock.underlyingOnSupportVariant = ColorTokenGeneratedMock.random()
        
        mock.underlyingSupportContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnSupportContainer = ColorTokenGeneratedMock.random()

        return mock
    }
}
