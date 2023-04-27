//
//  ColorsStatesDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsStatesDefault: ColorsStates {

    // MARK: - Properties

    public let primaryPressed: ColorToken
    public let primaryVariantPressed: ColorToken
    public let primaryContainerPressed: ColorToken
    public let secondaryPressed: ColorToken
    public let secondaryVariantPressed: ColorToken
    public let secondaryContainerPressed: ColorToken
    public let surfacePressed: ColorToken
    public let surfaceInversePressed: ColorToken
    public let outlinePressed: ColorToken
    public let successPressed: ColorToken
    public let successContainerPressed: ColorToken
    public let alertPressed: ColorToken
    public let alertContainerPressed: ColorToken
    public let errorPressed: ColorToken
    public let errorContainerPressed: ColorToken
    public let infoPressed: ColorToken
    public let infoContainerPressed: ColorToken
    public let neutralPressed: ColorToken
    public let neutralContainerPressed: ColorToken

    // MARK: - Init

    public init(primaryPressed: ColorToken,
                primaryVariantPressed: ColorToken,
                primaryContainerPressed: ColorToken,
                secondaryPressed: ColorToken,
                secondaryVariantPressed: ColorToken,
                secondaryContainerPressed: ColorToken,
                surfacePressed: ColorToken,
                surfaceInversePressed: ColorToken,
                outlinePressed: ColorToken,
                successPressed: ColorToken,
                successContainerPressed: ColorToken,
                alertPressed: ColorToken,
                alertContainerPressed: ColorToken,
                errorPressed: ColorToken,
                errorContainerPressed: ColorToken,
                infoPressed: ColorToken,
                infoContainerPressed: ColorToken,
                neutralPressed: ColorToken,
                neutralContainerPressed: ColorToken) {
        self.primaryPressed = primaryPressed
        self.primaryVariantPressed = primaryVariantPressed
        self.primaryContainerPressed = primaryContainerPressed
        self.secondaryPressed = secondaryPressed
        self.secondaryVariantPressed = secondaryVariantPressed
        self.secondaryContainerPressed = secondaryContainerPressed
        self.surfacePressed = surfacePressed
        self.surfaceInversePressed = surfaceInversePressed
        self.outlinePressed = outlinePressed
        self.successPressed = successPressed
        self.successContainerPressed = successContainerPressed
        self.alertPressed = alertPressed
        self.alertContainerPressed = alertContainerPressed
        self.errorPressed = errorPressed
        self.errorContainerPressed = errorContainerPressed
        self.infoPressed = infoPressed
        self.infoContainerPressed = infoContainerPressed
        self.neutralPressed = neutralPressed
        self.neutralContainerPressed = neutralContainerPressed
    }
}
