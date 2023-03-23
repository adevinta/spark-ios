//
//  SparkColors.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import UIKit
import SwiftUI

struct SparkColors: Colors {

    // MARK: - Properties

    let primary: ColorsPrimary = SparkColorPrimary()
    let secondary: ColorsSecondary = SparkColorSecondary()
    let base: ColorsBase = SparkColorBase()
    let feedback: ColorsFeedback = SparkColorFeedback()
    let states: ColorsStates = SparkColorStates()
}

// MARK: - Primary

struct SparkColorPrimary: ColorsPrimary {

    // MARK: - Properties

    let primary: ColorToken = SparkColorToken()
    let onPrimary: ColorToken = SparkColorToken()
    let primaryVariant: ColorToken = SparkColorToken()
    let onPrimaryVariant: ColorToken = SparkColorToken()
    let primaryContainer: ColorToken = SparkColorToken()
    let onPrimaryContainer: ColorToken = SparkColorToken()
}

// MARK: - Secondary

struct SparkColorSecondary: ColorsSecondary {

    // MARK: - Properties

    let secondary: ColorToken = SparkColorToken()
    let onSecondary: ColorToken = SparkColorToken()
    let secondaryVariant: ColorToken = SparkColorToken()
    let onSecondaryVariant: ColorToken = SparkColorToken()
    let secondaryContainer: ColorToken = SparkColorToken()
    let onSecondaryContainer: ColorToken = SparkColorToken()
}

// MARK: - Base

struct SparkColorBase: ColorsBase {

    // MARK: - Properties

    let background: ColorToken = SparkColorToken()
    let onBackground: ColorToken = SparkColorToken()
    let backgroundVariant: ColorToken = SparkColorToken()
    let onBackgroundVariant: ColorToken = SparkColorToken()
    let surface: ColorToken = SparkColorToken()
    let onSurface: ColorToken = SparkColorToken()
    let surfaceInverse: ColorToken = SparkColorToken()
    let onSurfaceInverse: ColorToken = SparkColorToken()
    let outline: ColorToken = SparkColorToken()
    let outlineHigh: ColorToken = SparkColorToken()
    let overlay: ColorToken = SparkColorToken()
    let onOverlay: ColorToken = SparkColorToken()
}

// MARK: - Feedback

struct SparkColorFeedback: ColorsFeedback {

    // MARK: - Properties

    let success: ColorToken = SparkColorToken()
    let onSuccess: ColorToken = SparkColorToken()
    let successContainer: ColorToken = SparkColorToken()
    let onSuccessContainer: ColorToken = SparkColorToken()
    let alert: ColorToken = SparkColorToken()
    let onAlert: ColorToken = SparkColorToken()
    let alertContainer: ColorToken = SparkColorToken()
    let onAlertContainer: ColorToken = SparkColorToken()
    let error: ColorToken = SparkColorToken()
    let onError: ColorToken = SparkColorToken()
    let errorContainer: ColorToken = SparkColorToken()
    let onErrorContainer: ColorToken = SparkColorToken()
    let info: ColorToken = SparkColorToken()
    let onInfo: ColorToken = SparkColorToken()
    let infoContainer: ColorToken = SparkColorToken()
    let onInfoContainer: ColorToken = SparkColorToken()
    let neutral: ColorToken = SparkColorToken()
    let onNeutral: ColorToken = SparkColorToken()
    let neutralContainer: ColorToken = SparkColorToken()
    let onNeutralContainer: ColorToken = SparkColorToken()
}

// MARK: - States

struct SparkColorStates: ColorsStates {

    // MARK: - Properties

    let primaryPressed: ColorToken = SparkColorToken()
    let primaryVariantPressed: ColorToken = SparkColorToken()
    let primaryContainerPressed: ColorToken = SparkColorToken()
    let secondaryPressed: ColorToken = SparkColorToken()
    let secondaryVariantPressed: ColorToken = SparkColorToken()
    let secondaryContainerPressed: ColorToken = SparkColorToken()
    let backgroundPressed: ColorToken = SparkColorToken()
    let surfacePressed: ColorToken = SparkColorToken()
    let surfaceInversePressed: ColorToken = SparkColorToken()
    let outlinePressed: ColorToken = SparkColorToken()
    let successPressed: ColorToken = SparkColorToken()
    let successContainerPressed: ColorToken = SparkColorToken()
    let alertPressed: ColorToken = SparkColorToken()
    let alertContainerPressed: ColorToken = SparkColorToken()
    let errorPressed: ColorToken = SparkColorToken()
    let errorContainerPressed: ColorToken = SparkColorToken()
    let infoPressed: ColorToken = SparkColorToken()
    let infoContainerPressed: ColorToken = SparkColorToken()
    let neutralPressed: ColorToken = SparkColorToken()
    let neutralContainerPressed: ColorToken = SparkColorToken()
}

// MARK: - SparkColorToken

struct SparkColorToken: ColorToken {

    // MARK: - Properties

    let uiColor: UIColor
    let swiftUIColor: Color

    // MARK: - Initialization

    init() {
        let color = UIColor(red: .random(in: 0...1),
                            green: .random(in: 0...1),
                            blue:  .random(in: 0...1),
                            alpha: 1.0)

        self.uiColor = color
        self.swiftUIColor = Color(color)
    }
}
