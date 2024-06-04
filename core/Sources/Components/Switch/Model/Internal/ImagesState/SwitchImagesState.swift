//
//  SwitchImagesState.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkCommon

struct SwitchImagesState: Equatable {

    // MARK: - Properties

    let currentImage: ImageEither
    let images: SwitchImagesEither
    let onImageOpacity: Double
    var offImageOpacity: Double
}
