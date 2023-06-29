//
//  ColorsFeedback.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsFeedback {

    // MARK: - Success

    var success: any ColorToken { get }
    var onSuccess: any ColorToken { get }
    var successContainer: any ColorToken { get }
    var onSuccessContainer: any ColorToken { get }

    // MARK: - Alert

    var alert: any ColorToken { get }
    var onAlert: any ColorToken { get }
    var alertContainer: any ColorToken { get }
    var onAlertContainer: any ColorToken { get }

    // MARK: - Error

    var error: any ColorToken { get }
    var onError: any ColorToken { get }
    var errorContainer: any ColorToken { get }
    var onErrorContainer: any ColorToken { get }

    // MARK: - Info

    var info: any ColorToken { get }
    var onInfo: any ColorToken { get }
    var infoContainer: any ColorToken { get }
    var onInfoContainer: any ColorToken { get }

    // MARK: - Neutral

    var neutral: any ColorToken { get }
    var onNeutral: any ColorToken { get }
    var neutralContainer: any ColorToken { get }
    var onNeutralContainer: any ColorToken { get }
}
