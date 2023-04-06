//
//  SparkCheckboxState.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public enum SparkCheckboxState {
    case enabled
    case disabled
    case hover // probably not needed
    case focused
    case pressed

    case success
    case warning
    case error
}
