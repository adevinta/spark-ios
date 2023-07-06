//
//  ColorsStatesDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsStatesDefault: ColorsStates {

    // MARK: - Properties

    public let primaryPressed: any ColorToken
    public let primaryVariantPressed: any ColorToken
    public let primaryContainerPressed: any ColorToken
    public let secondaryPressed: any ColorToken
    public let secondaryVariantPressed: any ColorToken
    public let secondaryContainerPressed: any ColorToken
    public let surfacePressed: any ColorToken
    public let surfaceInversePressed: any ColorToken
    public let outlinePressed: any ColorToken
    public let successPressed: any ColorToken
    public let successContainerPressed: any ColorToken
    public let alertPressed: any ColorToken
    public let alertContainerPressed: any ColorToken
    public let errorPressed: any ColorToken
    public let errorContainerPressed: any ColorToken
    public let infoPressed: any ColorToken
    public let infoContainerPressed: any ColorToken
    public let neutralPressed: any ColorToken
    public let neutralContainerPressed: any ColorToken

    // MARK: - Init

    public init(primaryPressed: any ColorToken,
                primaryVariantPressed: any ColorToken,
                primaryContainerPressed: any ColorToken,
                secondaryPressed: any ColorToken,
                secondaryVariantPressed: any ColorToken,
                secondaryContainerPressed: any ColorToken,
                surfacePressed: any ColorToken,
                surfaceInversePressed: any ColorToken,
                outlinePressed: any ColorToken,
                successPressed: any ColorToken,
                successContainerPressed: any ColorToken,
                alertPressed: any ColorToken,
                alertContainerPressed: any ColorToken,
                errorPressed: any ColorToken,
                errorContainerPressed: any ColorToken,
                infoPressed: any ColorToken,
                infoContainerPressed: any ColorToken,
                neutralPressed: any ColorToken,
                neutralContainerPressed: any ColorToken) {
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
