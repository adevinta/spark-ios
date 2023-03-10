//
//  IconographyOptions.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyOptions {
    var clock: IconographyFill & IconographyOutlined { get }
    var flash: IconographyFill & IconographyOutlined { get }
    var bookmark: IconographyFill & IconographyOutlined { get }
    var star: IconographyFill & IconographyOutlined { get }
    var clockArrow: IconographyUp & IconographyDown { get }
    var moveUp: IconographyImage { get }
}
