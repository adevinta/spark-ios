//
//  IconographyDelivery.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyDelivery {
    var deliveryFast: IconographyFilled & IconographyOutlined { get }
    var deliveryHands: IconographyFilled & IconographyOutlined { get }
    var box: IconographyFilled & IconographyOutlined { get }
    var deliveryTruck: IconographyFilled & IconographyOutlined { get }
    var mailClose: IconographyFilled & IconographyOutlined { get }
    var mailOpen: IconographyFilled & IconographyOutlined { get }
    var delivery: IconographyFilled & IconographyOutlined { get }
    var mondialRelay: IconographyImage { get }
    var colissimo: IconographyImage { get }
    var shop2Shop: IconographyImage { get }
    var laposte: IconographyImage { get }
}
