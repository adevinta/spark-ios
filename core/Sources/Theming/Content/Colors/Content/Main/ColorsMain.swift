//
//  ColorsMain.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsMain {
    var main: any ColorToken { get }
    var onMain: any ColorToken { get }
    var mainVariant: any ColorToken { get }
    var onMainVariant: any ColorToken { get }
    var mainContainer: any ColorToken { get }
    var onMainContainer: any ColorToken { get }
}
