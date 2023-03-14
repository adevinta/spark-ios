//
//  IconographyImages.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyImages {
    var camera: IconographyFilled & IconographyOutlined { get }
    var addImage: IconographyFilled & IconographyOutlined { get }
    var gallery: IconographyFilled & IconographyOutlined { get }
    var add: IconographyFilled & IconographyOutlined { get }
    var image: IconographyFilled & IconographyOutlined { get }
    var noPhoto: IconographyImage { get }
    var rotateImage: IconographyImage { get }
}
