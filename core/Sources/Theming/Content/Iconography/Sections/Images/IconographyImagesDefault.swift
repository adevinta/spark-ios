//
//  IconographyImagesDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 10/03/2023.
//

import Foundation

public struct IconographyImagesDefault: IconographyImages {

    // MARK: - Properties

    public let camera: IconographyFilled & IconographyOutlined
    public let addImage: IconographyFilled & IconographyOutlined
    public let gallery: IconographyFilled & IconographyOutlined
    public let add: IconographyFilled & IconographyOutlined
    public let image: IconographyFilled & IconographyOutlined
    public let noPhoto: IconographyImage
    public let rotateImage: IconographyImage

    // MARK: - Init

    public init(camera: IconographyFilled & IconographyOutlined,
                addImage: IconographyFilled & IconographyOutlined,
                gallery: IconographyFilled & IconographyOutlined,
                add: IconographyFilled & IconographyOutlined,
                image: IconographyFilled & IconographyOutlined,
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
