//
//  View+BackgroundExtension.swift
//  SparkDemo
//
//  Created by robin.lemaire on 23/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SwiftUI

extension View {

    @ViewBuilder
    func demoBackground(
        _ configuration: ComponentConfiguration,
        forceRoundedBackground: Bool = false
    ) -> some View {
        if (configuration.isInvertedBackground() && !forceRoundedBackground) || (!configuration.isInvertedBackground() && forceRoundedBackground) {
            self.padding(.all, .small)
                .background(.gray.opacity(0.2))
                .radius(.medium)
        } else {
            self
        }
    }
}
