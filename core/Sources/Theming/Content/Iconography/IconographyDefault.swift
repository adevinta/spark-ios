//
//  IconographyDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit
import SwiftUI

public struct IconographyDefault: Iconography {}

// MARK: - Style

public struct IconographyFillDefault: IconographyFill {

    // MARK: - Properties

    public let fill: IconographyImage

    // MARK: - Initialization

    public init(fill: IconographyImage) {
        self.fill = fill
    }
}

public struct IconographyOutlinedDefault: IconographyOutlined {

    // MARK: - Properties

    public let outlined: IconographyImage

    // MARK: - Initialization

    public init(outlined: IconographyImage) {
        self.outlined = outlined
    }
}

// MARK: - Image

public struct IconographyImageDefault: IconographyImage {

    // MARK: - Properties

    public let image: UIImage
    public let swiftUIImage: Image

    // MARK: - Initialization

    public init(image: UIImage, swiftUIImage: Image) {
        self.image = image
        self.swiftUIImage = swiftUIImage
    }
}
