//
//  IconographyOthersDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyOthersDefault: IconographyOthers {

    // MARK: - Properties

    public let megaphone: IconographyFill & IconographyOutlined
    public let speedmeter: IconographyFill & IconographyOutlined
    public let dissatisfied: IconographyFill & IconographyOutlined
    public let flag: IconographyFill & IconographyOutlined
    public let satisfied: IconographyFill & IconographyOutlined
    public let neutral: IconographyFill & IconographyOutlined
    public let sad: IconographyFill & IconographyOutlined
    public let fire: IconographyFill & IconographyOutlined
    public let euro: IconographyImage
    public let refund: IconographyImage
    public let sun: IconographyImage

    // MARK: - Init

    public init(megaphone: IconographyFill & IconographyOutlined,
                speedmeter: IconographyFill & IconographyOutlined,
                dissatisfied: IconographyFill & IconographyOutlined,
                flag: IconographyFill & IconographyOutlined,
                satisfied: IconographyFill & IconographyOutlined,
                neutral: IconographyFill & IconographyOutlined,
                sad: IconographyFill & IconographyOutlined,
                fire: IconographyFill & IconographyOutlined,
                euro: IconographyImage,
                refund: IconographyImage,
                sun: IconographyImage) {
        self.megaphone = megaphone
        self.speedmeter = speedmeter
        self.dissatisfied = dissatisfied
        self.flag = flag
        self.satisfied = satisfied
        self.neutral = neutral
        self.sad = sad
        self.fire = fire
        self.euro = euro
        self.refund = refund
        self.sun = sun
    }
}
