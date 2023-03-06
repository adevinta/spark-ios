//
//  ColorsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

public struct ColorsDefault: Colors {

    // MARK: - Properties

    public let primary: ColorToken
    public let primaryVariant: ColorToken

    public let secondary: ColorToken
    public let secondaryVariant: ColorToken

    public let background: ColorToken

    public let surface: ColorToken
    public let surfaceInverse: ColorToken

    public let success: ColorToken
    public let alert: ColorToken
    public let error: ColorToken
    public let info: ColorToken
    public let neutral: ColorToken

    public let primaryContainer: ColorToken
    public let secondaryContainer: ColorToken
    public let successContainer: ColorToken
    public let alertContainer: ColorToken
    public let errorContainer: ColorToken
    public let infoContainer: ColorToken
    public let neutralContainer: ColorToken

    // MARK: - Initialization

    public init(primary: ColorToken,
                primaryVariant: ColorToken,
                secondary: ColorToken,
                secondaryVariant: ColorToken,
                background: ColorToken,
                surface: ColorToken,
                surfaceInverse: ColorToken,
                success: ColorToken,
                alert: ColorToken,
                error: ColorToken,
                info: ColorToken,
                neutral: ColorToken,
                primaryContainer: ColorToken,
                secondaryContainer: ColorToken,
                successContainer: ColorToken,
                alertContainer: ColorToken,
                errorContainer: ColorToken,
                infoContainer: ColorToken,
                neutralContainer: ColorToken) {
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
