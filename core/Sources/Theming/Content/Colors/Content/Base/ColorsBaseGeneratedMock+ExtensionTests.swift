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
        
        mock.underlyingBackground = ColorTokenGeneratedMock()
        mock.underlyingOnBackground = ColorTokenGeneratedMock()
        mock.underlyingBackgroundVariant = ColorTokenGeneratedMock()
        mock.underlyingOnBackgroundVariant = ColorTokenGeneratedMock()

        mock.underlyingSurface = ColorTokenGeneratedMock()
        mock.underlyingOnSurface = ColorTokenGeneratedMock()
        mock.underlyingSurfaceInverse = ColorTokenGeneratedMock()
        mock.underlyingOnSurfaceInverse = ColorTokenGeneratedMock()

        mock.underlyingOutline = ColorTokenGeneratedMock()
        mock.underlyingOutlineHigh = ColorTokenGeneratedMock()

        mock.underlyingOverlay = ColorTokenGeneratedMock()
        mock.underlyingOnOverlay = ColorTokenGeneratedMock()

        return mock
    }
}
