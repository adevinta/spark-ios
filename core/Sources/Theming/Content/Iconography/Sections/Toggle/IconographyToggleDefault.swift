//
//  IconographyToggleDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyToggleDefault: IconographyToggle {

    // MARK: - Properties

    public let valid: IconographyFilled & IconographyOutlined
    public let add: IconographyFilled & IconographyOutlined
    public let remove: IconographyFilled & IconographyOutlined
    public let check: IconographyImage
    public let doubleCheck: IconographyImage

    // MARK: - Init

    public init(valid: IconographyFilled & IconographyOutlined,
                add: IconographyFilled & IconographyOutlined,
                remove: IconographyFilled & IconographyOutlined,
                check: IconographyImage,
                doubleCheck: IconographyImage) {
        self.valid = valid
        self.add = add
        self.remove = remove
        self.check = check
        self.doubleCheck = doubleCheck
    }
}
