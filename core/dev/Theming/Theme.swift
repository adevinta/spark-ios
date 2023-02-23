//
//  Theme.swift
//  Spark
//
//  Created by louis.borlee on 23/02/2023.
//

import Foundation

public protocol Theme {
    var colors: Colors { get }
    var typography: Typography { get }
    var iconography: Iconography { get }
    var layout: Layout { get }
}
