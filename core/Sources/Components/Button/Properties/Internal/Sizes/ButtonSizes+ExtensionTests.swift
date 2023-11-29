//
//  ButtonSizes.swift
//  SparkCore
//
//  Created by robin.lemaire on 30/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension ButtonSizes {

    // MARK: - Properties

    static func mocked(
        height: CGFloat = 30,
        imageSize: CGFloat = 20
    ) -> Self {
        return .init(
            height: height,
            imageSize: imageSize
        )
    }
}
