//
//  SelectButtonState.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@frozen
public enum SelectButtonState: Equatable, Hashable {
    case enabled
    case disabled
    case accent
    case basic

    case success(message: String)
    case warning(message: String)
    case error(message: String)
}
