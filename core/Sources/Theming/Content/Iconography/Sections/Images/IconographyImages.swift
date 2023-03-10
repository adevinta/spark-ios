//
//  IconographyImages.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public protocol IconographyImages {
    var camera: IconographyFill & IconographyOutlined { get }
    var addImage: IconographyFill & IconographyOutlined { get }
    var gallery: IconographyFill & IconographyOutlined { get }
    var add: IconographyFill & IconographyOutlined { get }
    var image: IconographyFill & IconographyOutlined { get }
    var noPhoto: IconographyImage { get }
    var rotateImage: IconographyImage { get }
}
