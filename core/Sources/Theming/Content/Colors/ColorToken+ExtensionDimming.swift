//
//  ColorToken+ExtensionDimming.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - Dimming
extension ColorToken {
    func dimmed(_ dim: CGFloat) -> ColorToken {
        return ColorTokenDimmed(colorToken: self, dim: dim)
    }
}
