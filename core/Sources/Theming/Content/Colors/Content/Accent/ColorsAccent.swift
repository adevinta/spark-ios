//
//  ColorsAccent.swift
//  Spark
//
//  Created by louis.borlee on 01/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsAccent {
    var accent: any ColorToken { get }
    var onAccent: any ColorToken { get }
    var accentVariant: any ColorToken { get }
    var onAccentVariant: any ColorToken { get }
    var accentContainer: any ColorToken { get }
    var onAccentContainer: any ColorToken { get }
}
