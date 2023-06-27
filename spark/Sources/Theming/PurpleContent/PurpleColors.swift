//
//  PurpleColors.swift
//  Spark
//
//  Created by alex.vecherov on 05.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import UIKit
import SwiftUI

struct PurpleColors: Colors {

    private class ClassForBundle {}

    var primary: ColorsPrimary = ColorsPrimaryDefault(
        primary: ColorTokenDefault(named: "purple-primary", in: Bundle(for: ClassForBundle.self)),
        onPrimary: ColorTokenDefault(named: "purple-onPrimary", in: Bundle(for: ClassForBundle.self)),
        primaryVariant: ColorTokenDefault(named: "purple-primaryVariant", in: Bundle(for: ClassForBundle.self)),
        onPrimaryVariant: ColorTokenDefault(named: "purple-onPrimaryVariant", in: Bundle(for: ClassForBundle.self)),
        primaryContainer: ColorTokenDefault(named: "purple-primaryContainer", in: Bundle(for: ClassForBundle.self)),
        onPrimaryContainer: ColorTokenDefault(named: "purple-onPrimaryContainer", in: Bundle(for: ClassForBundle.self)))

    let secondary: ColorsSecondary = ColorsSecondaryDefault(
        secondary: ColorTokenDefault(named: "purple-secondary", in: Bundle(for: ClassForBundle.self)),
        onSecondary: ColorTokenDefault(named: "purple-onSecondary", in: Bundle(for: ClassForBundle.self)),
        secondaryVariant: ColorTokenDefault(named: "purple-secondaryVariant", in: Bundle(for: ClassForBundle.self)),
        onSecondaryVariant: ColorTokenDefault(named: "purple-onSecondaryVariant", in: Bundle(for: ClassForBundle.self)),
        secondaryContainer: ColorTokenDefault(named: "purple-secondaryContainer", in: Bundle(for: ClassForBundle.self)),
        onSecondaryContainer: ColorTokenDefault(named: "purple-onSecondaryContainer", in: Bundle(for: ClassForBundle.self)))

    let base: ColorsBase = ColorsBaseDefault(
        background: ColorTokenDefault(named: "purple-background", in: Bundle(for: ClassForBundle.self)),
        onBackground: ColorTokenDefault(named: "purple-onBackground", in: Bundle(for: ClassForBundle.self)),
        backgroundVariant: ColorTokenDefault(named: "purple-backgroundVariant", in: Bundle(for: ClassForBundle.self)),
        onBackgroundVariant: ColorTokenDefault(named: "purple-onBackgroundVariant", in: Bundle(for: ClassForBundle.self)),
        surface: ColorTokenDefault(named: "purple-surface", in: Bundle(for: ClassForBundle.self)),
        onSurface: ColorTokenDefault(named: "purple-onSurface", in: Bundle(for: ClassForBundle.self)),
        surfaceInverse: ColorTokenDefault(named: "purple-surfaceInverse", in: Bundle(for: ClassForBundle.self)),
        onSurfaceInverse: ColorTokenDefault(named: "purple-onSurfaceInverse", in: Bundle(for: ClassForBundle.self)),
        outline: ColorTokenDefault(named: "purple-outline", in: Bundle(for: ClassForBundle.self)),
        outlineHigh: ColorTokenDefault(named: "purple-outlineHigh", in: Bundle(for: ClassForBundle.self)),
        overlay: ColorTokenDefault(named: "purple-overlay", in: Bundle(for: ClassForBundle.self)),
        onOverlay: ColorTokenDefault(named: "purple-onOverlay", in: Bundle(for: ClassForBundle.self)))

