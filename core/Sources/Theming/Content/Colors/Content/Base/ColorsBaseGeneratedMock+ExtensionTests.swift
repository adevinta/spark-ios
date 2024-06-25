//
//  ColorsBaseGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsBaseGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsBaseGeneratedMock {
        let mock = ColorsBaseGeneratedMock()

        mock.underlyingBackground = ColorTokenGeneratedMock.random()
        mock.underlyingOnBackground = ColorTokenGeneratedMock.random()
        mock.underlyingBackgroundVariant = ColorTokenGeneratedMock.random()
        mock.underlyingOnBackgroundVariant = ColorTokenGeneratedMock.random()

        mock.underlyingSurface = ColorTokenGeneratedMock.random()
        mock.underlyingOnSurface = ColorTokenGeneratedMock.random()
        mock.underlyingSurfaceInverse = ColorTokenGeneratedMock.random()
        mock.underlyingOnSurfaceInverse = ColorTokenGeneratedMock.random()

        mock.underlyingOutline = ColorTokenGeneratedMock.random()
        mock.underlyingOutlineHigh = ColorTokenGeneratedMock.random()

        mock.underlyingOverlay = ColorTokenGeneratedMock.random()
        mock.underlyingOnOverlay = ColorTokenGeneratedMock.random()

        return mock
    }
}
