//
//  SwitchPosition.swift
//  SparkCore
//
//  Created by robin.lemaire on 15/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension SwitchPosition {

    // MARK: - Properties

    static func mocked(
        isToggleOnLeft: Bool = true,
        horizontalSpacing: CGFloat = 10
    ) -> Self {
        return .init(
            isToggleOnLeft: isToggleOnLeft,
            horizontalSpacing: horizontalSpacing
        )
    }
}
