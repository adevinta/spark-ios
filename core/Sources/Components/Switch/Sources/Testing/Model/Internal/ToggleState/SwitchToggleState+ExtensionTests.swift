//
//  SwitchToggleState.swift
//  SparkCore
//
//  Created by robin.lemaire on 24/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
@testable import SparkCore

extension SwitchToggleState {

    // MARK: - Properties

    static func mocked(
        interactionEnabled: Bool = true,
        opacity: CGFloat = 1.0
    ) -> Self {
        return .init(
            interactionEnabled: interactionEnabled,
            opacity: opacity
        )
    }
}
