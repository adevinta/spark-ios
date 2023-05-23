//
//  ColorTokenDimmed.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 23.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - Dimmed Token

public struct ColorTokenDimmed: ColorToken {

    // MARK: - Properties

    private let colorToken: ColorToken
    private let dim: CGFloat

    // MARK: - Initialization

    public init(colorToken: ColorToken, dim: CGFloat) {
        self.colorToken = colorToken
        self.dim = dim
    }

    public var uiColor: UIColor {
        return self.colorToken.uiColor.withAlphaComponent(self.dim)
    }

    public var color: Color {
        return self.colorToken.color.opacity(self.dim)
    }
}
