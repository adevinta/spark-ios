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
        let uiColor = self.uiColor
        let color = self.color

        return ColorTokenDefault(color: color.opacity(dim), uiColor: uiColor.withAlphaComponent(dim))
    }
}
