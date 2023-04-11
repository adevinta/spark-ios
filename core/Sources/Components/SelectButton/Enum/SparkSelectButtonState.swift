//
//  SparkSelectButtonState.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public enum SparkSelectButtonState: Equatable, Hashable {
    case enabled
    case disabled

    case success(message: String)
    case warning(message: String)
    case error(message: String)
}
