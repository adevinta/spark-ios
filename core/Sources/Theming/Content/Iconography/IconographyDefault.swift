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

    private let imageName: String
    private let bundle: Bundle?

    public var image: UIImage? {
        return UIImage(named: self.imageName, in: self.bundle, with: nil)
    }
    public var swiftUIImage: Image {
        return Image(self.imageName, bundle: self.bundle)
    }

    // MARK: - Initialization

    public init(named imageName: String, in bundle: Bundle?) {
        self.imageName = imageName
        self.bundle = bundle
    }
}
