//
//  IconographyPro.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyPro {
    var cursor: IconographyFilled & IconographyOutlined { get }
    var download: IconographyFilled & IconographyOutlined { get }
    var graph: IconographyFilled & IconographyOutlined { get }
    var rocket: IconographyFilled & IconographyOutlined { get }
}
