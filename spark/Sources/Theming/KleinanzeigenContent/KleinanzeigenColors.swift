//
//  KleinanzeigenColors.swift
//  Spark
//
//  Created by alex.vecherov on 05.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import UIKit
import SwiftUI

struct KleinanzeigenColors: Colors {

    private class ClassForBundle {}

    var primary: ColorsPrimary = ColorsPrimaryDefault(
        primary: ColorTokenDefault(named: "ka-primary", in: Bundle(for: ClassForBundle.self)),
        onPrimary: ColorTokenDefault(named: "ka-onPrimary", in: Bundle(for: ClassForBundle.self)),
        primaryVariant: ColorTokenDefault(named: "ka-primaryVariant", in: Bundle(for: ClassForBundle.self)),
        onPrimaryVariant: ColorTokenDefault(named: "ka-onPrimaryVariant", in: Bundle(for: ClassForBundle.self)),
        primaryContainer: ColorTokenDefault(named: "ka-primaryContainer", in: Bundle(for: ClassForBundle.self)),
        onPrimaryContainer: ColorTokenDefault(named: "ka-onPrimaryContainer", in: Bundle(for: ClassForBundle.self)))

    let secondary: ColorsSecondary = ColorsSecondaryDefault(
        secondary: ColorTokenDefault(named: "ka-secondary", in: Bundle(for: ClassForBundle.self)),
        onSecondary: ColorTokenDefault(named: "ka-onSecondary", in: Bundle(for: ClassForBundle.self)),
        secondaryVariant: ColorTokenDefault(named: "ka-secondaryVariant", in: Bundle(for: ClassForBundle.self)),
        onSecondaryVariant: ColorTokenDefault(named: "ka-onSecondaryVariant", in: Bundle(for: ClassForBundle.self)),
        secondaryContainer: ColorTokenDefault(named: "ka-secondaryContainer", in: Bundle(for: ClassForBundle.self)),
        onSecondaryContainer: ColorTokenDefault(named: "ka-onSecondaryContainer", in: Bundle(for: ClassForBundle.self)))

    let base: ColorsBase = ColorsBaseDefault(
        background: ColorTokenDefault(named: "ka-background", in: Bundle(for: ClassForBundle.self)),
        onBackground: ColorTokenDefault(named: "ka-onBackground", in: Bundle(for: ClassForBundle.self)),
        backgroundVariant: ColorTokenDefault(named: "ka-backgroundVariant", in: Bundle(for: ClassForBundle.self)),
        onBackgroundVariant: ColorTokenDefault(named: "ka-onBackgroundVariant", in: Bundle(for: ClassForBundle.self)),
        surface: ColorTokenDefault(named: "ka-surface", in: Bundle(for: ClassForBundle.self)),
        onSurface: ColorTokenDefault(named: "ka-onSurface", in: Bundle(for: ClassForBundle.self)),
        surfaceInverse: ColorTokenDefault(named: "ka-surfaceInverse", in: Bundle(for: ClassForBundle.self)),
        onSurfaceInverse: ColorTokenDefault(named: "ka-onSurfaceInverse", in: Bundle(for: ClassForBundle.self)),
        outline: ColorTokenDefault(named: "ka-outline", in: Bundle(for: ClassForBundle.self)),
        outlineHigh: ColorTokenDefault(named: "ka-outlineHigh", in: Bundle(for: ClassForBundle.self)),
        overlay: ColorTokenDefault(named: "ka-overlay", in: Bundle(for: ClassForBundle.self)),
        onOverlay: ColorTokenDefault(named: "ka-onOverlay", in: Bundle(for: ClassForBundle.self)))

