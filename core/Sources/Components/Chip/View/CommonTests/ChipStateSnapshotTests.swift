//
//  ChipStateSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by michael.zimmermann on 26.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@testable import SparkCore

extension ChipState {
    static let all: [ChipState] =
    [
        .init(isEnabled: true, isPressed: false, isSelected: true),
        .init(isEnabled: false, isPressed: false, isSelected: true),
        .init(isEnabled: false, isPressed: false, isSelected: false),
    ]
}
