//
//  IconographyPro.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyPro {
    var cursor: IconographyFill & IconographyOutlined { get }
    var download: IconographyFill & IconographyOutlined { get }
    var graph: IconographyFill & IconographyOutlined { get }
    var rocket: IconographyFill & IconographyOutlined { get }
}
