//
//  ColorsStates.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public protocol ColorsStates {

    // MARK: - Primary

    var primaryPressed: ColorToken { get }
    var primaryVariantPressed: ColorToken { get }
    var primaryContainerPressed: ColorToken { get }

    // MARK: - Secondary

    var secondaryPressed: ColorToken { get }
    var secondaryVariantPressed: ColorToken { get }
    var secondaryContainerPressed: ColorToken { get }

    // MARK: - Base

    var backgroundPressed: ColorToken { get }
    var surfacePressed: ColorToken { get }
    var surfaceInversePressed: ColorToken { get }
    var outlinePressed: ColorToken { get }

    // MARK: - Feedback

    var successPressed: ColorToken { get }
    var successContainerPressed: ColorToken { get }
    var alertPressed: ColorToken { get }
    var alertContainerPressed: ColorToken { get }
    var errorPressed: ColorToken { get }
    var errorContainerPressed: ColorToken { get }
    var infoPressed: ColorToken { get }
    var infoContainerPressed: ColorToken { get }
    var neutralPressed: ColorToken { get }
    var neutralContainerPressed: ColorToken { get }
}
