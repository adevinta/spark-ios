//
//  IconographyOptionsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyOptionsDefault: IconographyOptions {

    // MARK: - Properties

    public let clock: IconographyFilled & IconographyOutlined
    public let flash: IconographyFilled & IconographyOutlined
    public let bookmark: IconographyFilled & IconographyOutlined
    public let star: IconographyFilled & IconographyOutlined
    public let clockArrow: IconographyDown & IconographyUp
    public let moveUp: IconographyImage

    // MARK: - Init

    public init(clock: IconographyFilled & IconographyOutlined,
                  flash: IconographyFilled & IconographyOutlined,
                  bookmark: IconographyFilled & IconographyOutlined,
                  star: IconographyFilled & IconographyOutlined,
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
