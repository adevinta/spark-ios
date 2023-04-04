//
//  Theme.swift
//  Spark
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol Theme {
    var border: Border { get }
    var colors: Colors { get }
    var elevation: Elevation { get }
    var layout: Layout { get }
    var typography: Typography { get }
    var dims: Dims { get }
}
