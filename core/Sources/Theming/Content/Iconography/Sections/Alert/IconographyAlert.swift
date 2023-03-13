//
//  IconographyAlert.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyAlert {
    var alert: IconographyFilled & IconographyOutlined { get }
    var question: IconographyFilled & IconographyOutlined { get }
    var info: IconographyFilled & IconographyOutlined { get }
    var warning: IconographyFilled & IconographyOutlined { get }
    var block: IconographyImage { get }
}
