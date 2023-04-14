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

        mock.underlyingSuccess = ColorTokenGeneratedMock()
        mock.underlyingOnSuccess = ColorTokenGeneratedMock()
        mock.underlyingSuccessContainer = ColorTokenGeneratedMock()
        mock.underlyingOnSuccessContainer = ColorTokenGeneratedMock()

        mock.underlyingAlert = ColorTokenGeneratedMock()
        mock.underlyingOnAlert = ColorTokenGeneratedMock()
        mock.underlyingAlertContainer = ColorTokenGeneratedMock()
        mock.underlyingOnAlertContainer = ColorTokenGeneratedMock()

        mock.underlyingError = ColorTokenGeneratedMock()
        mock.underlyingOnError = ColorTokenGeneratedMock()
        mock.underlyingErrorContainer = ColorTokenGeneratedMock()
        mock.underlyingOnErrorContainer = ColorTokenGeneratedMock()

        mock.underlyingInfo = ColorTokenGeneratedMock()
        mock.underlyingOnInfo = ColorTokenGeneratedMock()
        mock.underlyingInfoContainer = ColorTokenGeneratedMock()
        mock.underlyingOnInfoContainer = ColorTokenGeneratedMock()

        mock.underlyingNeutral = ColorTokenGeneratedMock()
        mock.underlyingOnNeutral = ColorTokenGeneratedMock()
        mock.underlyingNeutralContainer = ColorTokenGeneratedMock()
        mock.underlyingOnNeutralContainer = ColorTokenGeneratedMock()

        return mock
    }
}
