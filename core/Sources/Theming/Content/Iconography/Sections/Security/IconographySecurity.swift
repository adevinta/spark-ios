//
//  IconographySecurity.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographySecurity {
    var idea: IconographyFilled & IconographyOutlined { get }
    var lock: IconographyFilled & IconographyOutlined { get }
    var unlock: IconographyFilled & IconographyOutlined { get }
}
