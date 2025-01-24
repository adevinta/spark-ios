//
//  View+FrameExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 24/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

extension View {

    func frame<Configuration: ComponentConfiguration>(
        from configuration: Configuration
    ) -> some View {
        self.frame(
            width: configuration.width.value(),
            height: configuration.height.value()
        )
        .frame(
            minWidth: configuration.width.minValue(),
            maxWidth: configuration.width.maxValue(),
            minHeight: configuration.height.minValue(),
            maxHeight: configuration.height.maxValue()
        )
    }
}
