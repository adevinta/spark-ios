//
//  SwitchVariant.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

/// The variant of the SwitUI switch.
public struct SwitchVariant {

    // MARK: - Properties

    let onImage: Image
    let offImage: Image

    // MARK: - Initialization

    public init(onImage: Image,
                offImage: Image) {
        self.onImage = onImage
        self.offImage = offImage
    }
}
