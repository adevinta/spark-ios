//
//  IconographyDelivery.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyDelivery {
    var deliveryFast: IconographyFill & IconographyOutlined { get }
    var deliveryHands: IconographyFill & IconographyOutlined { get }
    var box: IconographyFill & IconographyOutlined { get }
    var deliveryTruck: IconographyFill & IconographyOutlined { get }
    var mailClose: IconographyFill & IconographyOutlined { get }
    var mailOpen: IconographyFill & IconographyOutlined { get }
    var delivery: IconographyFill & IconographyOutlined { get }
    var mondialRelay: IconographyImage { get }
    var colissimo: IconographyImage { get }
    var shop2Shop: IconographyImage { get }
    var laposte: IconographyImage { get }
}
