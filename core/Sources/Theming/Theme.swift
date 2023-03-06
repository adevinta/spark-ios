//
//  Theme.swift
//  Spark
//
//  Created by louis.borlee on 23/02/2023.
//

import Foundation

public protocol Theme {
    var border: Border { get }
    var colors: Colors { get }
    var iconography: Iconography { get }
    var layout: Layout { get }
    var typography: Typography { get }
}