    let feedback: ColorsFeedback = ColorsFeedbackDefault(
        success: ColorTokenDefault(named: "purple-success", in: Bundle(for: ClassForBundle.self)),
        onSuccess: ColorTokenDefault(named: "purple-onSuccess", in: Bundle(for: ClassForBundle.self)),
        successContainer: ColorTokenDefault(named: "purple-successContainer", in: Bundle(for: ClassForBundle.self)),
        onSuccessContainer: ColorTokenDefault(named: "purple-onSuccessContainer", in: Bundle(for: ClassForBundle.self)),
        alert: ColorTokenDefault(named: "purple-alert", in: Bundle(for: ClassForBundle.self)),
        onAlert: ColorTokenDefault(named: "purple-onAlert", in: Bundle(for: ClassForBundle.self)),
        alertContainer: ColorTokenDefault(named: "purple-alertContainer", in: Bundle(for: ClassForBundle.self)),
        onAlertContainer: ColorTokenDefault(named: "purple-onAlertContainer", in: Bundle(for: ClassForBundle.self)),
        error: ColorTokenDefault(named: "purple-error", in: Bundle(for: ClassForBundle.self)),
        onError: ColorTokenDefault(named: "purple-onError", in: Bundle(for: ClassForBundle.self)),
        errorContainer: ColorTokenDefault(named: "purple-errorContainer", in: Bundle(for: ClassForBundle.self)),
        onErrorContainer: ColorTokenDefault(named: "purple-onErrorContainer", in: Bundle(for: ClassForBundle.self)),
        info: ColorTokenDefault(named: "purple-info", in: Bundle(for: ClassForBundle.self)),
        onInfo: ColorTokenDefault(named: "purple-onInfo", in: Bundle(for: ClassForBundle.self)),
        infoContainer: ColorTokenDefault(named: "purple-infoContainer", in: Bundle(for: ClassForBundle.self)),
        onInfoContainer: ColorTokenDefault(named: "purple-onInfoContainer", in: Bundle(for: ClassForBundle.self)),
        neutral: ColorTokenDefault(named: "purple-neutral", in: Bundle(for: ClassForBundle.self)),
        onNeutral: ColorTokenDefault(named: "purple-onNeutral", in: Bundle(for: ClassForBundle.self)),
        neutralContainer: ColorTokenDefault(named: "purple-neutralContainer", in: Bundle(for: ClassForBundle.self)),
        onNeutralContainer: ColorTokenDefault(named: "purple-onNeutralContainer", in: Bundle(for: ClassForBundle.self))
    )

    let states: ColorsStates = ColorsStatesDefault(
        primaryPressed: ColorTokenDefault(named: "purple-primaryPressed", in: Bundle(for: ClassForBundle.self)),
        primaryVariantPressed: ColorTokenDefault(named: "purple-primaryVariantPressed", in: Bundle(for: ClassForBundle.self)),
        primaryContainerPressed: ColorTokenDefault(named: "purple-primaryContainerPressed", in: Bundle(for: ClassForBundle.self)),
        secondaryPressed: ColorTokenDefault(named: "purple-secondaryPressed", in: Bundle(for: ClassForBundle.self)),
        secondaryVariantPressed: ColorTokenDefault(named: "purple-secondaryVariantPressed", in: Bundle(for: ClassForBundle.self)),
        secondaryContainerPressed: ColorTokenDefault(named: "purple-secondaryContainerPressed", in: Bundle(for: ClassForBundle.self)),
        surfacePressed: ColorTokenDefault(named: "purple-surfacePressed", in: Bundle(for: ClassForBundle.self)),
        surfaceInversePressed: ColorTokenDefault(named: "purple-surfaceInversePressed", in: Bundle(for: ClassForBundle.self)),
        outlinePressed: ColorTokenDefault(named: "purple-outlinePressed", in: Bundle(for: ClassForBundle.self)),
        successPressed: ColorTokenDefault(named: "purple-successPressed", in: Bundle(for: ClassForBundle.self)),
        successContainerPressed: ColorTokenDefault(named: "purple-successContainerPressed", in: Bundle(for: ClassForBundle.self)),
        alertPressed: ColorTokenDefault(named: "purple-alertPressed", in: Bundle(for: ClassForBundle.self)),
        alertContainerPressed: ColorTokenDefault(named: "purple-alertContainerPressed", in: Bundle(for: ClassForBundle.self)),
        errorPressed: ColorTokenDefault(named: "purple-errorPressed", in: Bundle(for: ClassForBundle.self)),
        errorContainerPressed: ColorTokenDefault(named: "purple-errorContainerPressed", in: Bundle(for: ClassForBundle.self)),
        infoPressed: ColorTokenDefault(named: "purple-infoPressed", in: Bundle(for: ClassForBundle.self)),
        infoContainerPressed: ColorTokenDefault(named: "purple-infoContainerPressed", in: Bundle(for: ClassForBundle.self)),
        neutralPressed: ColorTokenDefault(named: "purple-neutralPressed", in: Bundle(for: ClassForBundle.self)),
        neutralContainerPressed: ColorTokenDefault(named: "purple-neutralContainerPressed", in: Bundle(for: ClassForBundle.self)))
}
