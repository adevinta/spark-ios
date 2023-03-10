//
//  IconographyOptionsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyOptionsDefault: IconographyOptions {

    // MARK: - Properties

    public let clock: IconographyFill & IconographyOutlined
    public let flash: IconographyFill & IconographyOutlined
    public let bookmark: IconographyFill & IconographyOutlined
    public let star: IconographyFill & IconographyOutlined
    public let clockArrow: IconographyDown & IconographyUp
    public let moveUp: IconographyImage

    // MARK: - Init

    public init(clock: IconographyFill & IconographyOutlined,
                  flash: IconographyFill & IconographyOutlined,
                  bookmark: IconographyFill & IconographyOutlined,
                  star: IconographyFill & IconographyOutlined,
                  clockArrow: IconographyDown & IconographyUp,
                  moveUp: IconographyImage) {
        self.clock = clock
        self.flash = flash
        self.bookmark = bookmark
        self.star = star
        self.clockArrow = clockArrow
        self.moveUp = moveUp
    }
}
