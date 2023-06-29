//
//  ColorsSecondary.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsSecondary {
    var secondary: any ColorToken { get }
    var onSecondary: any ColorToken { get }
    var secondaryVariant: any ColorToken { get }
    var onSecondaryVariant: any ColorToken { get }
    var secondaryContainer: any ColorToken { get }
    var onSecondaryContainer: any ColorToken { get }
}
