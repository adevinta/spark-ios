//
//  ColorsStatesGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsStatesGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsStatesGeneratedMock {
        let mock = ColorsStatesGeneratedMock()

        mock.underlyingPrimaryPressed = ColorTokenGeneratedMock()
        mock.underlyingPrimaryVariantPressed = ColorTokenGeneratedMock()
        mock.underlyingPrimaryContainerPressed = ColorTokenGeneratedMock()

        mock.underlyingSecondaryPressed = ColorTokenGeneratedMock()
        mock.underlyingSecondaryVariantPressed = ColorTokenGeneratedMock()
        mock.underlyingSecondaryContainerPressed = ColorTokenGeneratedMock()

        mock.underlyingSurfacePressed = ColorTokenGeneratedMock()
        mock.underlyingSurfaceInversePressed = ColorTokenGeneratedMock()
        mock.underlyingOutlinePressed = ColorTokenGeneratedMock()

        mock.underlyingSuccessPressed = ColorTokenGeneratedMock()
        mock.underlyingSuccessContainerPressed = ColorTokenGeneratedMock()
        mock.underlyingAlertPressed = ColorTokenGeneratedMock()
        mock.underlyingAlertContainerPressed = ColorTokenGeneratedMock()
        mock.underlyingErrorPressed = ColorTokenGeneratedMock()
        mock.underlyingErrorContainerPressed = ColorTokenGeneratedMock()
        mock.underlyingInfoPressed = ColorTokenGeneratedMock()
        mock.underlyingInfoContainerPressed = ColorTokenGeneratedMock()
        mock.underlyingNeutralPressed = ColorTokenGeneratedMock()
        mock.underlyingNeutralContainerPressed = ColorTokenGeneratedMock()

        return mock
    }
}
