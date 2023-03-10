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
    public let target: IconographyFill & IconographyOutlined
    public let pin: IconographyFill & IconographyOutlined
    public let cursor: IconographyFill & IconographyOutlined
    public let train: IconographyFill & IconographyOutlined
    public let hotel: IconographyFill & IconographyOutlined
    public let walker: IconographyFill & IconographyOutlined
    public let car: IconographyFill & IconographyOutlined

    // MARK: - Init

    public init(threeSixty: IconographyImage,
                bike: IconographyImage,
                allDirections: IconographyImage,
                expand: IconographyImage,
                target: IconographyFill & IconographyOutlined,
                pin: IconographyFill & IconographyOutlined,
                cursor: IconographyFill & IconographyOutlined,
                train: IconographyFill & IconographyOutlined,
                hotel: IconographyFill & IconographyOutlined,
                walker: IconographyFill & IconographyOutlined,
                car: IconographyFill & IconographyOutlined) {
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
