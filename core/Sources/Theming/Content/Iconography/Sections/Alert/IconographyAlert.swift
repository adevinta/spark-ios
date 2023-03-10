//
//  IconographyAlert.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyAlert {
    var alert: IconographyFill & IconographyOutlined { get }
    var question: IconographyFill & IconographyOutlined { get }
    var info: IconographyFill & IconographyOutlined { get }
    var warning: IconographyFill & IconographyOutlined { get }
    var block: IconographyImage { get }
}
