//
//  IconographyOthers.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyOthers {
    var megaphone: IconographyFilled & IconographyOutlined { get }
    var speedmeter: IconographyFilled & IconographyOutlined { get }
    var dissatisfied: IconographyFilled & IconographyOutlined { get }
    var flag: IconographyFilled & IconographyOutlined { get }
    var satisfied: IconographyFilled & IconographyOutlined { get }
    var neutral: IconographyFilled & IconographyOutlined { get }
    var sad: IconographyFilled & IconographyOutlined { get }
    var fire: IconographyFilled & IconographyOutlined { get }
    var euro: IconographyImage { get }
    var refund: IconographyImage { get }
    var sun: IconographyImage { get }
}
