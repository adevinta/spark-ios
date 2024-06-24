//
//  TabBackgroundLine.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 17.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI

struct TabBackgroundLine: View {
    let lineHeight: CGFloat
    let width: CGFloat
    let color: Color

    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: self.lineHeight)
            .frame(width: self.width)
            .foregroundColor(self.color)

    }
}
