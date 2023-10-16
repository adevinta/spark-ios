//
//  SwitchImagesState+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore
import UIKit

extension SwitchImagesState {

    // MARK: - Properties

    static func mocked(
        currentImage: ImageEither = .left(IconographyTests.shared.switchOn),
        images: SwitchImagesEither = .left(SwitchUIImages(
            on: IconographyTests.shared.switchOn,
            off: IconographyTests.shared.switchOff
        )),
        onImageOpacity: Double = 1,
        offImageOpacity: Double = 0
    ) -> Self {
        return .init(
            currentImage: currentImage,
            images: images,
            onImageOpacity: onImageOpacity,
            offImageOpacity: offImageOpacity
        )
    }
}
