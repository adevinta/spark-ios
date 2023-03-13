//
//  IconographyOthersDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyOthersDefault: IconographyOthers {

    // MARK: - Properties

    public let megaphone: IconographyFilled & IconographyOutlined
    public let speedmeter: IconographyFilled & IconographyOutlined
    public let dissatisfied: IconographyFilled & IconographyOutlined
    public let flag: IconographyFilled & IconographyOutlined
    public let satisfied: IconographyFilled & IconographyOutlined
    public let neutral: IconographyFilled & IconographyOutlined
    public let sad: IconographyFilled & IconographyOutlined
    public let fire: IconographyFilled & IconographyOutlined
    public let euro: IconographyImage
    public let refund: IconographyImage
    public let sun: IconographyImage

    // MARK: - Init

    public init(megaphone: IconographyFilled & IconographyOutlined,
                speedmeter: IconographyFilled & IconographyOutlined,
                dissatisfied: IconographyFilled & IconographyOutlined,
                flag: IconographyFilled & IconographyOutlined,
                satisfied: IconographyFilled & IconographyOutlined,
                neutral: IconographyFilled & IconographyOutlined,
                sad: IconographyFilled & IconographyOutlined,
                fire: IconographyFilled & IconographyOutlined,
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
