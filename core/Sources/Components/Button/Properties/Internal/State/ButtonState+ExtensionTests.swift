//
//  ButtonState.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension ButtonState {

    // MARK: - Properties

    static func mocked(
        isUserInteractionEnabled: Bool = true,
        opacity: CGFloat = 1.0
    ) -> Self {
        return .init(
            isUserInteractionEnabled: isUserInteractionEnabled,
            opacity: opacity
        )
    }
}