    let feedback: ColorsFeedback = ColorsFeedbackDefault(
        success: ColorTokenDefault(named: "ka-success", in: Bundle(for: ClassForBundle.self)),
        onSuccess: ColorTokenDefault(named: "ka-onSuccess", in: Bundle(for: ClassForBundle.self)),
        successContainer: ColorTokenDefault(named: "ka-successContainer", in: Bundle(for: ClassForBundle.self)),
        onSuccessContainer: ColorTokenDefault(named: "ka-onSuccessContainer", in: Bundle(for: ClassForBundle.self)),
        alert: ColorTokenDefault(named: "ka-alert", in: Bundle(for: ClassForBundle.self)),
        onAlert: ColorTokenDefault(named: "ka-onAlert", in: Bundle(for: ClassForBundle.self)),
        alertContainer: ColorTokenDefault(named: "ka-alertContainer", in: Bundle(for: ClassForBundle.self)),
        onAlertContainer: ColorTokenDefault(named: "ka-onAlertContainer", in: Bundle(for: ClassForBundle.self)),
        error: ColorTokenDefault(named: "ka-error", in: Bundle(for: ClassForBundle.self)),
        onError: ColorTokenDefault(named: "ka-onError", in: Bundle(for: ClassForBundle.self)),
        errorContainer: ColorTokenDefault(named: "ka-errorContainer", in: Bundle(for: ClassForBundle.self)),
        onErrorContainer: ColorTokenDefault(named: "ka-onErrorContainer", in: Bundle(for: ClassForBundle.self)),
        info: ColorTokenDefault(named: "ka-info", in: Bundle(for: ClassForBundle.self)),
        onInfo: ColorTokenDefault(named: "ka-onInfo", in: Bundle(for: ClassForBundle.self)),
        infoContainer: ColorTokenDefault(named: "ka-infoContainer", in: Bundle(for: ClassForBundle.self)),
        onInfoContainer: ColorTokenDefault(named: "ka-onInfoContainer", in: Bundle(for: ClassForBundle.self)),
        neutral: ColorTokenDefault(named: "ka-neutral", in: Bundle(for: ClassForBundle.self)),
        onNeutral: ColorTokenDefault(named: "ka-onNeutral", in: Bundle(for: ClassForBundle.self)),
        neutralContainer: ColorTokenDefault(named: "ka-neutralContainer", in: Bundle(for: ClassForBundle.self)),
        onNeutralContainer: ColorTokenDefault(named: "ka-onNeutralContainer", in: Bundle(for: ClassForBundle.self))
    )

    let states: ColorsStates = ColorsStatesDefault(
        primaryPressed: ColorTokenDefault(named: "ka-primaryPressed", in: Bundle(for: ClassForBundle.self)),
        primaryVariantPressed: ColorTokenDefault(named: "ka-primaryVariantPressed", in: Bundle(for: ClassForBundle.self)),
        primaryContainerPressed: ColorTokenDefault(named: "ka-primaryContainerPressed", in: Bundle(for: ClassForBundle.self)),
        secondaryPressed: ColorTokenDefault(named: "ka-secondaryPressed", in: Bundle(for: ClassForBundle.self)),
        secondaryVariantPressed: ColorTokenDefault(named: "ka-secondaryVariantPressed", in: Bundle(for: ClassForBundle.self)),
        secondaryContainerPressed: ColorTokenDefault(named: "ka-secondaryContainerPressed", in: Bundle(for: ClassForBundle.self)),
        surfacePressed: ColorTokenDefault(named: "ka-surfacePressed", in: Bundle(for: ClassForBundle.self)),
        surfaceInversePressed: ColorTokenDefault(named: "ka-surfaceInversePressed", in: Bundle(for: ClassForBundle.self)),
        outlinePressed: ColorTokenDefault(named: "ka-outlinePressed", in: Bundle(for: ClassForBundle.self)),
        successPressed: ColorTokenDefault(named: "ka-successPressed", in: Bundle(for: ClassForBundle.self)),
        successContainerPressed: ColorTokenDefault(named: "ka-successContainerPressed", in: Bundle(for: ClassForBundle.self)),
        alertPressed: ColorTokenDefault(named: "ka-alertPressed", in: Bundle(for: ClassForBundle.self)),
        alertContainerPressed: ColorTokenDefault(named: "ka-alertContainerPressed", in: Bundle(for: ClassForBundle.self)),
        errorPressed: ColorTokenDefault(named: "ka-errorPressed", in: Bundle(for: ClassForBundle.self)),
        errorContainerPressed: ColorTokenDefault(named: "ka-errorContainerPressed", in: Bundle(for: ClassForBundle.self)),
        infoPressed: ColorTokenDefault(named: "ka-infoPressed", in: Bundle(for: ClassForBundle.self)),
        infoContainerPressed: ColorTokenDefault(named: "ka-infoContainerPressed", in: Bundle(for: ClassForBundle.self)),
        neutralPressed: ColorTokenDefault(named: "ka-neutralPressed", in: Bundle(for: ClassForBundle.self)),
        neutralContainerPressed: ColorTokenDefault(named: "ka-neutralContainerPressed", in: Bundle(for: ClassForBundle.self)))
}
