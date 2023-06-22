//
//  FullColorToken.swift
//  SparkCore
//
//  Created by robin.lemaire on 07/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// sourcery: AutoMockable
protocol FullColorToken {
    var uiColor: UIColor { get }
    var color: Color { get }
}

struct FullColorTokenDefault: FullColorToken {

    // MARK: - Private Properties

    var uiColor: UIColor {
        return self.colorToken.uiColor.withAlphaComponent(self.opacity)
    }

    var color: Color {
        return self.colorToken.color.opacity(self.opacity)
    }

    // MARK: - Public Properties

    private let colorToken: ColorToken
    private let opacity: CGFloat

    // MARK: - Initialization

    init(colorToken: ColorToken, opacity: CGFloat) {
        self.colorToken = colorToken
        self.opacity = opacity
    }
}
