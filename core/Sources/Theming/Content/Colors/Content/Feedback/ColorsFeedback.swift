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

    var success: ColorToken { get }
    var onSuccess: ColorToken { get }
    var successContainer: ColorToken { get }
    var onSuccessContainer: ColorToken { get }

    // MARK: - Alert

    var alert: ColorToken { get }
    var onAlert: ColorToken { get }
    var alertContainer: ColorToken { get }
    var onAlertContainer: ColorToken { get }

    // MARK: - Error

    var error: ColorToken { get }
    var onError: ColorToken { get }
    var errorContainer: ColorToken { get }
    var onErrorContainer: ColorToken { get }

    // MARK: - Info

    var info: ColorToken { get }
    var onInfo: ColorToken { get }
    var infoContainer: ColorToken { get }
    var onInfoContainer: ColorToken { get }

    // MARK: - Neutral

    var neutral: ColorToken { get }
    var onNeutral: ColorToken { get }
    var neutralContainer: ColorToken { get }
    var onNeutralContainer: ColorToken { get }
}
