//
//  ColorsPrimary.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsPrimary {
    var primary: any ColorToken { get }
    var onPrimary: any ColorToken { get }
    var primaryVariant: any ColorToken { get }
    var onPrimaryVariant: any ColorToken { get }
    var primaryContainer: any ColorToken { get }
    var onPrimaryContainer: any ColorToken { get }
}
