//
//  IconographyAlertDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyAlertDefault: IconographyAlert {

    // MARK: - Properties

    public let alert: IconographyFilled & IconographyOutlined
    public let question: IconographyFilled & IconographyOutlined
    public let info: IconographyFilled & IconographyOutlined
    public let warning: IconographyFilled & IconographyOutlined
    public let block: IconographyImage

    // MARK: - Init

    public init(alert: IconographyFilled & IconographyOutlined,
                question: IconographyFilled & IconographyOutlined,
                info: IconographyFilled & IconographyOutlined,
                warning: IconographyFilled & IconographyOutlined,
                block: IconographyImage) {
        self.alert = alert
        self.question = question
        self.info = info
        self.warning = warning
        self.block = block
    }
}
