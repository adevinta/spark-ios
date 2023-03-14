//
//  IconographyDeliveryDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyDeliveryDefault: IconographyDelivery {

    // MARK: - Properties

    public let deliveryFast: IconographyFilled & IconographyOutlined
    public let deliveryHands: IconographyFilled & IconographyOutlined
    public let box: IconographyFilled & IconographyOutlined
    public let deliveryTruck: IconographyFilled & IconographyOutlined
    public let mailClose: IconographyFilled & IconographyOutlined
    public let mailOpen: IconographyFilled & IconographyOutlined
    public let delivery: IconographyFilled & IconographyOutlined
    public let mondialRelay: IconographyImage
    public let colissimo: IconographyImage
    public let shop2Shop: IconographyImage
    public let laposte: IconographyImage

    // MARK: - Init

    public init(deliveryFast: IconographyFilled & IconographyOutlined,
                deliveryHands: IconographyFilled & IconographyOutlined,
                box: IconographyFilled & IconographyOutlined,
                deliveryTruck: IconographyFilled & IconographyOutlined,
                mailClose: IconographyFilled & IconographyOutlined,
                mailOpen: IconographyFilled & IconographyOutlined,
                delivery: IconographyFilled & IconographyOutlined,
                mondialRelay: IconographyImage,
                colissimo: IconographyImage,
                shop2Shop: IconographyImage,
                laposte: IconographyImage) {
        self.deliveryFast = deliveryFast
        self.deliveryHands = deliveryHands
        self.box = box
        self.deliveryTruck = deliveryTruck
        self.mailClose = mailClose
        self.mailOpen = mailOpen
        self.delivery = delivery
        self.mondialRelay = mondialRelay
        self.colissimo = colissimo
        self.shop2Shop = shop2Shop
        self.laposte = laposte
    }
}
