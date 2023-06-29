//
//  SwitchVariant.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchVariantable {
    var onImage: SwitchImage { get }
    var offImage: SwitchImage { get }

    func toImages() -> SwitchVariantImages
    func toUIImages() -> SwitchUIVariantImages
}

struct SwitchVariant: SwitchVariantable {

    // MARK: - Properties

    let onImage: SwitchImage
    let offImage: SwitchImage

    // MARK: - Initialization

    init?(images: SwitchVariantImages?) {
        guard let images else { return nil }

        self.onImage = .right(images.on)
        self.offImage = .right(images.off)
    }

    init?(images: SwitchUIVariantImages?) {
        guard let images else { return nil }
        
        self.onImage = .left(images.on)
        self.offImage = .left(images.off)
    }

    // MARK: - Conversion

    func toImages() -> SwitchVariantImages {
        return (
            on: self.onImage.rightValue,
            off: self.offImage.rightValue
        )
    }

    func toUIImages() -> SwitchUIVariantImages {
        return (
            on: self.onImage.leftValue,
            off: self.offImage.leftValue
        )
    }
}
