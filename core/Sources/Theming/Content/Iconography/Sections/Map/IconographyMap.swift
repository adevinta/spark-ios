//
//  IconographyMap.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyMap {
    var threeSixty: IconographyImage { get }
    var bike: IconographyImage { get }
    var allDirections: IconographyImage { get }
    var expand: IconographyImage { get }
    var target: IconographyFilled & IconographyOutlined { get }
    var pin: IconographyFilled & IconographyOutlined { get }
    var cursor: IconographyFilled & IconographyOutlined { get }
    var train: IconographyFilled & IconographyOutlined { get }
    var hotel: IconographyFilled & IconographyOutlined { get }
    var walker: IconographyFilled & IconographyOutlined { get }
    var car: IconographyFilled & IconographyOutlined { get }
}
