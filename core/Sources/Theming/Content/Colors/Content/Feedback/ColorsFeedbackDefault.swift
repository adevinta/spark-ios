//
//  ColorsFeedbackDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsFeedbackDefault: ColorsFeedback {

    // MARK: - Properties

    public let success: ColorToken
    public let onSuccess: ColorToken
    public let successContainer: ColorToken
    public let onSuccessContainer: ColorToken
    public let alert: ColorToken
    public let onAlert: ColorToken
    public let alertContainer: ColorToken
    public let onAlertContainer: ColorToken
    public let error: ColorToken
    public let onError: ColorToken
    public let errorContainer: ColorToken
    public let onErrorContainer: ColorToken
    public let info: ColorToken
    public let onInfo: ColorToken
    public let infoContainer: ColorToken
    public let onInfoContainer: ColorToken
    public let neutral: ColorToken
    public let onNeutral: ColorToken
    public let neutralContainer: ColorToken
    public let onNeutralContainer: ColorToken

    // MARK: - Init

    public init(success: ColorToken,
                onSuccess: ColorToken,
                successContainer: ColorToken,
                onSuccessContainer: ColorToken,
                alert: ColorToken,
                onAlert: ColorToken,
                alertContainer: ColorToken,
                onAlertContainer: ColorToken,
                error: ColorToken,
                onError: ColorToken,
                errorContainer: ColorToken,
                onErrorContainer: ColorToken,
                info: ColorToken,
                onInfo: ColorToken,
                infoContainer: ColorToken,
                onInfoContainer: ColorToken,
                neutral: ColorToken,
                onNeutral: ColorToken,
                neutralContainer: ColorToken,
                onNeutralContainer: ColorToken) {
        self.success = success
        self.onSuccess = onSuccess
        self.successContainer = successContainer
        self.onSuccessContainer = onSuccessContainer
        self.alert = alert
        self.onAlert = onAlert
        self.alertContainer = alertContainer
        self.onAlertContainer = onAlertContainer
        self.error = error
        self.onError = onError
        self.errorContainer = errorContainer
        self.onErrorContainer = onErrorContainer
        self.info = info
        self.onInfo = onInfo
        self.infoContainer = infoContainer
        self.onInfoContainer = onInfoContainer
        self.neutral = neutral
        self.onNeutral = onNeutral
        self.neutralContainer = neutralContainer
        self.onNeutralContainer = onNeutralContainer
    }
}
