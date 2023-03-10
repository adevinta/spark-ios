//
//  IconographySecurity.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographySecurity {
    var idea: IconographyFill & IconographyOutlined { get }
    var lock: IconographyFill & IconographyOutlined { get }
    var unlock: IconographyFill & IconographyOutlined { get }
}
