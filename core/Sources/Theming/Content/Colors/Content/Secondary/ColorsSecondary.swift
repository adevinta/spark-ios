//
//  ColorsSecondary.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsSecondary {
    var secondary: ColorToken { get }
    var onSecondary: ColorToken { get }
    var secondaryVariant: ColorToken { get }
    var onSecondaryVariant: ColorToken { get }
    var secondaryContainer: ColorToken { get }
    var onSecondaryContainer: ColorToken { get }
}
