//
//  DynamicTypeSize+InfoExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

extension DynamicTypeSize {

    var info: String {
        switch self {
        case .large: " (default)"
        default: ""
        }
    }
}
