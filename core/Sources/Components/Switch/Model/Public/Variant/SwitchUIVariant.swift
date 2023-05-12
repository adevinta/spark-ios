//
//  SwitchUIVariant.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

/// The variant of the UIKit switch.
public struct SwitchUIVariant {

    // MARK: - Properties

    let onImage: UIImage
    let offImage: UIImage

    // MARK: - Initialization

    public init(onImage: UIImage,
                offImage: UIImage) {
        self.onImage = onImage
        self.offImage = offImage
    }
}
