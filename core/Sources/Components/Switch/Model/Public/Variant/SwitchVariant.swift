//
//  SwitchVariant.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// The variant of the switch.
public struct SwitchVariant {

    // MARK: - Properties

    let onImage: Image?
    let offImage: Image?

    let onUIImage: UIImage?
    let offUIImage: UIImage?

    // MARK: - Initialization

    public init(onImage: Image,
                offImage: Image) {
        self.onImage = onImage
        self.offImage = offImage

        self.onUIImage = nil
        self.offUIImage = nil
    }

    public init(onImage: UIImage,
                offImage: UIImage) {
        self.onImage = nil
        self.offImage = nil

        self.onUIImage = onImage
        self.offUIImage = offImage
    }
}
