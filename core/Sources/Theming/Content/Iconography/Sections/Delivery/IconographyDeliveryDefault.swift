//
//  IconographyDeliveryDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyDeliveryDefault: IconographyDelivery {

    // MARK: - Properties

    public let deliveryFast: IconographyFill & IconographyOutlined
    public let deliveryHands: IconographyFill & IconographyOutlined
    public let box: IconographyFill & IconographyOutlined
    public let deliveryTruck: IconographyFill & IconographyOutlined
    public let mailClose: IconographyFill & IconographyOutlined
    public let mailOpen: IconographyFill & IconographyOutlined
    public let delivery: IconographyFill & IconographyOutlined
    public let mondialRelay: IconographyImage
    public let colissimo: IconographyImage
    public let shop2Shop: IconographyImage
    public let laposte: IconographyImage

    // MARK: - Init

    public init(deliveryFast: IconographyFill & IconographyOutlined,
                deliveryHands: IconographyFill & IconographyOutlined,
                box: IconographyFill & IconographyOutlined,
                deliveryTruck: IconographyFill & IconographyOutlined,
                mailClose: IconographyFill & IconographyOutlined,
                mailOpen: IconographyFill & IconographyOutlined,
                delivery: IconographyFill & IconographyOutlined,
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
