//
//  ColorTokenGeneratedMock.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

extension ColorTokenGeneratedMock {

    // MARK: - Methods
    
    static func random() -> ColorTokenGeneratedMock {
        let color = ColorTokenGeneratedMock()
        let random = UIColor.random()
        color.underlyingUiColor = random
        color.underlyingColor = Color(random)
        return color
    }
}

// MARK: - Private extension

private extension UIColor {
    static func random(
        hue: CGFloat = CGFloat.random(in: 0...1),
        saturation: CGFloat = CGFloat.random(in: 0.5...1), // from 0.5 to 1.0 to stay away from white
        brightness: CGFloat = CGFloat.random(in: 0.5...1), // from 0.5 to 1.0 to stay away from black
        alpha: CGFloat = 1
    ) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}
