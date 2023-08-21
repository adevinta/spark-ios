//
//  ChipState.swift
//  SparkCore
//
//  Created by michael.zimmermann on 21.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ChipState {

    static let `default` = ChipState(isEnabled: true, isPressed: false)

    let isEnabled: Bool
    let isPressed: Bool

    var isDisabled: Bool {
        return !self.isEnabled
    }
}
