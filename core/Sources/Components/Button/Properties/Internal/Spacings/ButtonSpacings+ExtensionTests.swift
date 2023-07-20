//
//  ButtonSpacings.swift
//  SparkCore
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension ButtonSpacings {

    // MARK: - Properties

    static func mocked(
        verticalSpacing: CGFloat = 10,
        horizontalSpacing: CGFloat = 11,
        horizontalPadding: CGFloat = 12
    ) -> Self {
        return .init(
            verticalSpacing: verticalSpacing,
            horizontalSpacing: horizontalSpacing,
            horizontalPadding: horizontalPadding
        )
    }
}
