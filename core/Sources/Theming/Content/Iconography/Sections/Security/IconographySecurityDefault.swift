//
//  IconographySecurityDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographySecurityDefault: IconographySecurity {

    // MARK: - Properties

    public let idea: IconographyFilled & IconographyOutlined
    public let lock: IconographyFilled & IconographyOutlined
    public let unlock: IconographyFilled & IconographyOutlined

    // MARK: - Init

    public init(idea: IconographyFilled & IconographyOutlined,
                lock: IconographyFilled & IconographyOutlined,
                unlock: IconographyFilled & IconographyOutlined) {
        self.idea = idea
        self.lock = lock
        self.unlock = unlock
    }
}
