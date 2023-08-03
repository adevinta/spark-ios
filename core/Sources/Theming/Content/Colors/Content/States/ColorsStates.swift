//
//  ColorsStates.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsStates {

    // MARK: - Main

    var mainPressed: any ColorToken { get }
    var mainVariantPressed: any ColorToken { get }
    var mainContainerPressed: any ColorToken { get }

    // MARK: - Support

    var supportPressed: any ColorToken { get }
    var supportVariantPressed: any ColorToken { get }
    var supportContainerPressed: any ColorToken { get }

    // MARK: - Accent
    var accentPressed: any ColorToken { get }
    var accentVariantPressed: any ColorToken { get }
    var accentContainerPressed: any ColorToken { get }

    // MARK: - Basic
    var basicPressed: any ColorToken { get }
    var basicContainerPressed: any ColorToken { get }

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
