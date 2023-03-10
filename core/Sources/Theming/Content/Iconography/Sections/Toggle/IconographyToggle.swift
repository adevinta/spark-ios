//
//  IconographyToggle.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyToggle {
    var valid: IconographyFill & IconographyOutlined { get }
    var add: IconographyFill & IconographyOutlined { get }
    var remove: IconographyFill & IconographyOutlined { get }
    var check: IconographyImage { get }
    var doubleCheck: IconographyImage { get }
}
