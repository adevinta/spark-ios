//
//  BadgeComponentView.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark

extension BadgeFormat {
    enum Names {
        static let `default` = "Default"
        static let custom = "Custom"
        static let overflowCounter = "Overflow Counter"
    }

    var name: String {
        switch self {
        case .default: return Names.default
        case .custom: return Names.custom
        case .overflowCounter: return Names.overflowCounter
        @unknown default:
            fatalError("Unknown Badge Format")
        }
    }
}
