//
//  RadioButtonColors.swift
//  SparkCore
//
//  Created by michael.zimmermann on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Colors available to the radio button:
/// - Button: this is the outline color of the unselected/selected radio button
/// - Halo: defines the color circumferencing the radio button, when it is pressed.
/// - Fill: defines the fill color of the radio button when it is selected. If the button is not selected, the fill color is `nil`.
/// - Label: The color of the adjoining label
/// - Sublabel: The color of the sub-label. This is only used for specific states of the radio button (`error`, `success` & `warning`)
struct RadioButtonColors {
    let button: any ColorToken
    let label: any ColorToken
    let halo: any ColorToken
    let fill: any ColorToken
    let subLabel: any ColorToken
}
