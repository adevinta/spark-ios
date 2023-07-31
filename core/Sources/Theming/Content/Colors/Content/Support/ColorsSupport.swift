//
//  ColorsSupport.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsSupport {
    var support: any ColorToken { get }
    var onSupport: any ColorToken { get }
    var supportVariant: any ColorToken { get }
    var onSupportVariant: any ColorToken { get }
    var supportContainer: any ColorToken { get }
    var onSupportContainer: any ColorToken { get }
}
