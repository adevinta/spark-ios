//
//  IconographyArrows.swift
//  SparkCore
//
//  Created by robin.lemaire on 10/03/2023.
//

public protocol IconographyArrows {
    var arrow: IconographyLeft & IconographyRight { get }
    var arrowDouble: IconographyLeft & IconographyRight { get }
    var arrowVertical: IconographyLeft & IconographyRight { get }
    var arrowHorizontal: IconographyUp & IconographyDown { get }
    var delete: IconographyFill & IconographyOutlined { get }
    var graphArrow: IconographyUp & IconographyDown { get }
    var close: IconographyImage { get }
    var plus: IconographyImage { get }
}
