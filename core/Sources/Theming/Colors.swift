//
//  swift
//  Spark
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit
import SwiftUI

public struct SparkColor {
    public let uiColor: UIColor
    public let swiftUIcolor: Color

    public init(uiColor: UIColor,
                swiftUIcolor: Color) {
        self.uiColor = uiColor
        self.swiftUIcolor = swiftUIcolor
    }
}

public struct Outline {
    public let color: SparkColor
    public let width: CGFloat

    public init(color: SparkColor,
                width: CGFloat) {
        self.color = color
        self.width = width
    }
}

public struct Colors {
    public struct Token {
        public let enabled: SparkColor
        public let pressed: SparkColor
        public let disabled: SparkColor
        public let on: SparkColor
        public let outline: Outline

        public init(enabled: SparkColor,
                    pressed: SparkColor,
                    disabled: SparkColor,
                    on: SparkColor,
                    outline: Outline) {
            self.enabled = enabled
            self.pressed = pressed
            self.disabled = disabled
            self.on = on
            self.outline = outline
        }
    }

    public let primary: Token
    public let primaryVariant: Token
    public let secondary: Token
    public let secondaryVariant: Token
    public let background: Token
    public let surface: Token
    public let surfaceInverse: Token
    public let success: Token
    public let alert: Token
    public let error: Token
    public let info: Token
    public let neutral: Token
    public let primaryContainer: Token
    public let secondaryContainer: Token
    public let successContainer: Token
    public let alertContainer: Token
    public let errorContainer: Token
    public let infoContainer: Token
    public let neutralContainer: Token

    public init(primary: Token,
                primaryVariant: Token,
                secondary: Token,
                secondaryVariant: Token,
                background: Token,
                surface: Token,
                surfaceInverse: Token,
                success: Token,
                alert: Token,
                error: Token,
                info: Token,
                neutral: Token,
                primaryContainer: Token,
                secondaryContainer: Token,
                successContainer: Token,
                alertContainer: Token,
                errorContainer: Token,
                infoContainer: Token,
                neutralContainer: Token) {
        self.primary = primary
        self.primaryVariant = primaryVariant
        self.secondary = secondary
        self.secondaryVariant = secondaryVariant
        self.background = background
        self.surface = surface
        self.surfaceInverse = surfaceInverse
        self.success = success
        self.alert = alert
        self.error = error
        self.info = info
        self.neutral = neutral
        self.primaryContainer = primaryContainer
        self.secondaryContainer = secondaryContainer
        self.successContainer = successContainer
        self.alertContainer = alertContainer
        self.errorContainer = errorContainer
        self.infoContainer = infoContainer
        self.neutralContainer = neutralContainer
    }
}
