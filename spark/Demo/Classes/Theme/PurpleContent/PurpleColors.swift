//
//  PurpleColors.swift
//  Spark
//
//  Created by alex.vecherov on 05.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import UIKit
import SwiftUI

struct PurpleColors: Colors {

    private class ClassForBundle {}

    var main: ColorsMain = ColorsMainDefault(
        main: ColorTokenDefault(named: "purple-main", in: Bundle(for: ClassForBundle.self)),
        onMain: ColorTokenDefault(named: "purple-onMain", in: Bundle(for: ClassForBundle.self)),
        mainVariant: ColorTokenDefault(named: "purple-mainVariant", in: Bundle(for: ClassForBundle.self)),
        onMainVariant: ColorTokenDefault(named: "purple-onMainVariant", in: Bundle(for: ClassForBundle.self)),
        mainContainer: ColorTokenDefault(named: "purple-mainContainer", in: Bundle(for: ClassForBundle.self)),
        onMainContainer: ColorTokenDefault(named: "purple-onMainContainer", in: Bundle(for: ClassForBundle.self)))

    let support: ColorsSupport = ColorsSupportDefault(
        support: ColorTokenDefault(named: "purple-support", in: Bundle(for: ClassForBundle.self)),
        onSupport: ColorTokenDefault(named: "purple-onSupport", in: Bundle(for: ClassForBundle.self)),
        supportVariant: ColorTokenDefault(named: "purple-supportVariant", in: Bundle(for: ClassForBundle.self)),
        onSupportVariant: ColorTokenDefault(named: "purple-onSupportVariant", in: Bundle(for: ClassForBundle.self)),
        supportContainer: ColorTokenDefault(named: "purple-supportContainer", in: Bundle(for: ClassForBundle.self)),
        onSupportContainer: ColorTokenDefault(named: "purple-onSupportContainer", in: Bundle(for: ClassForBundle.self)))

    let accent: ColorsAccent = ColorsAccentDefault(
        accent: ColorTokenDefault(named: "purple-accent", in: Bundle(for: ClassForBundle.self)),
        onAccent: ColorTokenDefault(named: "purple-on-accent", in: Bundle(for: ClassForBundle.self)),
        accentVariant: ColorTokenDefault(named: "purple-accent-variant", in: Bundle(for: ClassForBundle.self)),
        onAccentVariant: ColorTokenDefault(named: "purple-on-accent-variant", in: Bundle(for: ClassForBundle.self)),
        accentContainer: ColorTokenDefault(named: "purple-accent-container", in: Bundle(for: ClassForBundle.self)),
        onAccentContainer: ColorTokenDefault(named: "purple-on-accent-container", in: Bundle(for: ClassForBundle.self)))

    let basic: ColorsBasic = ColorsBasicDefault(
        basic: ColorTokenDefault(named: "purple-basic", in: Bundle(for: ClassForBundle.self)),
        onBasic: ColorTokenDefault(named: "purple-on-basic", in: Bundle(for: ClassForBundle.self)),
        basicContainer: ColorTokenDefault(named: "purple-basic-container", in: Bundle(for: ClassForBundle.self)),
        onBasicContainer: ColorTokenDefault(named: "purple-on-basic-container", in: Bundle(for: ClassForBundle.self)))

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
        mainPressed: ColorTokenDefault(named: "purple-mainPressed", in: Bundle(for: ClassForBundle.self)),
        mainVariantPressed: ColorTokenDefault(named: "purple-mainVariantPressed", in: Bundle(for: ClassForBundle.self)),
        mainContainerPressed: ColorTokenDefault(named: "purple-mainContainerPressed", in: Bundle(for: ClassForBundle.self)),
        supportPressed: ColorTokenDefault(named: "purple-supportPressed", in: Bundle(for: ClassForBundle.self)),
        supportVariantPressed: ColorTokenDefault(named: "purple-supportVariantPressed", in: Bundle(for: ClassForBundle.self)),
        supportContainerPressed: ColorTokenDefault(named: "purple-supportContainerPressed", in: Bundle(for: ClassForBundle.self)),
        accentPressed: ColorTokenDefault(named: "purple-accent-pressed", in: Bundle(for: ClassForBundle.self)),
        accentVariantPressed: ColorTokenDefault(named: "purple-accent-variant-pressed", in: Bundle(for: ClassForBundle.self)),
        accentContainerPressed: ColorTokenDefault(named: "purple-accent-container-pressed", in: Bundle(for: ClassForBundle.self)),
        basicPressed: ColorTokenDefault(named: "purple-basic-pressed", in: Bundle(for: ClassForBundle.self)),
        basicContainerPressed: ColorTokenDefault(named: "purple-basic-container-pressed", in: Bundle(for: ClassForBundle.self)),
        surfacePressed: ColorTokenDefault(named: "purple-surfacePressed", in: Bundle(for: ClassForBundle.self)),
        surfaceInversePressed: ColorTokenDefault(named: "purple-surfaceInversePressed", in: Bundle(for: ClassForBundle.self)),
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
