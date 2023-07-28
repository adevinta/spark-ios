//
//  ButtonIntent.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 02.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// A button intent is used to apply a color scheme to a button.
@frozen
public enum ButtonIntent: CaseIterable {
    case alert
    case danger
    case main
    case neutral
    case success
    case support
    case surface
}
