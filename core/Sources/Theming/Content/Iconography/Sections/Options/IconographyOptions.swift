//
//  IconographyOptions.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyOptions {
    var clock: IconographyFilled & IconographyOutlined { get }
    var flash: IconographyFilled & IconographyOutlined { get }
    var bookmark: IconographyFilled & IconographyOutlined { get }
    var star: IconographyFilled & IconographyOutlined { get }
    var clockArrow: IconographyUp & IconographyDown { get }
    var moveUp: IconographyImage { get }
}
