//
//  ColorsStates.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsStates {

    // MARK: - Primary

    var primaryPressed: any ColorToken { get }
    var primaryVariantPressed: any ColorToken { get }
    var primaryContainerPressed: any ColorToken { get }

    // MARK: - Secondary

    var secondaryPressed: any ColorToken { get }
    var secondaryVariantPressed: any ColorToken { get }
    var secondaryContainerPressed: any ColorToken { get }

    // MARK: - Base

    var surfacePressed: any ColorToken { get }
    var surfaceInversePressed: any ColorToken { get }
    var outlinePressed: any ColorToken { get }

    // MARK: - Feedback

    var successPressed: any ColorToken { get }
    var successContainerPressed: any ColorToken { get }
    var alertPressed: any ColorToken { get }
    var alertContainerPressed: any ColorToken { get }
    var errorPressed: any ColorToken { get }
    var errorContainerPressed: any ColorToken { get }
    var infoPressed: any ColorToken { get }
    var infoContainerPressed: any ColorToken { get }
    var neutralPressed: any ColorToken { get }
    var neutralContainerPressed: any ColorToken { get }
}
