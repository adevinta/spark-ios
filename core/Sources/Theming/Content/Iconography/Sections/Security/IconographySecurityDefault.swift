//
//  IconographySecurityDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographySecurityDefault: IconographySecurity {

    // MARK: - Properties

    public let idea: IconographyFill & IconographyOutlined
    public let lock: IconographyFill & IconographyOutlined
    public let unlock: IconographyFill & IconographyOutlined

    // MARK: - Init

    public init(idea: IconographyFill & IconographyOutlined,
                lock: IconographyFill & IconographyOutlined,
                unlock: IconographyFill & IconographyOutlined) {
        self.idea = idea
        self.lock = lock
        self.unlock = unlock
    }
}
