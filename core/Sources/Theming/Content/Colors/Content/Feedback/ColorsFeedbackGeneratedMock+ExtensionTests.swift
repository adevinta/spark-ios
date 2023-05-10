//
//  ColorsFeedbackGeneratedMock+ExtensionTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 11/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore

extension ColorsFeedbackGeneratedMock {

    // MARK: - Methods

    static func mocked() -> ColorsFeedbackGeneratedMock {
        let mock = ColorsFeedbackGeneratedMock()

        mock.underlyingSuccess = ColorTokenGeneratedMock.random()
        mock.underlyingOnSuccess = ColorTokenGeneratedMock.random()
        mock.underlyingSuccessContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnSuccessContainer = ColorTokenGeneratedMock.random()

        mock.underlyingAlert = ColorTokenGeneratedMock.random()
        mock.underlyingOnAlert = ColorTokenGeneratedMock.random()
        mock.underlyingAlertContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnAlertContainer = ColorTokenGeneratedMock.random()

        mock.underlyingError = ColorTokenGeneratedMock.random()
        mock.underlyingOnError = ColorTokenGeneratedMock.random()
        mock.underlyingErrorContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnErrorContainer = ColorTokenGeneratedMock.random()

        mock.underlyingInfo = ColorTokenGeneratedMock.random()
        mock.underlyingOnInfo = ColorTokenGeneratedMock.random()
        mock.underlyingInfoContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnInfoContainer = ColorTokenGeneratedMock.random()

        mock.underlyingNeutral = ColorTokenGeneratedMock.random()
        mock.underlyingOnNeutral = ColorTokenGeneratedMock.random()
        mock.underlyingNeutralContainer = ColorTokenGeneratedMock.random()
        mock.underlyingOnNeutralContainer = ColorTokenGeneratedMock.random()

        return mock
    }
}
