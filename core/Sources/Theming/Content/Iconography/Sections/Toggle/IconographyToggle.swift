//
//  IconographyToggle.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyToggle {
    var valid: IconographyFilled & IconographyOutlined { get }
    var add: IconographyFilled & IconographyOutlined { get }
    var remove: IconographyFilled & IconographyOutlined { get }
    var check: IconographyImage { get }
    var doubleCheck: IconographyImage { get }
}
