//
//  View+ElevationShadow.swift
//  SparkCore
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

public extension View {
    func shadow(_ shadow: ElevationShadow) -> some View {
        return self.shadow(color: shadow.color.swiftUIColor.opacity(Double(shadow.opacity)),
                           radius: shadow.blur,
                           x: shadow.offset.x,
                           y: shadow.offset.y)
    }
}
