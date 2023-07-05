//
//  RadioButtonState.swift
//  SparkCore
//
//  Created by michael.zimmermann on 28.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@frozen
public enum RadioButtonGroupState: Equatable, Hashable, CaseIterable {
    case enabled
    case disabled

    case success
    case warning
    case error
}
