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
    var target: IconographyFill & IconographyOutlined { get }
    var pin: IconographyFill & IconographyOutlined { get }
    var cursor: IconographyFill & IconographyOutlined { get }
    var train: IconographyFill & IconographyOutlined { get }
    var hotel: IconographyFill & IconographyOutlined { get }
    var walker: IconographyFill & IconographyOutlined { get }
    var car: IconographyFill & IconographyOutlined { get }
}
