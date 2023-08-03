//
//  ColorsBasic.swift
//  Spark
//
//  Created by louis.borlee on 01/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsBasic {
    var basic: any ColorToken { get }
    var onBasic: any ColorToken { get }
    var basicContainer: any ColorToken { get }
    var onBasicContainer: any ColorToken { get }
}
