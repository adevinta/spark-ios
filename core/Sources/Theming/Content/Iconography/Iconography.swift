//
//  Iconography.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

import UIKit
import SwiftUI

public protocol Iconography {

}

// MARK: - Style

public protocol IconographyFill {
    var fill: IconographyImage { get }
}

public protocol IconographyOutlined {
    var outlined: IconographyImage { get }
}

// MARK: - Image

public protocol IconographyImage {
    var image: UIImage? { get }
    var swiftUIImage: Image { get }
}
