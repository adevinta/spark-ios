//
//  IconographyToggleDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyToggleDefault: IconographyToggle {

    // MARK: - Properties

    public let valid: IconographyFill & IconographyOutlined
    public let add: IconographyFill & IconographyOutlined
    public let remove: IconographyFill & IconographyOutlined
    public let check: IconographyImage
    public let doubleCheck: IconographyImage

    // MARK: - Init

    public init(valid: IconographyFill & IconographyOutlined,
                add: IconographyFill & IconographyOutlined,
                remove: IconographyFill & IconographyOutlined,
                check: IconographyImage,
                doubleCheck: IconographyImage) {
        self.valid = valid
        self.add = add
        self.remove = remove
        self.check = check
        self.doubleCheck = doubleCheck
    }
}
