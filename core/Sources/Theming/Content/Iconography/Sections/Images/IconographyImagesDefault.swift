//
//  IconographyImagesDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyImagesDefault: IconographyImages {

    // MARK: - Properties

    public let camera: IconographyFill & IconographyOutlined
    public let addImage: IconographyFill & IconographyOutlined
    public let gallery: IconographyFill & IconographyOutlined
    public let add: IconographyFill & IconographyOutlined
    public let image: IconographyFill & IconographyOutlined
    public let noPhoto: IconographyImage
    public let rotateImage: IconographyImage

    // MARK: - Init

    public init(camera: IconographyFill & IconographyOutlined,
                addImage: IconographyFill & IconographyOutlined,
                gallery: IconographyFill & IconographyOutlined,
                add: IconographyFill & IconographyOutlined,
                image: IconographyFill & IconographyOutlined,
                noPhoto: IconographyImage,
                rotateImage: IconographyImage) {
        self.camera = camera
        self.addImage = addImage
        self.gallery = gallery
        self.add = add
        self.image = image
        self.noPhoto = noPhoto
        self.rotateImage = rotateImage
    }
}
