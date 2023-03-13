//
//  IconographyMapDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyMapDefault: IconographyMap {
    
    // MARK: - Properties

    public let threeSixty: IconographyImage
    public let bike: IconographyImage
    public let allDirections: IconographyImage
    public let expand: IconographyImage
    public let target: IconographyFilled & IconographyOutlined
    public let pin: IconographyFilled & IconographyOutlined
    public let cursor: IconographyFilled & IconographyOutlined
    public let train: IconographyFilled & IconographyOutlined
    public let hotel: IconographyFilled & IconographyOutlined
    public let walker: IconographyFilled & IconographyOutlined
    public let car: IconographyFilled & IconographyOutlined

    // MARK: - Init

    public init(threeSixty: IconographyImage,
                bike: IconographyImage,
                allDirections: IconographyImage,
                expand: IconographyImage,
                target: IconographyFilled & IconographyOutlined,
                pin: IconographyFilled & IconographyOutlined,
                cursor: IconographyFilled & IconographyOutlined,
                train: IconographyFilled & IconographyOutlined,
                hotel: IconographyFilled & IconographyOutlined,
                walker: IconographyFilled & IconographyOutlined,
                car: IconographyFilled & IconographyOutlined) {
        self.threeSixty = threeSixty
        self.bike = bike
        self.allDirections = allDirections
        self.expand = expand
        self.target = target
        self.pin = pin
        self.cursor = cursor
        self.train = train
        self.hotel = hotel
        self.walker = walker
        self.car = car
    }
}
