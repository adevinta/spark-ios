//
//  IconographyOthers.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyOthers {
    var megaphone: IconographyFill & IconographyOutlined { get }
    var speedmeter: IconographyFill & IconographyOutlined { get }
    var dissatisfied: IconographyFill & IconographyOutlined { get }
    var flag: IconographyFill & IconographyOutlined { get }
    var satisfied: IconographyFill & IconographyOutlined { get }
    var neutral: IconographyFill & IconographyOutlined { get }
    var sad: IconographyFill & IconographyOutlined { get }
    var fire: IconographyFill & IconographyOutlined { get }
    var euro: IconographyImage { get }
    var refund: IconographyImage { get }
    var sun: IconographyImage { get }
}
