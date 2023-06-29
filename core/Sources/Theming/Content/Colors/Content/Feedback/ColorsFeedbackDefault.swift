//
//  ColorsFeedbackDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsFeedbackDefault: ColorsFeedback {

    // MARK: - Properties

    public let success: any ColorToken
    public let onSuccess: any ColorToken
    public let successContainer: any ColorToken
    public let onSuccessContainer: any ColorToken
    public let alert: any ColorToken
    public let onAlert: any ColorToken
    public let alertContainer: any ColorToken
    public let onAlertContainer: any ColorToken
    public let error: any ColorToken
    public let onError: any ColorToken
    public let errorContainer: any ColorToken
    public let onErrorContainer: any ColorToken
    public let info: any ColorToken
    public let onInfo: any ColorToken
    public let infoContainer: any ColorToken
    public let onInfoContainer: any ColorToken
    public let neutral: any ColorToken
    public let onNeutral: any ColorToken
    public let neutralContainer: any ColorToken
    public let onNeutralContainer: any ColorToken

    // MARK: - Init

    public init(success: any ColorToken,
                onSuccess: any ColorToken,
                successContainer: any ColorToken,
                onSuccessContainer: any ColorToken,
                alert: any ColorToken,
                onAlert: any ColorToken,
                alertContainer: any ColorToken,
                onAlertContainer: any ColorToken,
                error: any ColorToken,
                onError: any ColorToken,
                errorContainer: any ColorToken,
                onErrorContainer: any ColorToken,
                info: any ColorToken,
                onInfo: any ColorToken,
                infoContainer: any ColorToken,
                onInfoContainer: any ColorToken,
                neutral: any ColorToken,
                onNeutral: any ColorToken,
                neutralContainer: any ColorToken,
                onNeutralContainer: any ColorToken) {
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
