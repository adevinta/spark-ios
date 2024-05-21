//
//  Dims.swift
//  Spark
//
//  Created by louis.borlee on 22/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
public protocol Dims {
    var dim1: CGFloat { get }
    var dim2: CGFloat { get }
    var dim3: CGFloat { get }
    var dim4: CGFloat { get }
    var dim5: CGFloat { get }
}

public extension Dims {
    /// None corresponding to 1.0 value
    var none: CGFloat {
        return 1.0
    }
}
