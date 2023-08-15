//
//  SpinnerIntent.swift
//  SparkCore
//
//  Created by michael.zimmermann on 07.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// `SpinnerIntent` determines the color of the spinner according to the theme.
public enum SpinnerIntent: CaseIterable {
    case alert
    case error
    case info
    case neutral
    case main
    case support
    case success
    case accent
    case basic
}
