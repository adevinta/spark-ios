//
//  IconographyAlertDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyAlertDefault: IconographyAlert {

    // MARK: - Properties

    public let alert: IconographyFill & IconographyOutlined
    public let question: IconographyFill & IconographyOutlined
    public let info: IconographyFill & IconographyOutlined
    public let warning: IconographyFill & IconographyOutlined
    public let block: IconographyImage

    // MARK: - Init

    public init(alert: IconographyFill & IconographyOutlined,
                question: IconographyFill & IconographyOutlined,
                info: IconographyFill & IconographyOutlined,
                warning: IconographyFill & IconographyOutlined,
                block: IconographyImage) {
        self.alert = alert
        self.question = question
        self.info = info
        self.warning = warning
        self.block = block
    }
}
