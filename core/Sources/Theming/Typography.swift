//
//  Typography.swift
//  Spark
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit

public struct SparkFont {
    public let font: UIFont

    public init(font: UIFont) {
        self.font = font
    }
}

public struct Typography {
    public let display1: SparkFont
    public let display2: SparkFont
    public let display3: SparkFont

    public let headline1: SparkFont
    public let headline2: SparkFont

    public let subhead: SparkFont

    public let body: SparkFont
    public let bodyBold: SparkFont

    public let caption: SparkFont
    public let captionBold: SparkFont

    public let small: SparkFont
    public let smallBold: SparkFont

    public init(display1: SparkFont,
                display2: SparkFont,
                display3: SparkFont,
                headline1: SparkFont,
                headline2: SparkFont,
                subhead: SparkFont,
                body: SparkFont,
                bodyBold: SparkFont,
                caption: SparkFont,
                captionBold: SparkFont,
                small: SparkFont,
                smallBold: SparkFont) {
        self.display1 = display1
        self.display2 = display2
        self.display3 = display3
        self.headline1 = headline1
        self.headline2 = headline2
        self.subhead = subhead
        self.body = body
        self.bodyBold = bodyBold
        self.caption = caption
        self.captionBold = captionBold
        self.small = small
        self.smallBold = smallBold
    }
}
