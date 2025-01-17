//
//  Iconography.swift
//  SparkDemo
//
//  Created by robin.lemaire on 16/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

enum Iconography: String, CaseIterable {
    case arrowRight = "ArrowRight"
    case check = "Check"
    case cross = "Cross"
    case infoOutline = "InfoOutline"
    case warningFill = "WarningFill"
}

// MARK: - SwiftUI Extensions

extension Image {

    init(_ iconography: Iconography) {
        self.init(iconography.rawValue)
    }
}

extension UIImage {

    convenience init(_ iconography: Iconography) {
        self.init(named: iconography.rawValue)!
    }
}
