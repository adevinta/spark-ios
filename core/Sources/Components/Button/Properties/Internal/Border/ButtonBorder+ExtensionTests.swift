//
//  ButtonBorder.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension ButtonBorder {

    // MARK: - Properties

    static func mocked(
        width: CGFloat = 2,
        radius: CGFloat = 8
    ) -> Self {
        return .init(
            width: width,
            radius: radius
        )
    }
}
